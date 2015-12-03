package com.kuaiyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Article {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public Integer parentId;
	
	public Integer orderx;
	
	public Date addtime;
	
	//当type=conts时，有效
	public String conts;
	
	public String _site;
}
