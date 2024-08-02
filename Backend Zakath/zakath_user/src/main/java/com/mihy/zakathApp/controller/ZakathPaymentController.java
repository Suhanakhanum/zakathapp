package com.mihy.zakathApp.controller;


import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathPaymentHistory;
import com.mihy.zakathApp.service.ZakathPaymentService;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ZakathPaymentController {
	@Autowired
	private ZakathPaymentService service;
	
	@PostMapping("/history/{u_id}/{p_id}")
	public ResponseEntity<ResponseStructure<ZakathPaymentHistory>> saveHistory(@RequestBody ZakathPaymentHistory h, @PathVariable int u_id, @PathVariable int p_id){
		return service.saveHistory(h, u_id, p_id);
	}
	
	@PutMapping("/updateHistory/{u_id}/{p_id}")
	public ResponseEntity<ResponseStructure<ZakathPaymentHistory>> updateHistory(@RequestBody ZakathPaymentHistory h, @PathVariable int u_id, @PathVariable int p_id){
		return service.updateHistory(h, u_id, p_id);
	}
	
	@GetMapping("/getHistory/{u_id}/{p_id}")
	public ResponseEntity<ResponseStructure<List<ZakathPaymentHistory>>> findByUserIdAndDateAndPlanId(@PathVariable int u_id, @PathVariable int p_id){
		return service.findByUserIdAndPlanId(u_id, p_id);
	}
	
	@GetMapping("/getHistory/id")
	public ResponseEntity<ResponseStructure<ZakathPaymentHistory>> findById(@PathVariable int id){
		return service.findById(id);
	}
	

}
