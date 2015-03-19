package com.github.ofs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

import com.github.ofs.model.Country;

@Repository("countryRepository")
public interface CountryRepository extends JpaRepository<Country, Long> {
	
	@Query("select c from Country c")
	List<Country> getAllCountries();

}

