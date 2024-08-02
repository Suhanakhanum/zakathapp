package com.mihy.zakathApp.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.mihy.zakathApp.dto.ZakathUser;

public interface ZakathUserRepository extends JpaRepository<ZakathUser, Integer>{
	@Query("select u from ZakathUser u where u.email=?1 and u.password=?2")
	Optional<ZakathUser> verifyByEmailAndPassword(String email,String password);
	

}
