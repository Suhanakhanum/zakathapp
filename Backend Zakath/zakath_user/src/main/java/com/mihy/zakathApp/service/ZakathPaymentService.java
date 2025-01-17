package com.mihy.zakathApp.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.mihy.zakathApp.dao.ZakathPaymentDao;
import com.mihy.zakathApp.dao.ZakathPlansDao;
import com.mihy.zakathApp.dao.ZakathUserDao;
import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathPaymentHistory;
import com.mihy.zakathApp.dto.ZakathPlans;
import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.exception.IdNotFoundException;

@Service
public class ZakathPaymentService {
	@Autowired
	private ZakathPaymentDao hDao; 
	
	@Autowired
	private ZakathUserDao uDao;
	
	@Autowired
	private ZakathPlansDao pDao;
	
	public ResponseEntity<ResponseStructure<ZakathPaymentHistory>> saveHistory(ZakathPaymentHistory h, int u_id, int p_id){
		ResponseStructure<ZakathPaymentHistory> structure= new ResponseStructure<>();
		Optional<ZakathUser> recUser=uDao.findById(u_id);
		Optional<ZakathPlans> recPlan=pDao.findById(p_id);
		if(recUser.isPresent() && recPlan.isPresent()) {
			ZakathUser u = recUser.get();
			u.getPayments().add(h);
			h.setUser(recUser.get());
			uDao.updateUser(u);
			
			ZakathPlans p = recPlan.get();
			p.getPayments().add(h);
			h.setPlan(recPlan.get());
			pDao.updatePlan(p);
			
			hDao.saveHistory(h);
			structure.setData(h);
			structure.setMessage("Payment History Saved Successfully with id: " + h.getId());
			structure.setStatusCode(HttpStatus.CREATED.value());
			return new ResponseEntity<ResponseStructure<ZakathPaymentHistory>>(structure, HttpStatus.CREATED);
		}
		else {
			throw new IdNotFoundException();
		}
	}
	
	public ResponseEntity<ResponseStructure<ZakathPaymentHistory>> updateHistory(ZakathPaymentHistory h, int u_id, int p_id){
		ResponseStructure<ZakathPaymentHistory> structure= new ResponseStructure<>();
		Optional<ZakathUser> recUser=uDao.findById(u_id);
		Optional<ZakathPlans> recPlan=pDao.findById(p_id);
		if(recUser.isPresent() && recPlan.isPresent()) {
			h.setUser(recUser.get());
			h.setPlan(recPlan.get());
			hDao.updateHistory(h);
			structure.setData(h);
			structure.setMessage("Payment History Updated Successfully");
			structure.setStatusCode(HttpStatus.ACCEPTED.value());
			return new ResponseEntity<ResponseStructure<ZakathPaymentHistory>>(structure, HttpStatus.ACCEPTED);
		}
		else {
			throw new IdNotFoundException();
		}
	}
	
	public ResponseEntity<ResponseStructure<List<ZakathPaymentHistory>>> findByUserIdAndPlanId(int u_id, int p_id){
		ResponseStructure<List<ZakathPaymentHistory>> structure= new ResponseStructure<>();
		List<ZakathPaymentHistory> zakathPayment=hDao.findByUserIdAndPlanId(u_id, p_id);
		if(zakathPayment.isEmpty()) {
			structure.setMessage("Check the provided Id or Date or Plan Id once... It's Invalid");
			structure.setStatusCode(HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<ResponseStructure<List<ZakathPaymentHistory>>>(structure, HttpStatus.NOT_FOUND);
			
		}
		else {
			structure.setData(zakathPayment);
			structure.setMessage("History found for the particular User with required date and plan Id");
			structure.setStatusCode(HttpStatus.OK.value());
			return new ResponseEntity<ResponseStructure<List<ZakathPaymentHistory>>>(structure, HttpStatus.OK);
		}
	}
	
	public ResponseEntity<ResponseStructure<ZakathPaymentHistory>> findById(int id){
		ResponseStructure<ZakathPaymentHistory> structure = new ResponseStructure<>();
		Optional<ZakathPaymentHistory> recPayment =hDao.findById(id);
		if(recPayment.isPresent()) {
			structure.setData(recPayment.get());
			structure.setMessage("payment Found");
			structure.setStatusCode(HttpStatus.OK.value());
			return new ResponseEntity<ResponseStructure<ZakathPaymentHistory>>(structure, HttpStatus.OK);
		}
		throw new IdNotFoundException();
	}
}
