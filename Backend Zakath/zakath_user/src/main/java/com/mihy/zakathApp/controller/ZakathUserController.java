package com.mihy.zakathApp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.service.ZakathUserService;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ZakathUserController {
	@Autowired
	private ZakathUserService service;
	
	@PostMapping("/saveUsers")
	public ResponseEntity<ResponseStructure<ZakathUser>> saveUser(@RequestBody ZakathUser u){
		return service.saveUser(u);
	}
	
	@PutMapping("/updateUsers")
	public ResponseEntity<ResponseStructure<ZakathUser>> updateUser(@RequestBody ZakathUser u){
		return service.updateUser(u);
	}
	
	@GetMapping("/fetchUsers/{u_id}")
	public ResponseEntity<ResponseStructure<ZakathUser>> findById(@PathVariable int u_id){
		return service.findById(u_id);
	}
	
	@DeleteMapping("/deleteUsers/{u_id}")
	public ResponseEntity<ResponseStructure<String>> deleteById(@PathVariable int u_id){
		return service.deleteUser(u_id);
	}
	
	@PostMapping("/verifyUsers/verifyByEmailAndPassword")
	public ResponseEntity<ResponseStructure<ZakathUser>> verifyByEmailAndPassword(@RequestParam String email,@RequestParam String password){
		return service.verifyByEmailAndPassword(email, password);
	}

}
