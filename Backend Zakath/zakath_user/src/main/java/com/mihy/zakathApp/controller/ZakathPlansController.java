package com.mihy.zakathApp.controller;

import java.time.Year;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.mihy.zakathApp.dto.ResponseStructure;
import com.mihy.zakathApp.dto.ZakathPaymentHistory;
import com.mihy.zakathApp.dto.ZakathPlans;
import com.mihy.zakathApp.service.ZakathPlansService;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class ZakathPlansController {
	@Autowired
	private ZakathPlansService service;
	
	@PostMapping("/plans/{u_id}")
	public ResponseEntity<ResponseStructure<ZakathPlans>> savePlans(@RequestBody ZakathPlans p, @PathVariable int u_id){
		return service.savePlans(p, u_id);
	}
	
	@PutMapping("/updatePlan/{u_id}")
	public ResponseEntity<ResponseStructure<ZakathPlans>> updatePlans(@RequestBody ZakathPlans p, @PathVariable int u_id){
		return service.updatePlans(p, u_id);
	}
	
	@GetMapping("/getPlans/{u_id}/{year}")
	public ResponseEntity<ResponseStructure<List<ZakathPlans>>> findByUserIdAndYear(@PathVariable int u_id, @PathVariable Year year ){
		return service.findByUserIdAndYear(u_id, year);
	}
	
	@GetMapping("/getPlan/{id}")
    public ResponseEntity<ResponseStructure<ZakathPlans>> findById(@PathVariable int id) {
    	return service.findById(id);
    }
}
