package com.houyi.biz;

import java.util.Date;
import java.util.Random;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.SessionFactoryBuilder;
import org.bc.sdak.TransactionalServiceHelper;
import org.hibernate.CacheMode;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.houyi.MyInterceptor;
import com.houyi.entity.ProductItem;
import com.houyi.entity.QRTableInfo;

public class ProductItemWorker extends Thread {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	private int total;
	public long startTime=0;
	private int batchSize = 5000;
	private String pici = "";
	private int productId;
	private int lottery;
	private QRTableInfo tableInfo;
	public ProductItemWorker(QRTableInfo tableInfo , int total , String pici , int lottery , int productId) {
		super();
		this.tableInfo = tableInfo;
		this.total = total;
		this.pici = pici;
		this.lottery = lottery;
		this.productId = productId;
	}

	@Override
	public void run() {
		MyInterceptor.getInstance().tableNameSuffix.set(tableInfo.offset);
		for(int i=0;i<total/batchSize; i++){
			add(batchSize);
		}
		add(total%batchSize);
		System.out.println("table "+tableInfo.offset+" cost  "+ (System.currentTimeMillis()-startTime)/1000 + " secs");
	}
	
	private void add(int count){
		Session session = SessionFactoryBuilder.buildOrGet().getCurrentSession();
		Transaction tran = session.beginTransaction();
		session.setCacheMode(CacheMode.IGNORE);
		Random r = new Random();
		for(int i=0;i<count;i++){
			ProductItem item = new ProductItem();
			item.addtime = new Date();
			item.lotteryActive = 0;
			item.pici = pici;
			item.lottery=lottery;
			item.productId = productId;
			item.qrCode = System.currentTimeMillis()+"."+tableInfo.offset;
			item.verifyCode = String.valueOf(r.nextInt(999999));
			session.save(item);
		}
		//将剩余的提交
		session.flush();
        session.clear();
		tran.commit();
		
		QRTableInfo table = dao.get(QRTableInfo.class, tableInfo.id);
		table.size +=count;
		dao.saveOrUpdate(table);
	}
	
	
}
