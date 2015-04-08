package com.ofs.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
public class AnimalDataController {

	@Autowired
	private AnimalService animalService;

	@Autowired
	private CountryService countryService;

	@Autowired
	private PropertyService propertyService;
	
	@Autowired
	private AnimalListService animalListService;

	@Autowired
	private AquacultureService aquacultureService;

	/*
	 * @RequestMapping(value = "/index", method = RequestMethod.GET) public
	 * ModelAndView welcome() { return new ModelAndView("index"); }
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getData", method = RequestMethod.GET)
	public String getAllData(
			@RequestParam(value = "country", required = false) String countryIdList,
			@RequestParam(value = "unitIndex", required = false) String unitIndex,
			@RequestParam(value = "property", required = false) String propertyName,
			Model model) {
		System.out.println("countryId " + countryIdList + "--initIndex-"
				+ unitIndex + "--propertyName-" + propertyName);

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
			propertyName = pdata.getPropertyName();

		}
		model.addAttribute("propertyValue", propertyValue);
		model.addAttribute("propertyName", propertyName);
		model.addAttribute("unitIndex", unitIndex);

		/*
		 * Get Country Parameters from page and convert them into List<Integer>
		 */
		List<String> countryList = Arrays.asList(countryIdList.split(","));
		List<Integer> intCountryList = new ArrayList<Integer>(
				countryList.size());
		for (String myInt : countryList) {
			intCountryList.add(Integer.valueOf(myInt));
		}
		/*
		 * Fetch animal raw data for selected countries
		 */
		List<AnimalData> animalData = animalService
				.getMultipleCountryAnimalData(intCountryList);
		for (AnimalData data : animalData) {
			System.out.println("-----" + "\n" + data.getAnimalCount() + "--"
					+ data.getYear() + "--" + data.getCountryId());
		}

		/*
		 * Get list of countries
		 *
		List<String> selectedCountryList = countryService
				.getMultipleCountryList(intCountryList);
		System.out.println(selectedCountryList);
		model.addAttribute("countryList", selectedCountryList); */
		
		
		List<CountryDetail> selectedCountryList = countryService.getMultipleCountryListObject(intCountryList);
		String countryNames = "";
		for(CountryDetail s :selectedCountryList )
		{
			countryNames= countryNames.concat(s.getCountryName()+",");
		}
		model.addAttribute("countryList",countryNames);
	
		/*
		 * Get Animal List
		 */
		List<AnimalList> animalList = animalListService.getAnimalList();
		String animalNames = "";
		for(AnimalList anmList :animalList )
		{
			animalNames= animalNames.concat(anmList.getAnimalName()+",");
		}
	
		model.addAttribute("animalList", animalNames);
		
		List<Integer> yearList = animalService.getYearList();
		model.addAttribute("yearList", yearList);
		/*
		 * Convert Animal Data in Json Format
		 */
		JSONObject responseDetailsJson = new JSONObject();
		JSONArray jsonArrayAnimalData = new JSONArray();

		for (AnimalData anmd : animalData) {
			JSONObject formDetailsJson = new JSONObject();
			formDetailsJson.put("animalName", anmd.getAnimalList()
					.getAnimalName().toString());
			formDetailsJson.put("animalType", anmd.getAnimalList()
					.getAnimalType().getAnimalTypeName().toString());
			formDetailsJson.put("countryName", anmd.getCountryDetail()
					.getCountryName().toString());
			formDetailsJson.put("year", anmd.getYear());
			formDetailsJson.put("animalCount", anmd.getAnimalCount());
			formDetailsJson.put("energyUnitIndex", anmd.getEnergyUnitIndex()
					.toString());
			formDetailsJson.put("nonForageRate", anmd.getNonForageRate()
					.toString());
			formDetailsJson.put("proteinUnitIndex", anmd.getProteinUnitIndex()
					.toString());
			jsonArrayAnimalData.add(formDetailsJson);
		}

		// Here you can see the data in json format
		responseDetailsJson.put("animalRawData", jsonArrayAnimalData);
		model.addAttribute("animalRawData", jsonArrayAnimalData);

		/*
		 * Get Aquaculture Data
		 */
		List<AquacultureData> aquacultureData = aquacultureService
				.getMultipleCountryAquacultureData(intCountryList);
		for (AquacultureData aqdata : aquacultureData) {
			System.out.println("-----" + "\n" + aqdata.getNutritionEnergy()
					+ "--" + aqdata.getYear() + "--" + aqdata.getCountryId());
		}


		
		/*
		 * Convert Data in Json Format
		 */
		JSONObject responseAquaDetailsJson = new JSONObject();
		JSONArray jsonArrayAquaData = new JSONArray();

		for (AquacultureData aqmd : aquacultureData) {
			JSONObject formDetailsJson = new JSONObject();
			formDetailsJson.put("countryName", aqmd.getCountryDetail()
					.getCountryName().toString());
			formDetailsJson.put("year", aqmd.getYear());
			formDetailsJson.put("nutritionEnergy", aqmd.getNutritionEnergy()
					.toString());
			formDetailsJson.put("nutritionProtein", aqmd.getNutritionProtein()
					.toString());
			jsonArrayAquaData.add(formDetailsJson);
		}

		// Here you can see the data in json format
		responseAquaDetailsJson.put("aquacultureData", jsonArrayAquaData);
		System.out.println(jsonArrayAquaData);
		model.addAttribute("aquacultureData", jsonArrayAquaData);

		return "animalData";
	}

}
