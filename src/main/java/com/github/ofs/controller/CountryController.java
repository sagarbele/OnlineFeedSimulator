package com.github.ofs.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.github.ofs.model.Country;
import com.github.ofs.service.CountryService;


@Controller
@SessionAttributes("country")
public class CountryController {
	

	@Autowired
	private CountryService countryService;
	
	@RequestMapping(value="/showSimulator", method=RequestMethod.GET)
	public String login(Model model) {			
		System.out.println("AA gaya bhai controller me");
		List<Country> countryList = new ArrayList<Country>();	
		countryList = countryService.getAllCountries();
		model.addAttribute("countryList", countryList.size());
		System.out.println(countryList.size());
		return "showSimulator";
	}

}


