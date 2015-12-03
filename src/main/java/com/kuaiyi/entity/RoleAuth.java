package com.kuaiyi.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//角色权限
@Entity
public class RoleAuth {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer roleId;
	
	//配置在权限资源文件中
	public String authId;
}
