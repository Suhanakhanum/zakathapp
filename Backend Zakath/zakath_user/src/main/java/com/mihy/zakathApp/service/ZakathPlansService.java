package com.mihy.zakathApp.service;

import java.time.Year;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.mihy.zakathApp.dao.ZakathPlansDao;
import com.mihy.zakathApp.dao.ZakathUserDao;
import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathPaymentHistory;
import com.mihy.zakathApp.dto.ZakathPlans;
import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.exception.IdNotFoundException;

@Service
public class ZakathPlansService {
	@Autowired
	private ZakathPlansDao pDao;
	@Autowired
	private ZakathUserDao uDao;
	
	public ResponseEntity<ResponseStructure<ZakathPlans>> savePlans(ZakathPlans p, int u_id){
		ResponseStructure<ZakathPlans> structure= new ResponseStructure<>();
		Optional<ZakathUser> recUser=uDao.findById(u_id);
		if(recUser.isPresent()) {
			ZakathUser u= recUser.get();
			u.getPlans().add(p);
			p.setUser(recUser.get());
			uDao.updateUser(u);
			pDao.savePlan(p);
			structure.setData(p);
			structure.setMessage("Plans Saved with the Id: " + p.getId() + "to the User Id: " + u.getId());
			structure.setStatusCode(HttpStatus.CREATED.value());
			return new ResponseEntity<ResponseStructure<ZakathPlans>>(structure, HttpStatus.CREATED);
		}
		else {
			throw new IdNotFoundException();
		}
	}
	
	public ResponseEntity<ResponseStructure<ZakathPlans>> updatePlans(ZakathPlans p, int u_id){
		ResponseStructure<ZakathPlans> structure= new ResponseStructure<>();
		Optional<ZakathUser> recUser=uDao.findById(u_id);
		if(recUser.isPresent()) {
			p.setUser(recUser.get());
			pDao.updatePlan(p);
			structure.setData(p);
			structure.setMessage("Plan Updated Succssfully");
			structure.setStatusCode(HttpStatus.ACCEPTED.value());
			return new ResponseEntity<ResponseStructure<ZakathPlans>>(structure, HttpStatus.ACCEPTED);
		}
		else {
			throw new IdNotFoundException();
		}
	}
	
	public ResponseEntity<ResponseStructure<List<ZakathPlans>>> findByUserIdAndYear(int u_id,Year year){
		ResponseStructure<List<ZakathPlans>> structure= new ResponseStructure<>();
		List<ZakathPlans> zakathPlan=pDao.findByUserIdAndYear(u_id, year);
		if(zakathPlan.isEmpty()) {
			structure.setMessage("Check the provided Id or Year once... It's Invalid");
			structure.setStatusCode(HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<ResponseStructure<List<ZakathPlans>>>(structure, HttpStatus.NOT_FOUND);
			
		}
		else {
			structure.setData(zakathPlan);
			structure.setMessage("Plans found for the particular User with required year");
			structure.setStatusCode(HttpStatus.OK.value());
			return new ResponseEntity<ResponseStructure<List<ZakathPlans>>>(structure, HttpStatus.OK);
		}
	}
	
	public ResponseEntity<ResponseStructure<ZakathPlans>> findById(int id){
    	ResponseStructure<ZakathPlans> structure = new ResponseStructure<>();
    	Optional<ZakathPlans> recPlan = pDao.findById(id);
    	if(recPlan.isPresent()) {
    		structure.setData(recPlan.get());
    		structure.setMessage("Product Found");
    		structure.setStatusCode(HttpStatus.OK.value());
    	    return new ResponseEntity<ResponseStructure<ZakathPlans>>(structure,HttpStatus.OK);
    	}
    	throw new IdNotFoundException();
    }
}


