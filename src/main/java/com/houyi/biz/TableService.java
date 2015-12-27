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
import org.hibernate.FlushMode;
import org.hibernate.HibernateException;
import org.hibernate.MappingException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.mapping.Table;

import com.houyi.MyNamingStrategy;
import com.houyi.StartUpListener;
import com.houyi.entity.Product;
import com.houyi.entity.ProductItem;
import com.houyi.entity.QRTableInfo;

public class TableService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	public static final int MAX_TABLE_ROWS=10000000;
	
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
		String sql = "CREATE TABLE [dbo].[ProductItem_"+count+"] ([id] int NOT NULL IDENTITY(1,1) ,[qrCode] nvarchar(50) NOT NULL ,[verifyCode] nvarchar(50) NULL ,[productId] int NOT NULL ,[lottery] int NULL ,[lotteryActive] int NULL ,[lotteryOwnerId] int NULL ,[pici] nvarchar(50) NULL ,[addtime] datetime NULL)";
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
	
	public void insertToTable(QRTableInfo table , ProductItem pi){
		MyNamingStrategy.getInstance().offset=table.offset;
		dao.saveOrUpdate(pi);
	}
	
	public void addProductItem(int count , Product product){
		QRTableInfo target = getTableNotFull();
		if(target==null){
			throw new GException(PlatformExceptionType.BusinessException,"要添加的二维码数量超出限制值，请联系系统管理员");
		}
		if(count<= (MAX_TABLE_ROWS-target.size)){
			innerAddProductItem(target , product , count);
		}
	}
	
	private void innerAddProductItem(QRTableInfo target, Product product,int count) {
		Session session = SessionFactoryBuilder.buildOrGet().getCurrentSession();
		Transaction tran = session.beginTransaction();
		session.setCacheMode(CacheMode.IGNORE);
		FlushMode mode = session.getFlushMode();
		Random r = new Random();
		for(int i=0;i<count;i++){
			ProductItem item = new ProductItem();
			item.addtime = new Date();
			item.lotteryActive = 0;
			item.productId = product.id;
			item.qrCode = System.currentTimeMillis()+"."+target.offset;
			item.verifyCode = String.valueOf(r.nextInt(999999));
			dao.saveOrUpdate(item);
			if ( i % 200 == 0 ) {
		          //将本批插入的对象立即写入数据库并释放内存
		          session.flush();   
		          session.clear();   
		    }
		}
		tran.commit();
		//session.close();
	}

	public static void main(String[] args){
		StartUpListener.initDataSource();
		TableService ts = new TableService();
//		ProductItem pi = new ProductItem();
//		pi.productId=1;
//		pi.qrCode = "1212";
		//ts.insertToTable(null, pi);
		Product pro = new Product();
		pro.id=123;
		ts.addProductItem(2 , pro);
//		ts.addNewQRTable();
//		QRTableInfo target = ts.getTargetTable();
//		System.out.println("target table offset is "+ target.offset);
	}
}
