package com.ofs.model;

import java.util.Date;

import javax.annotation.Generated;
import javax.persistence.*;

@Entity
@Table(name="country")
public class CountryDetail {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int countryId;
		
	private String countryName;

	private Date createdDate; 
	
	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
}



/*


package com.github.ofs.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="country")
public class Country {

	@Id
	@GeneratedValue
	private Long countryId;
	
	@NotEmpty
	@Size(min=3, max=20)
	private String countryName;

	private Date createdDate; 
	
	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Long getCountryId() {
		return countryId;
	}

	public void setCountryId(Long countryId) {
		this.countryId = countryId;
	}

	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
	
}*/
