package com.youwei.kuaiyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Product {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public String vender;
	
	public String vernderCode;
	
	public String verderPlace;
	
	//规格
	public String spec;
	//
	public Date addtime;
	
}
