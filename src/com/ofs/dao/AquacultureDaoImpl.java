package com.ofs.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ofs.model.AquacultureData;


/**
 * @author  Sagar, Amit
 *
 */
@Repository("aquacultureDao")
public class AquacultureDaoImpl implements AquacultureDao {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<AquacultureData> getAquacultureData() {
		return (List<AquacultureData>) sessionFactory.getCurrentSession().createCriteria(AquacultureData.class).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<AquacultureData> getAquacultureData(int countryId) {
		return (List<AquacultureData>) sessionFactory.getCurrentSession().createCriteria(AquacultureData.class).
				add(Restrictions.eq("countryId", countryId)).list();
	}
	@SuppressWarnings("unchecked")
	public List<AquacultureData> getMultipleCountryAquacultureData(List<Integer> countryList){
		return (List<AquacultureData>) sessionFactory.getCurrentSession().createCriteria(AquacultureData.class).
				add(Restrictions.in("countryId", countryList)).list();
	}
}

