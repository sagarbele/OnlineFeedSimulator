package com.ofs.dao;

import java.util.List;

import com.ofs.model.Property;


/**
 * @author  Sagar, Amit
 *
 */
public interface PropertyDao {
	
	public List<Property> getPropertyData();
	
	public List<Property> getAllPropertyData();

	public List<Property> getPropertyData(String propertyName,String propertyType);
}
