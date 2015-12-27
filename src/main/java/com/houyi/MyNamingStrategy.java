package com.houyi;

import org.hibernate.cfg.DefaultNamingStrategy;

import com.houyi.entity.ProductItem;


public class MyNamingStrategy extends DefaultNamingStrategy{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private static MyNamingStrategy instance = new MyNamingStrategy();
	
	public int offset =1;
	
	@Override
    public String classToTableName(String className) {
        if(className.equals(ProductItem.class.getSimpleName())) {
            className = className+"_"+offset;
        }
        return super.classToTableName(className);
    }
	
	public static MyNamingStrategy getInstance(){
		return instance;
	}
}
