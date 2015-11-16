package com.youwei.kuaiyi.chat.entity;

import javax.persistence.Entity;

/**
 * 个人资料
 * @author xzye
 */
@Entity
public class VCard {
	public Integer id;
	
	public Integer uid;
	
	public String avatar;
	
	public String sign;
	
	public String nickname;
	
	public String address;
	
	public String gender;
	
	public String province;
	
	public String city;
}
