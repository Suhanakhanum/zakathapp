package com.mihy.zakathApp.repository;

import java.time.Year;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.mihy.zakathApp.dto.ZakathPlans;

public interface ZakathPlanRepository extends JpaRepository<ZakathPlans, Integer>{
	@Query("select p from ZakathPlans p where p.user.id=?1 and p.year=?2")
	List<ZakathPlans> findByUserIdAndYear(int u_id, Year year);

}
