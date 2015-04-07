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
import com.ofs.model.AquacultureData;
import com.ofs.model.Property;
import com.ofs.service.AnimalService;
import com.ofs.service.AquacultureService;
import com.ofs.service.CountryService;
import com.ofs.service.PropertyService;

/**
 * @author Sagar, Amit
 * 
 */
@Controller
public class ScenarioRegerateDataController {

	@Autowired
	private AnimalService animalService;

	@Autowired
	private CountryService countryService;

	@Autowired
	private PropertyService propertyService;

	@Autowired
	private AquacultureService aquacultureService;

	/*
	 * @RequestMapping(value = "/index", method = RequestMethod.GET) public
	 * ModelAndView welcome() { return new ModelAndView("index"); }
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/scenarioRegenerateData", method = RequestMethod.GET)
	public String getAllData(
			@RequestParam(value = "country", required = false) Integer countryId,
			@RequestParam(value = "unitIndex", required = false) String unitIndex,
			@RequestParam(value = "property", required = false) String propertyName,
			@RequestParam(value = "nfgRate", required = false) String nfgRate,
			Model model) {
		System.out.println("countryId " + countryId + "--initIndex-"
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
		model.addAttribute("nfgRate",nfgRate);
		
		/*
		 * Get Animal Data
		 */
		List<AnimalData> animalData = animalService.getAnimalData(countryId);
		model.addAttribute("countryId", countryId);
		
	
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
				.getAquacultureData(countryId);
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
		model.addAttribute("aquacultureData", jsonArrayAquaData);

		return "scenarioRegenerateData";
	}

}
