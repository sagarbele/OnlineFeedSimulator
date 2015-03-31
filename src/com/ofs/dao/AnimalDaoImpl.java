package com.ofs.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ofs.model.AnimalData;


/**
 * @author  Sagar, Amit
 *
 */
@Repository("animalDao")
public class AnimalDaoImpl implements AnimalDao {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<AnimalData> getAnimalData() {
		return (List<AnimalData>) sessionFactory.getCurrentSession().createCriteria(AnimalData.class).list();
	}
	
}