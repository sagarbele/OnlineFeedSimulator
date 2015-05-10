package com.ofs.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ofs.model.Property;


/**
 * @author  Sagar, Amit
 *
 */
@Repository("propertyDao")
public class PropertyDaoImpl implements PropertyDao {

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	public List<Property> getPropertyData() {
		return (List<Property>) sessionFactory.getCurrentSession().createCriteria(Property.class).
				add(Restrictions.eq("propertyType","PROTEIN (%)")).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Property> getAllPropertyData() {
		return (List<Property>) sessionFactory.getCurrentSession().createCriteria(Property.class).list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Property> getPropertyData(String propertyName,String propertyType) {
		return (List<Property>) sessionFactory.getCurrentSession().createCriteria(Property.class).
				add(Restrictions.eq("propertyName", propertyName)).
				add(Restrictions.eq("propertyType",propertyType)).list();
	}
}
