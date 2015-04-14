package com.ofs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ofs.model.CountryDetail;
import com.ofs.model.Property;
import com.ofs.service.CountryService;
import com.ofs.service.PropertyService;

/**
 * @author  Sagar, Amit
 *
 */
@Controller
public class IndexData { 
	
	@Autowired
	private CountryService countryService;
	
	@Autowired
	private PropertyService propertyService;
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String welcome(Model model) {
		List<CountryDetail> countryList = countryService.getCountryData();
		
		List<Property> propertyList = propertyService.getPropertyData();
		
		model.addAttribute("propertyList",propertyList);
		model.addAttribute("countryList",countryList);
		return "index";
	}
	
	/*
	@RequestMapping(method = RequestMethod.POST)
	public String getCountry(HttpServletRequest request,
			@RequestParam(value = "countryId", required = false) Integer countryId) {
		return "showSimulator?countryId="+countryId;
	}*/
	
}
