package com.houyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//通知
@Entity
public class Notice {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//发送人
	public Integer senderId;
	
	public String title;
	
	public String conts;
	
	public Date addtime;
	
	public String _site;
	
}
