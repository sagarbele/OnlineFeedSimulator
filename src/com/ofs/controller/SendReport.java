package com.ofs.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ofs.model.AnimalData;
import com.ofs.model.AnimalList;
import com.ofs.model.AquacultureData;
import com.ofs.model.CountryDetail;
import com.ofs.model.Property;
import com.ofs.service.AnimalListService;
import com.ofs.service.AnimalService;
import com.ofs.service.AquacultureService;
import com.ofs.service.CountryService;
import com.ofs.service.PropertyService;

/**
 * @author Sagar, Amit
 * 
 */
@Controller
public class SendReport {

	@Autowired
	private AnimalService animalService;

	@Autowired
	private AquacultureService aquacultureService;

	@Autowired
	private CountryService countryService;

	@Autowired
	private AnimalListService animalListService;

	@Autowired
	private PropertyService propertyService;

	/*
	 * @RequestMapping(value = "/index", method = RequestMethod.GET) public
	 * ModelAndView welcome() { return new ModelAndView("index"); }
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/reportChanges", method = RequestMethod.POST)
	public String getAllData(
			@RequestParam(value = "country", required = false) Integer countryId,
			@RequestParam(value = "unitIndex", required = false) String unitIndex,
			@RequestParam(value = "property", required = false) String propertyName,
			@RequestParam(value = "name", required = false) String reporterName,
			@RequestParam(value = "email", required = false) String reporterEmail,
			@RequestParam(value = "commnet", required = false) String reporterComments,
			@RequestParam(value = "perChngAnmCount", required = false) String perChngAnmCount,
			@RequestParam(value = "perChngNonForgRat", required = false) String perChngNonForgRat,
			@RequestParam(value = "perChngUtIdx", required = false) String perChngUtIdx,
			Model model) {
		
	
		/*
		 * Get Property Value
		 */
		String propertyType = "";
		if (unitIndex.equals("Energy")) {
			propertyType = "ENERGY (MJ/kg)";
		}

		if (unitIndex.equals("Protein")) {
			propertyType = "PROTEIN (%)";
		}
		
		List<Property> propertyList = propertyService.getPropertyData(
				propertyName, propertyType);
		String propertyValue = "";
		for (Property pdata : propertyList) {
			propertyValue = pdata.getPropertyValue();
		}
		if(propertyName.equals("None")){
			propertyValue="1";
		}
		
		/*
		 * Get Animal Data for selected countries
		 */
		List<AnimalData> animalData = animalService.getAnimalData(countryId);

		/*
		 * Get list of countries with country Name
		 */
		String countryName=""; 
		List<CountryDetail> countryList = countryService.getCountryData(countryId);
		for(CountryDetail cData :countryList){
			countryName=cData.getCountryName();
		}
		
		
		/*
		 * Get Year List
		 */
		List<Integer> yearList = animalService.getYearList();
		
		/*
		 * Get Animal Name list
		 */
		List<String> animalNameList = animalListService.getAnimalNameList();
		
		/*
		 * Get Aquaculture Data for selected countries
		 */
		List<AquacultureData> aquacultureData = aquacultureService
				.getAquacultureData(countryId);

		
		String perChngAnmList [];
		perChngAnmList = perChngAnmCount.split(":");
		
		String perChngNonForgRatList [];
		perChngNonForgRatList = perChngNonForgRat.split(":");
		
		String perChngUtIdxList [];
		perChngUtIdxList = perChngUtIdx.split(":");
				
		String mailMessage;
        mailMessage = "<html>\n";

                //----------------------------------ADD HEADER TO THE STATUS REPORT MAIL---------------------------//

                mailMessage = mailMessage + "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n" +
                        "<html>\n" +
                        "<body style=\"font-family: georgia; font-size: 12px;\">\n" +
                        "<style type=\"text/css\">\n" +
                        ".bordered tr:hover { background: #fbf8e9 !important; -o-transition: all 0.1s ease-in-out !important; -webkit-transition: all 0.1s ease-in-out !important; -moz-transition: all 0.1s ease-in-out !important; -ms-transition: all 0.1s ease-in-out !important; transition: all 0.1s ease-in-out !important; }\n" +
                        ".fitler-table .quick:hover { text-decoration: underline !important; }\n" +
                        "></style>\n" +
                        "<h3 style=\"font-family: georgia;\"> FAO Report Modification</h3>\n" ;

                //----------------------------------ADD BODY ELEMENTS TO THE STATUS REPORT MAIL---------------------------//

