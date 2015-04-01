package com.ofs.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ofs.model.AnimalData;
import com.ofs.model.CountryDetail;


/**
 * @author  Sagar, Amit
 *
 */
@Repository("countryDao")
public class CountryDaoImpl implements CountryDao {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<CountryDetail> getCountryData() {
		return (List<CountryDetail>) sessionFactory.getCurrentSession().createCriteria(CountryDetail.class).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<CountryDetail> getCountryData(int countryId) {
		return (List<CountryDetail>) sessionFactory.getCurrentSession().createCriteria(CountryDetail.class).list();
	}
}
