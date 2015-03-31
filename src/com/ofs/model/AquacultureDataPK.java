package com.ofs.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

public class AquacultureDataPK implements Serializable  {

	
	private int countryId;
	
	private int year;
	
	 public AquacultureDataPK() {}

	    public AquacultureDataPK(int countryId, int year) {
	        this.countryId = countryId;
	        this.year = year;
	    }
	
}
