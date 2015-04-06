package com.ofs.dao;

import java.util.List;

import com.ofs.model.AquacultureData;


/**
 * @author  Sagar, Amit
 *
 */
public interface AquacultureDao {
	
	public List<AquacultureData> getAquacultureData();

	public List<AquacultureData> getAquacultureData(int countryId);
	
	public List<AquacultureData> getMultipleCountryAquacultureData(List<Integer> countryList);
}
