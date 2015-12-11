package com.houyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//通知
@Entity
public class Feedback {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String title;

	public String name;
	
	public String contact;
	
	public String conts;
	
	public Date addtime;
	
	public String email;
	
	public String _site;
}
