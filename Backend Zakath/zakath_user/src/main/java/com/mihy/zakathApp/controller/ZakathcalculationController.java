package com.mihy.zakathApp.controller;

import java.time.Year;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathCalculation;
import com.mihy.zakathApp.dto.ZakathUser;
import com.mihy.zakathApp.exception.IdNotFoundException;
import com.mihy.zakathApp.service.ZakathCalculationService;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ZakathcalculationController {
	@Autowired
	private ZakathCalculationService service;
	
	@PostMapping("/calculate/{u_id}")
	public ResponseEntity<ResponseStructure<ZakathCalculation>> saveCalculation(@RequestBody ZakathCalculation c, @PathVariable int u_id){
		return service.saveCalculation(c, u_id);
	}
	
	@PutMapping("/updateCalculation/{u_id}")
	public ResponseEntity<ResponseStructure<ZakathCalculation>> updateCalculation(@RequestBody ZakathCalculation c, @PathVariable int u_id){
		return service.updateCalculation(c, u_id);
	}
	
	@GetMapping("/getCalculations/{u_id}")
	public ResponseEntity<ResponseStructure<List<ZakathCalculation>>> findByUserIdAndYear(@PathVariable int u_id){
		return service.findByUserId(u_id);
	}
	
	@DeleteMapping("/deleteCalculation/{id}")
	public ResponseEntity<ResponseStructure<String>> deleteCalculations(@PathVariable int id){
		return service.deleteCalculation(id);
	}
}