package com.houyi.chat.entity;

import java.util.Date;

import javax.persistence.Entity;

/**
 * @author xzye
 */
@Entity
public class Invitation {
	public Integer id;
	
	public Integer inviterId;
	
	public Integer inviteeId;
	
	public String msg;
	
	public Date addtime;
	
	//1 等待回复 , 2 同意 , 3,拒绝
	public Integer status;
}
