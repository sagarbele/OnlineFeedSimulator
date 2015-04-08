package com.ofs.service;

import java.util.List;

import com.ofs.model.CountryDetail;

/**
 * @author  Sagar, Amit
 *
 */
public interface CountryService {
	
	public List<CountryDetail> getCountryData();
	
	public List<CountryDetail> getCountryData(int countryId);

	public List<String> getMultipleCountryList(List<Integer> countryList);
	
	public List<CountryDetail> getMultipleCountryListObject(List<Integer> countryList);
}
