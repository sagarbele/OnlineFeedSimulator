package com.ofs.model;

import java.util.Date;

import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="animal_type")
public class AnimalType {


	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int animalTypeId;
	
	private String animalTypeName;

	private Date createdDate;

	public int getAnimalTypeId() {
		return animalTypeId;
	}

	public void setAnimalTypeId(int animalTypeId) {
		this.animalTypeId = animalTypeId;
	}

	public String getAnimalTypeName() {
		return animalTypeName;
	}

	public void setAnimalTypeName(String animalTypeName) {
		this.animalTypeName = animalTypeName;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	
}
