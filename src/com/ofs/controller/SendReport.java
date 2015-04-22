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
			@RequestParam(value = "nfgRate", required = false) String nfgRate,
			@RequestParam(value = "name", required = false) String reporterName,
			@RequestParam(value = "email", required = false) String reporterEmail,
			@RequestParam(value = "commnet", required = false) String reporterComments,
			Model model) {

		
		System.out.println("Inside Last Controller");
		
		System.out.println(countryId+"-"+unitIndex + "-"+propertyName+"-"+nfgRate+"-"+reporterName+"-"+reporterEmail+"-"+reporterComments);
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

	
		String nfgList []; ;
		nfgList = nfgRate.split(",");
		
		
		
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
        				+ "<table><tr><th style='text-align: center;' colspan='5' style='color: lightseagreen'>"
        				+ countryName
        				+ "</th></tr>"
        				+ "<tr><th style='text-align: center;'> Year </th><th style='text-align: center;'> Old Data </th><th style='text-align: center;'> New Data </th></tr>";

		
		
		
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
							System.out.println(countryName +"="+yearNo+"="+unitIndex+"="+energyIndex);
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
							BigDecimal nfgValue = new BigDecimal(nfgList[animalIndex].replace(
									(animalIndex + 1) + "a-", ""));
									
							if (yearNo.equals(anmd.getYear())) {
							if (unitIndex.equals("Energy")) {
								BigDecimal energyIndex = anmd.getEnergyUnitIndex();
								if (!energyIndex.equals(null)) {
									nutritionNew = nutritionNew.add((nfgValue.multiply(energyIndex).multiply(new BigDecimal(anmd.getAnimalCount()))));
								}

							} else {

								BigDecimal proteinIndex = anmd.getProteinUnitIndex();
								if (!proteinIndex.equals(null)) {
									nutritionNew = nutritionNew.add((nfgValue.multiply(proteinIndex).multiply(new BigDecimal(anmd.getAnimalCount()))));
								}

							}

						}
						
						}
						
						
					}

				}
			
			}	
			if (unitIndex.equals("Energy")) {
				nutrition = nutrition.multiply(new BigDecimal(0.319));
				nutritionNew = nutritionNew.multiply(new BigDecimal(0.319));
			} else {
				nutrition = nutrition.multiply(new BigDecimal(35600));
				nutritionNew = nutritionNew.multiply(new BigDecimal(35600));
			}
			//aqua
			for (AquacultureData aqmd : aquacultureData) {
				if (countryName.equals(aqmd.getCountryDetail().getCountryName())) {
					if (yearNo.equals(aqmd.getYear())) {
						if (unitIndex.equals("Energy")) {
							BigDecimal energyIndex = aqmd.getNutritionEnergy();
							if (!energyIndex.equals(null)) {
								nutrition = nutrition.add(aqmd.getNutritionEnergy()).setScale(2,
										RoundingMode.CEILING);;
								nutritionNew = nutritionNew.add(aqmd.getNutritionEnergy()).setScale(2,
										RoundingMode.CEILING);;
							}
						} else {
							BigDecimal proteinIndex = aqmd.getNutritionProtein();
							if (!proteinIndex.equals(null)) {
								nutrition = nutrition.add(aqmd.getNutritionProtein()).setScale(2,
										RoundingMode.CEILING);;
								nutritionNew = nutritionNew.add(aqmd.getNutritionProtein()).setScale(2,
										RoundingMode.CEILING);;
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
