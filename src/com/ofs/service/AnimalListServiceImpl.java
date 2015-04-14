package com.ofs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ofs.dao.AnimalListDao;
import com.ofs.model.AnimalList;

/**
 * @author  Sagar, Amit
 *
 */
@Service("animalListService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class AnimalListServiceImpl implements AnimalListService {

	@Autowired
	private AnimalListDao animalListDao;
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)

	public List<AnimalList> getAnimalList() {
		return animalListDao.getAnimalList();
	}
	
	public List<String> getAnimalNameList(){
		return animalListDao.getAnimalNameList();
	}
	
}