                mailMessage = mailMessage
                			+ "<table><tr><th style='text-align: left;' colspan='2'>Reporter Information</th></tr>"
                			+ "<tr><td style='text-align: left;'>Reporter Name</td><td style='text-align: left;'>:"+reporterName+"</td></tr>"	
                			+ "<tr><td style='text-align: left;'>Reporter Email</td><td style='text-align: left;'>:"+reporterEmail+"</td></tr>"
    						+ "<tr><td style='text-align: left;'>Reporter Comments</td><td style='text-align: left;'>:"+reporterComments+"</td></tr>"
    						+ "</table>";

                
        		if (unitIndex.equals("Energy")) {
                mailMessage = mailMessage
        				+ "<table><tr><th style='text-align: center;' colspan='5' style='color: lightseagreen'>"
        				+ countryName
        				+ "</th></tr>"
        				+ "<tr><th style='text-align: center;'> Year </th><th style='text-align: center;'> Old Data (1000 GJ)</th><th style='text-align: center;'> New Data (1000 GJ)</th></tr>";
        		}
        		else{
        			mailMessage = mailMessage
            				+ "<table><tr><th style='text-align: center;' colspan='5' style='color: lightseagreen'>"
            				+ countryName
            				+ "</th></tr>"
            				+ "<tr><th style='text-align: center;'> Year </th><th style='text-align: center;'> Old Data (1000 MT)</th><th style='text-align: center;'> New Data (1000 MT)</th></tr>";
        		}
		
		
		
		Integer yearNo=0;		
		int yearListSize =  yearList.size();
		for (int yearIndex=0;yearIndex < yearListSize ; yearIndex++) {
			BigDecimal nutrition = new BigDecimal(0);
			BigDecimal nutritionNew = new BigDecimal(0);
			yearNo = yearList.get(yearIndex);
	
			for ( AnimalData anmd : animalData) {
				if (countryName.equals(anmd.getCountryDetail().getCountryName())) {
					if (yearNo.equals(anmd.getYear())) {
						if (unitIndex.equals("Energy")) {
							BigDecimal energyIndex = anmd.getEnergyUnitIndex();

							if (!energyIndex.equals(null)) {
								nutrition = nutrition.add((anmd.getNonForageRate().multiply(energyIndex).multiply(new BigDecimal(anmd.getAnimalCount()))));
	
							}

						} else {

							BigDecimal proteinIndex = anmd.getProteinUnitIndex();
							if (!proteinIndex.equals(null)) {
								nutrition = nutrition.add((anmd.getNonForageRate().multiply(proteinIndex).multiply(new BigDecimal(anmd.getAnimalCount()))));
							}

						}

					}
				}
			}

			String animalName="";
			int animalListSize = animalNameList.size() ;
			for (int animalIndex=0 ; animalIndex < animalListSize; animalIndex++) {
					animalName = animalNameList.get(animalIndex);
				
				for (AnimalData anmd : animalData) {
					if (countryName.equals(anmd.getCountryDetail().getCountryName())) {					
						if(animalName.equals(anmd.getAnimalList().getAnimalName())){
						
							BigDecimal animalCountPer = new BigDecimal(perChngAnmList[animalIndex]);
							BigDecimal nfgPer = new BigDecimal(perChngNonForgRatList[animalIndex]);
							BigDecimal unitIndexPer = new BigDecimal(perChngUtIdxList[animalIndex]);
									
							if (yearNo.equals(anmd.getYear())) {
							if (unitIndex.equals("Energy")) {
								BigDecimal energyIndex = anmd.getEnergyUnitIndex();
								if (!energyIndex.equals(null)) {
									
									
									BigDecimal animalCountVal = new BigDecimal(anmd.getAnimalCount()).add( ((new BigDecimal(anmd.getAnimalCount())).multiply(animalCountPer)).divide(new BigDecimal(100)));
									BigDecimal nfgVal = anmd.getNonForageRate().add( ((anmd.getNonForageRate()).multiply(nfgPer)).divide(new BigDecimal(100)));
									BigDecimal unitIndexVal = anmd.getEnergyUnitIndex().add( ((anmd.getEnergyUnitIndex()).multiply(unitIndexPer)).divide(new BigDecimal(100)));
									
									nutritionNew = nutritionNew.add((nfgVal.multiply(unitIndexVal).multiply(animalCountVal)));
								}

							} else {
								
								BigDecimal proteinIndex = anmd.getProteinUnitIndex();
								if (!proteinIndex.equals(null)) {
									
									BigDecimal animalCountVal = new BigDecimal(anmd.getAnimalCount()).add( ((new BigDecimal(anmd.getAnimalCount())).multiply(animalCountPer)).divide(new BigDecimal(100)));
									BigDecimal nfgVal = anmd.getNonForageRate().add( ((anmd.getNonForageRate()).multiply(nfgPer)).divide(new BigDecimal(100)));
									BigDecimal unitIndexVal = anmd.getProteinUnitIndex().add( ((anmd.getProteinUnitIndex()).multiply(unitIndexPer)).divide(new BigDecimal(100)));
									
									nutritionNew = nutritionNew.add((nfgVal.multiply(unitIndexVal).multiply(animalCountVal)));
								}

							}

						}
						
						}
						
						
					}

				}
			
			}	
			if (unitIndex.equals("Energy")) {
				nutrition = (nutrition.multiply(new BigDecimal(35600))).multiply(new BigDecimal(propertyValue));
				nutritionNew = (nutritionNew.multiply(new BigDecimal(35600)).multiply(new BigDecimal(propertyValue)));
			} else {
				nutrition = (nutrition.multiply(new BigDecimal(0.319))).multiply(new BigDecimal(propertyValue));
				nutritionNew = (nutritionNew.multiply(new BigDecimal(0.319))).multiply(new BigDecimal(propertyValue));
			}
			//aqua
			for (AquacultureData aqmd : aquacultureData) {
				if (countryName.equals(aqmd.getCountryDetail().getCountryName())) {
					if (yearNo.equals(aqmd.getYear())) {
						if (unitIndex.equals("Energy")) {
							BigDecimal energyIndex = aqmd.getNutritionEnergy();
							if (!energyIndex.equals(null)) {
								nutrition = (nutrition.add(aqmd.getNutritionEnergy())).divide(new BigDecimal(1000000)).setScale(2,
										RoundingMode.CEILING);
								nutritionNew = (nutritionNew.add(aqmd.getNutritionEnergy())).divide(new BigDecimal(1000000)).setScale(2,
										RoundingMode.CEILING);
							}
						} else {
							BigDecimal proteinIndex = aqmd.getNutritionProtein();
							if (!proteinIndex.equals(null)) {
								nutrition = (nutrition.add(aqmd.getNutritionProtein())).divide(new BigDecimal(1000)).setScale(2,
										RoundingMode.CEILING);
								nutritionNew = (nutritionNew.add(aqmd.getNutritionProtein())).divide(new BigDecimal(1000)).setScale(2,
										RoundingMode.CEILING);
							}

						}
					}
				}
			}
			System.out.println("==="+yearNo+"==="+nutrition+ "=="+nutritionNew );

			mailMessage = mailMessage + "<tr><td style='text-align: center;'>"
					+ yearNo + "</td><td style='text-align: center;'>"
					+ (nutrition) + "</td><td style='text-align: center;'>"
					+ (nutritionNew) + "</td></tr>";
			
	}
		
