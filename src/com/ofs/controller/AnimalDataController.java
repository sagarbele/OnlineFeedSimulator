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
import com.ofs.model.CountryDetail;
import com.ofs.model.Property;
import com.ofs.service.AnimalService;
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

	/*
	 * @RequestMapping(value = "/index", method = RequestMethod.GET) public
	 * ModelAndView welcome() { return new ModelAndView("index"); }
	 */

	@RequestMapping(value = "/getData", method = RequestMethod.GET)
	public String getAllData(
			@RequestParam(value = "country", required = false) String countryIdList,
			@RequestParam(value = "unitIndex", required = false) String unitIndex,
			@RequestParam(value = "property", required = false) String propertyName,
			Model model) {
		System.out.println("countryId " + countryIdList + "--initIndex-"
				+ unitIndex + "--propertyName-" + propertyName);

		String propertyType = "";
		if (unitIndex == "Energy") {
			propertyType.equals("ENERGY (MJ/kg)");
		}
		if (unitIndex.equals("Protein")) {
			propertyType = "PROTEIN (%)";
		}

		List<Property> propertyList = propertyService.getPropertyData(
				propertyName, propertyType);
		String propertyValue = "";
		for (Property pdata : propertyList) {
			propertyValue = pdata.getPropertyValue();
			 model.addAttribute("propertyValue",propertyValue);
		}

		List<String> countryList = Arrays.asList(countryIdList.split(","));
		List<Integer> newIntCountryList = new ArrayList<Integer>(
				countryList.size());
		for (String myInt : countryList) {
			newIntCountryList.add(Integer.valueOf(myInt));
		}

		List<AnimalData> animalData = animalService
				.getMultipleCountryAnimalData(newIntCountryList);
		for (AnimalData data : animalData) {
			System.out.println("-----" + "\n" + data.getAnimalCount() + "--"
					+ data.getYear() + "--" + data.getCountryId());
		}

		JSONObject responseDetailsJson = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		for(AnimalData anmd:animalData){
			JSONObject formDetailsJson = new JSONObject();
	        formDetailsJson.put("animalName", anmd.getAnimalList().getAnimalName().toString());
	        formDetailsJson.put("animalType", anmd.getAnimalList().getAnimalType().getAnimalTypeName().toString());
	        formDetailsJson.put("countryName", anmd.getCountryDetail().getCountryName().toString());
	        formDetailsJson.put("year", anmd.getYear());
	        formDetailsJson.put("animalCount", anmd.getAnimalCount());
	        formDetailsJson.put("energyUnitIndex", anmd.getEnergyUnitIndex().toString());
	        formDetailsJson.put("nonForageRate", anmd.getNonForageRate().toString());
	        formDetailsJson.put("proteinUnitIndex", anmd.getProteinUnitIndex().toString());
	       jsonArray.add(formDetailsJson);
		}
		
		//Here you can see the data in json format
		responseDetailsJson.put("formss", jsonArray);
		
		System.out.println("xxxxxxxxxx"+jsonArray);
		
		model.addAttribute("forms",jsonArray);
	
		
		
		/*
		 * List<CountryDetail> countryList = countryService.getCountryData();
		 * for(CountryDetail cdata:countryList){
		 * System.out.println(cdata.getCountryName
		 * ()+"--"+"--"+cdata.getCountryId()); }
		 * 
		 * 
		 * model.addAttribute("animalData",animalData);
		 * model.addAttribute("countryList",countryList);
		 */
		return "animalData";
	}

}
