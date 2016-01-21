package com.houyi.biz;

import java.util.Date;
import java.util.List;
import java.util.Map;
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
	
	private List<QRTableInfo> getTableNotFull(){
		List<QRTableInfo> list = dao.listByParams(QRTableInfo.class, "from QRTableInfo where size < ? ", MAX_TABLE_ROWS);
		return list;
	}
	
	public QRTableInfo addNewQRTable(int offset){
		String sql = "if not exists (select * from sysobjects where name='ProductItem_"+offset+"' and xtype='U') CREATE TABLE  [dbo].[ProductItem_"+offset+"] ([id] int NOT NULL IDENTITY(1,1) ,[qrCode] nvarchar(50) NOT NULL ,[verifyCode] nvarchar(50) NULL ,[productId] int NOT NULL ,[lottery] int NULL ,[lotteryActive] int NULL ,[lotteryOwnerId] int NULL ,[pici] nvarchar(50) NULL ,[addtime] datetime NULL)";
//		String sql = "if not exists (select * from sysobjects where name='ProductItem_"+count+"' and xtype='U') CREATE TABLE  [dbo].[ProductItem_"+count+"] ([id] int NULL  ,[qrCode] nvarchar(50) NOT NULL ,[verifyCode] nvarchar(50) NULL ,[productId] int NOT NULL ,[lottery] int NULL ,[lotteryActive] int NULL ,[lotteryOwnerId] int NULL ,[pici] nvarchar(50) NULL ,[addtime] datetime NULL)";
		dao.executeSQL(sql);
		QRTableInfo info = new QRTableInfo();
		info.size = 0;
		info.offset = offset;
		dao.saveOrUpdate(info);
		return info;
	}
	
	public List<QRTableInfo> getTargetTable(int count){
		List<QRTableInfo> list = getTableNotFull();
		if(list.size()<count){
			int needAddCount = count-list.size();
			List<Map> result = dao.listAsMap("select max(offset) as maxOffset from QRTableInfo");
			Integer currentMaxOffset = 0;
			if(result.get(0).get("maxOffset")!=null){
				currentMaxOffset = (Integer)result.get(0).get("maxOffset");
			}
			for(int i=1;i<=needAddCount;i++){
				addNewQRTable(currentMaxOffset+i);
			}
			return getTargetTable(count);
		}
		return list;
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
		TableService ts = new TableService();
		List<QRTableInfo> tables = ts.getTargetTable(3);
		for(QRTableInfo table : tables){
			ProductItemWorker w = new ProductItemWorker(table ,5 , "" , 10,123);
			w.startTime = start;
			w.start();
		}
	}
	
}

