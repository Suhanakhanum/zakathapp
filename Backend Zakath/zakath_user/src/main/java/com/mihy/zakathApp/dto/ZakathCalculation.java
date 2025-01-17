package com.mihy.zakathApp.dto;

import java.time.Year;

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
public class ZakathCalculation {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int gold_carat_type_one;
	private double total_grams_of_gold_type_one;
	private double gold_price_type_one;
	private double goldAmountOne;
	private double goldZakathOne;
	private int gold_carat_type_two;
	private double total_grams_of_gold_type_two;
	private double gold_price_type_two;
	private double goldAmountTwo;
	private double goldZakathTwo;
	private double total_grams_of_silver;
	private double silver_price;
	private double silverAmount;
	private double silverZakath;
	private double total_income;
	private double incomeLiability;
	private double incomeZakath;
	private double total_cash;
	private double cashLiability;
	private double cashZakath;
	private double totalZakath;
	private Year year;
	@ManyToOne
	@JoinColumn
	@JsonIgnore
	private ZakathUser user;

}
