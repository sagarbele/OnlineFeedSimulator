package com.ofs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ofs.dao.AnimalDao;
import com.ofs.model.AnimalData;


/**
 * @author  Sagar, Amit
 *
 */
@Service("animalService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class AnimalServiceImpl implements AnimalService {

	@Autowired
	private AnimalDao animalDao;
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)

	public List<AnimalData> getAnimalData() {
		return animalDao.getAnimalData();
	}


}
