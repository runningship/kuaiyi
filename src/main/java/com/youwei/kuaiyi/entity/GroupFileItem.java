package com.youwei.kuaiyi.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 用户组共享文件
 */
@Entity
public class GroupFileItem {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//SharedFile Id
	public Integer fileId;
	
	public Integer groupId;
	
}
