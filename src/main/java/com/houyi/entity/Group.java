package com.houyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

//用户组
@Entity
@Table(name="uc_group")
public class Group {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public Integer parentId;
	
	public Integer owner;
	
	public Date addtime;
	
}
