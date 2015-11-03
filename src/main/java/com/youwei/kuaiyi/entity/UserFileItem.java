package com.youwei.kuaiyi.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 共享给个人的文件
 */
@Entity
public class UserFileItem {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//SharedFile Id
	public Integer fileId;
	
	public Integer uid;
	
}
