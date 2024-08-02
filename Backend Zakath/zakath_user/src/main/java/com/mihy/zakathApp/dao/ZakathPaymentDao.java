package com.mihy.zakathApp.dao;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mihy.zakathApp.dto.ZakathPaymentHistory;
import com.mihy.zakathApp.repository.ZakathPaymentRepository;

@Repository
public class ZakathPaymentDao {
	@Autowired
	private ZakathPaymentRepository repository;
	
	public ZakathPaymentHistory saveHistory(ZakathPaymentHistory h) {
		return repository.save(h);
	}
	
	public ZakathPaymentHistory updateHistory(ZakathPaymentHistory h) {
		return repository.save(h);
	}
	
	public Optional<ZakathPaymentHistory> findById(int id){
		return repository.findById(id);
	}
	
	public List<ZakathPaymentHistory> findByUserIdAndPlanId(int u_id, int p_id){
		return repository.findByUserIdAndPlanId(u_id, p_id);
	}
}
