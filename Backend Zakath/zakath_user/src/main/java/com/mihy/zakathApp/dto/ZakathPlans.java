package com.mihy.zakathApp.dto;


import java.time.Year;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Data
@Entity
public class ZakathPlans {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private Year year;
	private String plan_type;
	private Integer month;
	private String purpose;
	private double amount;
	private boolean status;
	@ManyToOne
	@JoinColumn
	@JsonIgnore
	private ZakathUser user;
	@OneToMany(mappedBy = "plan")
	private List<ZakathPaymentHistory> payments;
	

}
