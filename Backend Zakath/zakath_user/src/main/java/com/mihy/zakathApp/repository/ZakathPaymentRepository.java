package com.mihy.zakathApp.repository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.format.annotation.DateTimeFormat;

import com.mihy.zakathApp.dto.ZakathPaymentHistory;

public interface ZakathPaymentRepository extends JpaRepository<ZakathPaymentHistory, Integer>{
	@Query("select h from ZakathPaymentHistory h where h.user.id=?1 and  h.plan.id=?2 ")
	List<ZakathPaymentHistory> findByUserIdAndPlanId(int u_id,int p_id);

}
