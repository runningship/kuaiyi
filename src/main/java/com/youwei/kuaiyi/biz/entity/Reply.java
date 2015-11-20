package com.youwei.kuaiyi.biz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//针对评论的回复
@Entity
public class Reply {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//回复标识
	public Integer commentId;
	
	//谁回复的
	public Integer replyerUid;
	
	//回复谁
	public Integer replyToUid;
	
	public String conts;
	
	public Date addtime;
}
