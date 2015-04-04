package com.ofs.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Embedded;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
@Entity
@Table(name="aquaculture_data")
@IdClass(AquacultureDataPK.class)
public class AquacultureData  implements Serializable{
	@Id
	private int countryId;
	@Id
	private int year;
	
	@ManyToOne
	@JoinColumn(name="countryId")
	@MapsId("countryId")
	private CountryDetail countryDetail;
	
	private Date createdDate; 
	
	private BigDecimal nutritionEnergy;
	
	private BigDecimal nutritionProtein;

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public BigDecimal getNutritionEnergy() {
		return nutritionEnergy;
	}

	public void setNutritionEnergy(BigDecimal nutritionEnergy) {
		this.nutritionEnergy = nutritionEnergy;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public BigDecimal getNutritionProtein() {
		return nutritionProtein;
	}

	public void setNutritionProtein(BigDecimal nutritionProtein) {
		this.nutritionProtein = nutritionProtein;
	}

	public CountryDetail getCountryDetail() {
		return countryDetail;
	}

	public void setCountryDetail(CountryDetail countryDetail) {
		this.countryDetail = countryDetail;
	}


	
}
