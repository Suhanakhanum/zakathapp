package com.mihy.zakathApp.repository;

import java.time.Year;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.mihy.zakathApp.dto.ZakathCalculation;

public interface ZakathCalculationRepository extends JpaRepository<ZakathCalculation, Integer> {
	@Query("select c from ZakathCalculation c where c.user.id=?1 and c.year=?2")
	List<ZakathCalculation> findByUserIdAndYear(int user_id,Year year);
	
	@Query("select c from ZakathCalculation c where c.user.id=?1")
	List<ZakathCalculation> findByUserId(int user_id);
	

	
}
