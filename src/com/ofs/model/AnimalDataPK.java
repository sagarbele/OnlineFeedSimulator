package com.ofs.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

public class AnimalDataPK implements Serializable {
	
	protected int countryId;
	
	protected int year;
	
	protected int animalId;
	
	 public AnimalDataPK() {}

	    public AnimalDataPK(int countryId, int year, int animalId) {
	        this.countryId = countryId;
	        this.year = year;
	        this.animalId = animalId;
	    }
	
	}
