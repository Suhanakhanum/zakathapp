package com.mihy.zakathApp.dao;

import java.time.Year;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mihy.zakathApp.dto.ZakathPlans;
import com.mihy.zakathApp.repository.ZakathPlanRepository;

@Repository
public class ZakathPlansDao {
	@Autowired
	private ZakathPlanRepository repository;
	
	public ZakathPlans savePlan(ZakathPlans p) {
		return repository.save(p);
	}
	
	public ZakathPlans updatePlan(ZakathPlans p) {
		return repository.save(p);
	}
	
	public Optional<ZakathPlans> findById(int id){
		return repository.findById(id);
	}
	
	public List<ZakathPlans> findByUserIdAndYear(int u_id, Year year){
		return repository.findByUserIdAndYear(u_id, year);
	}
}
