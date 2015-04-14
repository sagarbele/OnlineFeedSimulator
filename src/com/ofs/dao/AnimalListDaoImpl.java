package com.ofs.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ofs.model.AnimalList;


/**
 * @author  Sagar, Amit
 *
 */
@Repository("animalListDao")
public class AnimalListDaoImpl implements AnimalListDao {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<AnimalList> getAnimalList() {
		return (List<AnimalList>) sessionFactory.getCurrentSession().createCriteria(AnimalList.class).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<String> getAnimalNameList(){
		return (List<String>) sessionFactory.getCurrentSession().createCriteria(AnimalList.class)
				.setProjection(Projections.property("animalName")).list();
	}
	
}
