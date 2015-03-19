package com.github.ofs.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.github.ofs.model.Country;
import com.github.ofs.repository.CountryRepository;
import org.hibernate.SessionFactory;

@Service("countryService")
public class CountryServiceImpl implements CountryService {
	
	private SessionFactory sessionFactory;
	@Autowired
	private CountryRepository countryRepository;
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	
	public 	List<Country> getAllCountries() 
	{
		List<Country> countryList= (List<Country>) countryRepository.getAllCountries();
		return  countryList;
	}

}

