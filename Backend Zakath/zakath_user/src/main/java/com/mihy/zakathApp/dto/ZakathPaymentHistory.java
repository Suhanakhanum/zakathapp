package com.mihy.zakathApp.dto;



import java.time.LocalDate;


import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Data
@Entity
public class ZakathPaymentHistory {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private LocalDate date;
	private double paid_amount;
	private String paid_from;
	private String paid_to;
	private String debited_from;
	private boolean paid_status;
	@ManyToOne
	@JoinColumn
	@JsonIgnore
	private ZakathUser user;
	@ManyToOne
	@JoinColumn
	@JsonIgnore
	private ZakathPlans plan;

}
