package com.ofs.dao;

import java.util.List;

import com.ofs.model.AnimalData;


/**
 * @author  Sagar, Amit
 *
 */
public interface AnimalDao {
	
	public List<AnimalData> getAnimalData();

	public List<AnimalData> getAnimalData(int countryId);
}
