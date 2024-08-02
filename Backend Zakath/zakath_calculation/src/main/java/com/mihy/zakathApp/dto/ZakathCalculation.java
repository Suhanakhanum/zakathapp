package com.mihy.zakathApp.dto;

import java.time.Year;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class ZakathCalculation {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int gold_carat_of_type_one;
	private double total_grams_of_gold_type_one;
	private double gold_price_of_type_one;
	private int gold_carat_of_type_two;
	private double total_grams_of_gold_type_two;
	private double gold_price_of_type_two;
	private double total_grams_of_silver;
	private double silver_price;
	private double total_cash;
	private double total_income;
	private double total_amount;
	private double total_zakath;
	private Year year;

}
