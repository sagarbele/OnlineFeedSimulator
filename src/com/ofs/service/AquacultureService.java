package com.ofs.service;

import java.util.List;

import com.ofs.model.AquacultureData;

/**
 * @author  Sagar, Amit
 *
 */
public interface AquacultureService {
	
	public List<AquacultureData> getAquacultureData();

	public List<AquacultureData> getAquacultureData(int countryId);
	
	public List<AquacultureData> getMultipleCountryAquacultureData(List<Integer> countryList);
}
