package com.houyi.biz;

import java.util.Date;
import java.util.List;
import java.util.Random;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.SessionFactoryBuilder;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.PlatformExceptionType;
import org.hibernate.CacheMode;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.houyi.MyInterceptor;
import com.houyi.StartUpListener;
import com.houyi.entity.Product;
import com.houyi.entity.ProductItem;
import com.houyi.entity.QRTableInfo;

public class TableService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	public static final int MAX_TABLE_ROWS=1000000;
	
	private QRTableInfo getTableNotFull(){
		List<QRTableInfo> list = dao.listByParams(QRTableInfo.class, "from QRTableInfo where size < ? ", MAX_TABLE_ROWS);
		if(list.isEmpty()){
			return null;
		}
		return list.get(0);
	}
	
	public QRTableInfo addNewQRTable(){
		long count = dao.countHql("select count(*) from QRTableInfo");
		count++;
		String sql = "if not exists (select * from sysobjects where name='ProductItem_"+count+"' and xtype='U') CREATE TABLE  [dbo].[ProductItem_"+count+"] ([id] int NOT NULL IDENTITY(1,1) ,[qrCode] nvarchar(50) NOT NULL ,[verifyCode] nvarchar(50) NULL ,[productId] int NOT NULL ,[lottery] int NULL ,[lotteryActive] int NULL ,[lotteryOwnerId] int NULL ,[pici] nvarchar(50) NULL ,[addtime] datetime NULL)";
//		String sql = "if not exists (select * from sysobjects where name='ProductItem_"+count+"' and xtype='U') CREATE TABLE  [dbo].[ProductItem_"+count+"] ([id] int NULL  ,[qrCode] nvarchar(50) NOT NULL ,[verifyCode] nvarchar(50) NULL ,[productId] int NOT NULL ,[lottery] int NULL ,[lotteryActive] int NULL ,[lotteryOwnerId] int NULL ,[pici] nvarchar(50) NULL ,[addtime] datetime NULL)";
		dao.executeSQL(sql);
		QRTableInfo info = new QRTableInfo();
		info.size = 0;
		info.offset = (int)count;
		dao.saveOrUpdate(info);
		return info;
	}
	
	public QRTableInfo getTargetTable(){
		QRTableInfo table = getTableNotFull();
		if(table==null){
			return addNewQRTable();
		}
		return table;
	}
	
	public void addProductItem(int count , Product product){
		QRTableInfo target = getTargetTable();
		if(target==null){
			throw new GException(PlatformExceptionType.BusinessException,"要添加的二维码数量超出限制值，请联系系统管理员");
		}
		if(count<= (MAX_TABLE_ROWS-target.size)){
			//目标表已经足够添加count数量的数据
			innerAddProductItem(target , product , count);
		}else{
			int rest = MAX_TABLE_ROWS-target.size;
			if(rest>0){
				innerAddProductItem(target , product , rest);
			}
			addProductItem(count-rest , product);
		}
	}
	
	private void innerAddProductItem(QRTableInfo target, Product product,int count) {
		MyInterceptor.getInstance().tableNameSuffix.set(target.offset);
		Session session = SessionFactoryBuilder.buildOrGet().getCurrentSession();
		Transaction tran = session.beginTransaction();
		session.setCacheMode(CacheMode.IGNORE);
		Random r = new Random();
		for(int i=0;i<count;i++){
			ProductItem item = new ProductItem();
			item.addtime = new Date();
			item.lotteryActive = 0;
			item.pici = "";
			item.lottery=10;
			item.productId = product.id;
			item.qrCode = System.currentTimeMillis()+"."+target.offset;
			item.verifyCode = String.valueOf(r.nextInt(999999));
			session.save(item);
//			if ( i % 5000 == 0 ) {
//		          //将本批插入的对象立即写入数据库并释放内存
//		          session.flush();
//		          session.clear();
//		          System.out.println(i/5000);
//		    }
		}
		//将剩余的提交
		session.flush();
        session.clear();
		target.size = target.size+count;
		session.saveOrUpdate(target);
		tran.commit();
	}

	public static void main(String[] args){
		StartUpListener.initDataSource();
//		long start = System.currentTimeMillis();
//		TableService ts = new TableService();
//		Product pro = new Product();
//		pro.id=123;
//		for(int i=0;i<1;i++){
//			System.out.println("-----------"+i+"---------------------");
//			ts.addProductItem(5000 , pro);
//		}
//		System.out.println("本次耗时: "+(System.currentTimeMillis()-start)+"毫秒");
		testMutiThread();
	}
	
	public static void testMutiThread(){
		long start = System.currentTimeMillis();
		for(int i=1;i<=20;i++){
			Worker w = new Worker(i,50000);
			w.startTime = start;
			w.start();
		}
	}
	
}

class Worker extends Thread{
	private int tableNameOffset;
	private int total;
	public long startTime=0;
	private int batchSize = 5000;
	public Worker(int tableNameOffset , int total) {
		super();
		this.tableNameOffset = tableNameOffset;
		this.total = total;
	}

	@Override
	public void run() {
		MyInterceptor.getInstance().tableNameSuffix.set(tableNameOffset);
		for(int i=0;i<total/batchSize; i++){
			add(batchSize);
		}
		add(total%batchSize);
		System.out.println("table "+tableNameOffset+" cost  "+ (System.currentTimeMillis()-startTime)/1000 + " secs");
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
			item.pici = "";
			item.lottery=10;
			item.productId = 123;
			item.qrCode = System.currentTimeMillis()+"."+tableNameOffset;
			item.verifyCode = String.valueOf(r.nextInt(999999));
			session.save(item);
		}
		//将剩余的提交
		session.flush();
        session.clear();
		tran.commit();
	}
}