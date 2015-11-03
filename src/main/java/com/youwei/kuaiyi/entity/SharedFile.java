package com.youwei.kuaiyi.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class SharedFile {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String name;
	
	public String path;
	
	//单位K
	public Long size;
	
	public String fileId;
	
	//分享人,上传人
	public Integer uid;
	
	public Date uploadTime;
	
	public Integer publish;
	
	public String _site;
}
