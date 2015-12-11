package com.houyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//通知接收人
@Entity
public class NoticeReceiver {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer noticeId;
	
	//发送人
	public Integer receiverId;

	public Integer hasRead;
	
}
