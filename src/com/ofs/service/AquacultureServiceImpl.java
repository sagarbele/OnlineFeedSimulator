package com.ofs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ofs.dao.AquacultureDao;
import com.ofs.model.AquacultureData;

/**
 * @author Sagar, Amit
 * 
 */
@Service("aquacultureService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class AquacultureServiceImpl implements AquacultureService {

	@Autowired
	private AquacultureDao aquacultureDao;

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public List<AquacultureData> getAquacultureData() {
		return aquacultureDao.getAquacultureData();
	}

	public List<AquacultureData> getAquacultureData(int countryId) {
		return aquacultureDao.getAquacultureData(countryId);
	}

	public List<AquacultureData> getMultipleCountryAquacultureData(
			List<Integer> countryList) {
		return aquacultureDao.getMultipleCountryAquacultureData(countryList);
	}
}
