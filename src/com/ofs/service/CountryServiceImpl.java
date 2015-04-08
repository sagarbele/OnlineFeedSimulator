package com.ofs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ofs.dao.CountryDao;
import com.ofs.model.AnimalData;
import com.ofs.model.CountryDetail;

/**
 * @author Sagar, Amit
 * 
 */
@Service("countryService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class CountryServiceImpl implements CountryService {

	@Autowired
	private CountryDao countryDao;

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public List<CountryDetail> getCountryData() {
		return countryDao.getCountryData();
	}

	public List<CountryDetail> getCountryData(int countryId) {
		return countryDao.getCountryData(countryId);
	}

	public List<String> getMultipleCountryList(List<Integer> countryList) {
		return countryDao.getMultipleCountryList(countryList);
	}

	public List<CountryDetail> getMultipleCountryListObject(
			List<Integer> countryList) {
		return countryDao.getMultipleCountryListObject(countryList);
	}
}
