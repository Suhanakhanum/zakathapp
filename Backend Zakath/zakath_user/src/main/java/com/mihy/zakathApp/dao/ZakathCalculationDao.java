package com.mihy.zakathApp.dao;

import java.lang.StackWalker.Option;
import java.time.Year;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mihy.zakathApp.dto.ZakathCalculation;
import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.repository.ZakathCalculationRepository;

@Repository
public class ZakathCalculationDao {
	@Autowired
	private ZakathCalculationRepository repository;
	
	public ZakathCalculation saveCalculation(ZakathCalculation c) {
		return repository.save(c);
	}
	
	public ZakathCalculation updateCalculation(ZakathCalculation c) {
		return repository.save(c);
	}
	
	public Optional<ZakathCalculation> findById(int id){
		return repository.findById(id);
	}
	
	public List<ZakathCalculation> findByUserIdAndYear(int u_id,Year year){
		return repository.findByUserIdAndYear(u_id, year);
	}
	
	public List<ZakathCalculation> findByUserId(int u_id){
		return repository.findByUserId(u_id);
	}
	
	public void deleteCalculations(int id) {
		repository.deleteById(id);
	}
	
}
