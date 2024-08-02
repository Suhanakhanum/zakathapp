package com.mihy.zakathApp.dao;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.repository.ZakathUserRepository;

@Repository
public class ZakathUserDao {
	@Autowired
	private ZakathUserRepository repository;
	
	public ZakathUser saveUser(ZakathUser u) {
		return repository.save(u);
	}
	
	public ZakathUser updateUser(ZakathUser u) {
		return repository.save(u);
	}
	
	public Optional<ZakathUser> findById(int id) {
		return repository.findById(id);
	}
	
	public void deleteUser(int id) {
		 repository.deleteById(id);
	}
	
	public Optional<ZakathUser> verifyByEmailAndPassword(String email, String password){
		return repository.verifyByEmailAndPassword(email, password);
	}
}
