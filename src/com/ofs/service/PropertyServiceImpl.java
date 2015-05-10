package com.ofs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ofs.dao.PropertyDao;
import com.ofs.model.Property;


/**
 * @author  Sagar, Amit
 *
 */
@Service("propertyService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class PropertyServiceImpl implements PropertyService {

	@Autowired
	private PropertyDao propertyDao;
	
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)

	public List<Property> getPropertyData() {
		return propertyDao.getPropertyData();
	}
	
	public List<Property> getAllPropertyData(){
		return propertyDao.getAllPropertyData();
	}
	
	public List<Property> getPropertyData(String propertyName,String propertyType) {
		return propertyDao.getPropertyData(propertyName,propertyType);
	}


}
