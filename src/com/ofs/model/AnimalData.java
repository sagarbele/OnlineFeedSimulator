package com.ofs.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name="animal_data")
@IdClass(AnimalDataPK.class)
public class AnimalData implements Serializable {

	@Id
	private int countryId;
	@Id
	private int year;
	
    @Id
    private int animalId;  
    
    @ManyToOne
    @JoinColumn(name="animalId")
    @MapsId("animalId")
    private AnimalList animalList;
    
    @ManyToOne
    @JoinColumn(name="countryId")
    @MapsId("countryId")
    private CountryDetail countryDetail;
	
	private Date createdDate; 
	
	private BigDecimal energyUnitIndex;
	
	private BigDecimal proteinUnitIndex;
	
	private int animalCount;
	
	private BigDecimal nonForageRate ;

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public AnimalList getAnimalList() {
		return animalList;
	}

	public void setAnimalList(AnimalList animalList) {
		this.animalList = animalList;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public BigDecimal getEnergyUnitIndex() {
		return energyUnitIndex;
	}

	public void setEnergyUnitIndex(BigDecimal energyUnitIndex) {
		this.energyUnitIndex = energyUnitIndex;
	}

	public BigDecimal getProteinUnitIndex() {
		return proteinUnitIndex;
	}

	public void setProteinUnitIndex(BigDecimal proteinUnitIndex) {
		this.proteinUnitIndex = proteinUnitIndex;
	}

	public int getAnimalCount() {
		return animalCount;
	}

	public void setAnimalCount(int animalCount) {
		this.animalCount = animalCount;
	}

	public BigDecimal getNonForageRate() {
		return nonForageRate;
	}

	public void setNonForageRate(BigDecimal nonForageRate) {
		this.nonForageRate = nonForageRate;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public CountryDetail getCountryDetail() {
		return countryDetail;
	}

	public void setCountryDetail(CountryDetail countryDetail) {
		this.countryDetail = countryDetail;
	}
}
