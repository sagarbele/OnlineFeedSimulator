package com.ofs.service;

import java.util.List;

import com.ofs.model.AnimalData;

/**
 * @author  Sagar, Amit
 *
 */
public interface AnimalService {
	
	public List<AnimalData> getAnimalData();

	public List<AnimalData> getAnimalData(int countryId);
}
