package com.ofs.dao;

import java.util.List;

import org.hibernate.SessionFactory;
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
@Repository("animalDao")
public class AnimalDaoImpl implements AnimalDao {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<AnimalData> getAnimalData() {
		return (List<AnimalData>) sessionFactory.getCurrentSession()
				.createCriteria(AnimalData.class).list();
	}

	@SuppressWarnings("unchecked")
	public List<AnimalData> getAnimalData(int countryId) {
		return (List<AnimalData>) sessionFactory.getCurrentSession()
				.createCriteria(AnimalData.class)
				.add(Restrictions.eq("countryId", countryId)).list();
	}

	@SuppressWarnings("unchecked")
	public List<AnimalData> getMultipleCountryAnimalData(
			List<Integer> countryList) {
		System.out.println("Inside hibernate" + countryList + "--");
		return (List<AnimalData>) sessionFactory.getCurrentSession()
				.createCriteria(AnimalData.class)
				.add(Restrictions.in("countryId", countryList)).list();
	}

	@SuppressWarnings("unchecked")
	public List<Integer> getYearList() {
		return (List<Integer>) sessionFactory.getCurrentSession()
				.createCriteria(AnimalData.class)
				.setProjection(Projections.property("year"))
				.setProjection( Projections.distinct( Projections.property( "year" ) ) ).list();
	}

}
