package com.houyi.biz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Record {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer uid;
	
	public Integer productId;
	
	public Integer ProductItemId;
	
	//扫码地理位置
	public Float lat;
	
	public Float lng;
	
	//扫描设备
	public String device;
	
	public Date addtime;
	
	/**
	 * 1 扫描记录 , 2 兑奖记录 ,3 积分记录
	 */
	public Integer type;
}
