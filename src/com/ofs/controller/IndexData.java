package com.ofs.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ofs.model.CountryDetail;
import com.ofs.service.CountryService;

/**
 * @author  Sagar, Amit
 *
 */
@Controller
public class IndexData { 
	
	@Autowired
	private CountryService countryService;
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String welcome(Model model) {
		List<CountryDetail> countryList = countryService.getCountryData();
		for(CountryDetail cdata:countryList){
			System.out.println(cdata.getCountryName()+"--"+"--"+cdata.getCountryId());
		}
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
