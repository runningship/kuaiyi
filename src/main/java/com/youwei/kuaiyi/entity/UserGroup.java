package com.youwei.kuaiyi.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 用户，组 关联关系
 */
@Entity
public class UserGroup {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer gid;
	
	public Integer uid;
	
}
