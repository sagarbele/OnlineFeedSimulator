package com.ofs.dao;

import java.util.List;

import com.ofs.model.AnimalList;

/**
 * @author Sagar, Amit
 * 
 */
public interface AnimalListDao {

	public List<AnimalList> getAnimalList();
	
	public List<String> getAnimalNameList();
}
