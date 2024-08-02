package com.mihy.zakathApp.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.mihy.zakathApp.dao.ZakathUserDao;
import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.exception.IdNotFoundException;
import com.mihy.zakathApp.exception.InvalidCredentialsException;

@Service
public class ZakathUserService {
	@Autowired
	private ZakathUserDao dao;
	
	public ResponseEntity<ResponseStructure<ZakathUser>> saveUser(ZakathUser u){
		ResponseStructure<ZakathUser> structure=new ResponseStructure<>();
		structure.setData(dao.saveUser(u));
		structure.setMessage("User saved with ID: "+u.getId());
		structure.setStatusCode(HttpStatus.CREATED.value());
		return new ResponseEntity<ResponseStructure<ZakathUser>>(structure, HttpStatus.CREATED);
	}
	
	public ResponseEntity<ResponseStructure<ZakathUser>> updateUser(ZakathUser u){
		ResponseStructure<ZakathUser> structure=new ResponseStructure<>();
		structure.setData(dao.updateUser(u));
		structure.setMessage("User Updated Successfully");
		structure.setStatusCode(HttpStatus.ACCEPTED.value());
		return new ResponseEntity<ResponseStructure<ZakathUser>>(structure, HttpStatus.ACCEPTED);
	}
	
	public ResponseEntity<ResponseStructure<ZakathUser>> findById(int id){
		ResponseStructure<ZakathUser> structure=new ResponseStructure<>();
		Optional<ZakathUser> recUser=dao.findById(id);
		if(recUser.isPresent()) {
			structure.setData(recUser.get());
			structure.setMessage("User Found");
			structure.setStatusCode(HttpStatus.OK.value());
			return new ResponseEntity<ResponseStructure<ZakathUser>>(structure, HttpStatus.OK);
		}
		else {
			throw new IdNotFoundException();
		}
	}
	
	public ResponseEntity<ResponseStructure<String>> deleteUser(int id){
		ResponseStructure<String> structure=new ResponseStructure<>();
		Optional<ZakathUser> recUser=dao.findById(id);
		if(recUser.isPresent()) {
			structure.setData("User Found");
			structure.setMessage("User Deleted Successfully");
			structure.setStatusCode(HttpStatus.OK.value());
			dao.deleteUser(id);
			return new ResponseEntity<>(structure, HttpStatus.OK);
		}
		else {
			structure.setData("User Not Found");
			structure.setMessage("Not Deleted");
			structure.setStatusCode(HttpStatus.NOT_FOUND.value());
			return new ResponseEntity<ResponseStructure<String>>(structure, HttpStatus.NOT_FOUND);
		}
	}
	
	public ResponseEntity<ResponseStructure<ZakathUser>> verifyByEmailAndPassword(String email, String password){
		ResponseStructure<ZakathUser> structure=new ResponseStructure<>();
		Optional<ZakathUser> recUser=dao.verifyByEmailAndPassword(email, password);
		if(recUser.isPresent()) {
			structure.setData(recUser.get());
			structure.setMessage("User Verified Successfully");
			structure.setStatusCode(HttpStatus.OK.value());
			return new ResponseEntity<ResponseStructure<ZakathUser>>(structure, HttpStatus.OK);
		}
		else {
			throw new InvalidCredentialsException();
		}
	}
	
}
