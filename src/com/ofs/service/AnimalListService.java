package com.ofs.service;

import java.util.List;

import com.ofs.model.AnimalList;
import com.ofs.model.CountryDetail;

/**
 * @author  Sagar, Amit
 *
 */
public interface AnimalListService {
	
	public List<AnimalList> getAnimalList();
	
	public List<String> getAnimalNameList();
}
