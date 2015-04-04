package com.ofs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
public class AnimalAllData {

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

	@RequestMapping(value = "/showSimulator", method = RequestMethod.POST)
	public String getAllData(
			@RequestParam(value = "countryId", required = false) Integer countryId,
			Model model) {
		System.out.println("in animla data controller " + countryId);
		/*
		 * List<AnimalData> animalData = animalService.getAnimalData(countryId);
		 * for(AnimalData data:animalData){
		 * System.out.println(data.getAnimalCount
		 * ()+"--"+data.getYear()+"--"+data.getCountryId()); }
		 */
		List<Property> propertyList = propertyService.getPropertyData();
		for (Property pdata : propertyList) {
			System.out.println(pdata.getPropertyId() + "--"
					+ pdata.getPropertyName() + "--" + "--"
					+ pdata.getPropertyType());
		}

		List<CountryDetail> countryList = countryService.getCountryData();
		for (CountryDetail cdata : countryList) {
			System.out.println(cdata.getCountryName() + "--" + "--"
					+ cdata.getCountryId());
		}

		// model.addAttribute("animalData",animalData);
		model.addAttribute("countryList", countryList);
		model.addAttribute("propertyList", propertyList);

		return "showSimulator";
	}

}
