package com.houyi.biz.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//卡管理
@Entity
public class LotteryStatistic {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public String conts;
	
}
