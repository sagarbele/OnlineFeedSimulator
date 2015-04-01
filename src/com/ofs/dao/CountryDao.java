package com.ofs.dao;

import java.util.List;

import com.ofs.model.AnimalData;
import com.ofs.model.CountryDetail;


/**
 * @author  Sagar, Amit
 *
 */
public interface CountryDao {
	
	public List<CountryDetail> getCountryData();

	public List<CountryDetail> getCountryData(int countryId);
}
