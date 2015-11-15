package com.youwei.kuaiyi.chat.entity;

import java.util.Date;

import javax.persistence.Entity;

/**
 * 联系人
 * @author xzye
 */
@Entity
public class ChatGroup {
	public Integer id;
	
	public Integer ownerId;
	
	public String name;
	
	public Date addtime;
}
