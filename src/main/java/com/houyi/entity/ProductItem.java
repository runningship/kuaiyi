package com.houyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.DynamicInsert;

@Entity
public class ProductItem {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String qrCode;
	
	//防伪码
	public String verifyCode;
	
	public Integer productId;
	
	//兑奖券金额
	public Integer lottery;
	
	public Date addtime;
	
	//是否已兑奖
	public int lotteryActive;
	
	//优惠券拥有者
	public Integer lotteryOwnerId;
	
	//批次号
	public String pici;
	
}
