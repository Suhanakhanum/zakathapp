package com.mihy.zakathApp.service;

import java.time.Year;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.mihy.zakathApp.dao.ZakathCalculationDao;
import com.mihy.zakathApp.dao.ZakathUserDao;
import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathCalculation;
import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.exception.IdNotFoundException;
import com.mihy.zakathApp.repository.ZakathCalculationRepository;

@Service
public class ZakathCalculationService {
	@Autowired
	private ZakathUserDao uDao;
	@Autowired
	private ZakathCalculationDao cDao;
	@Autowired
	private ZakathCalculationRepository repo;
	
	public ResponseEntity<ResponseStructure<ZakathCalculation>> saveCalculation(ZakathCalculation c, int u_id){
		ResponseStructure<ZakathCalculation> structure= new ResponseStructure<>();
		Optional<ZakathUser> recUser=uDao.findById(u_id);
		if(recUser.isPresent()) {
			ZakathUser u=recUser.get();
			u.getCalculations().add(c);
			c.setUser(recUser.get());
			uDao.updateUser(u);
			cDao.saveCalculation(c);
			structure.setData(c);
			structure.setMessage("Calculation Saved with the id: " + c.getId() + "to the user Id: " + u.getId());
			structure.setStatusCode(HttpStatus.CREATED.value());
			return new ResponseEntity<ResponseStructure<ZakathCalculation>>(structure, HttpStatus.CREATED);
		}
		throw new IdNotFoundException();
	}
	
	public ResponseEntity<ResponseStructure<ZakathCalculation>> updateCalculation(ZakathCalculation c, int u_id){
		ResponseStructure<ZakathCalculation> structure= new ResponseStructure<>();
		Optional<ZakathUser> recUser=uDao.findById(u_id);
		if(recUser.isPresent()) {
			c.setUser(recUser.get());
			cDao.updateCalculation(c);
			structure.setData(c);
			structure.setMessage("Calculation updated Successfully");
			structure.setStatusCode(HttpStatus.ACCEPTED.value());
			return new ResponseEntity<ResponseStructure<ZakathCalculation>>(structure, HttpStatus.ACCEPTED);
		}
		throw new IdNotFoundException();
	}
	
	
	public ResponseEntity<ResponseStructure<List<ZakathCalculation>>> findByUserIdAndYear(int u_id,Year year){
		ResponseStructure<List<ZakathCalculation>> structure= new ResponseStructure<>();
		List<ZakathCalculation> zakathCalculation=cDao.findByUserIdAndYear(u_id, year);
		if(zakathCalculation.isEmpty()) {
			structure.setMessage("Check the provided Id or Year once... It's Invalid");
			structure.setStatusCode(HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<ResponseStructure<List<ZakathCalculation>>>(structure, HttpStatus.NOT_FOUND);
			
		}
		else {
			structure.setData(zakathCalculation);
			structure.setMessage("Calculations found for the particular User with required year");
			structure.setStatusCode(HttpStatus.OK.value());
			return new ResponseEntity<ResponseStructure<List<ZakathCalculation>>>(structure, HttpStatus.OK);
		}
	}
	
	public ResponseEntity<ResponseStructure<List<ZakathCalculation>>> findByUserId(int u_id){
		ResponseStructure<List<ZakathCalculation>> structure= new ResponseStructure<>();
		structure.setData(cDao.findByUserId(u_id));
		structure.setMessage("Calculations found for the particular User with required year");
		structure.setStatusCode(HttpStatus.OK.value());
		return new ResponseEntity<ResponseStructure<List<ZakathCalculation>>>(structure, HttpStatus.OK);
		
	}
	
	public ResponseEntity<ResponseStructure<String>> deleteCalculation(int id){
	    ResponseStructure<String> structure = new ResponseStructure<>();
	    Optional<ZakathCalculation> calculate = repo.findById(id);
	    if(calculate.isPresent()) {
    		cDao.deleteCalculations(id);
    		structure.setData("Calculation deleted");
    		structure.setMessage("Calculation Found");
    		structure.setStatusCode(HttpStatus.OK.value());
    	    return new ResponseEntity<ResponseStructure<String>>(structure,HttpStatus.OK);
	    }
	    else {
	    	throw new IdNotFoundException();
	    }
	    
    	
	}

}
