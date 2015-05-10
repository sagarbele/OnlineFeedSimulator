package com.ofs.service;

import java.util.List;

import com.ofs.model.Property;

/**
 * @author  Sagar, Amit
 *
 */
public interface PropertyService {
	
	public List<Property> getPropertyData();
	
	public List<Property> getAllPropertyData();

	public List<Property> getPropertyData(String propertyName,String propertyType);
}
