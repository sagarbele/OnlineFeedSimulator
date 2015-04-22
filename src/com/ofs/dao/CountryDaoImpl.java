package com.ofs.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ofs.model.AnimalData;
import com.ofs.model.CountryDetail;

/**
 * @author Sagar, Amit
 * 
 */
@Repository("countryDao")
public class CountryDaoImpl implements CountryDao {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<CountryDetail> getCountryData() {
		return (List<CountryDetail>) sessionFactory.getCurrentSession()
				.createCriteria(CountryDetail.class).addOrder( Order.asc("countryName")).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<CountryDetail> getCountryData(int countryId) {
		return (List<CountryDetail>) sessionFactory.getCurrentSession()
				.createCriteria(CountryDetail.class)
				.add(Restrictions.eq("countryId", countryId)).list();
	}

	@SuppressWarnings("unchecked")
	public List<String> getMultipleCountryList(List<Integer> countryList) {
		return (List<String>) sessionFactory.getCurrentSession()
				.createCriteria(CountryDetail.class)
				.add(Restrictions.in("countryId", countryList))
				.setProjection(Projections.property("countryName")).list();
	}

	@SuppressWarnings("unchecked")
	public List<CountryDetail> getMultipleCountryListObject(
			List<Integer> countryList) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				CountryDetail.class);
		criteria.add(Restrictions.in("countryId", countryList));
		return criteria.list();
	}
}