		  mailMessage = mailMessage + "</table>";
		  
		  mailMessage = mailMessage  
		  				+ "<table><tr><th style='text-align: center;' colspan='4'>Percentage Change in Values</th></tr>" 
							+"<tr>" 
							+ "<th style='text-align: center;'>Species</th>" 
							+ "<th style='text-align: center; width:120px;'>Animal number</th>"
							+ "<th style='text-align: center;'>Non-forage rate (share of animal population that is not fed through grazing, in %)</th>"
							+ "<th style='text-align: center;'>Animal Unit Index ("+unitIndex+")</th>"
							+ "</tr>";
		  
	//
			
			int animalListSize = animalNameList.size() ;
			for (int animalIndex=0 ; animalIndex < animalListSize; animalIndex++) {

				BigDecimal animalCountPer = (new BigDecimal(perChngAnmList[animalIndex])).setScale(2,
						RoundingMode.CEILING);;
				BigDecimal nfgPer = (new BigDecimal(perChngNonForgRatList[animalIndex])).setScale(2,
						RoundingMode.CEILING);;
				BigDecimal unitIndexPer = (new BigDecimal(perChngUtIdxList[animalIndex])).setScale(2,
						RoundingMode.CEILING);;
					
				  mailMessage = mailMessage  
						  	+ "<tr><td style='text-align: center;'>" + animalNameList.get(animalIndex) + "</td>"  
							+ "<td style='text-align: center;'>" + animalCountPer  + "</td>"
							+ "<td style='text-align: center;'>" + nfgPer + "</td>"
							+ "<td style='text-align: center;'>" + unitIndexPer + "</td>"
							+ "</tr>";		
			}
			  mailMessage = mailMessage + "</table>";
		//  
		  
		  
		  
		  
		  
		
		  mailMessage = mailMessage
                  +  "    </div>\n" ;
		  System.out.println(mailMessage);

		

		final String username = "ofsrome@gmail.com";
		final String password = "ofsrome123";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
 
		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
 
		try {
 
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("ofsrome@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse("ofsrome@gmail.com"));
			message.setSubject("OFS Data");
			message.setContent(mailMessage,"text/html" );
 
			Transport.send(message);
 
			System.out.println("Done");
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
		
		

		return "index";
	}
}
