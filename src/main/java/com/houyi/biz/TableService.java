package com.houyi.biz;

import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.hibernate.HibernateException;
import org.hibernate.MappingException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.mapping.Table;

import com.houyi.StartUpListener;
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
	
	public void insertToTable(QRTableInfo table){
		
	}
	
	public static void main(String[] args){
		StartUpListener.initDataSource();
		TableService ts = new TableService();
		QRTableInfo target = ts.getTargetTable();
		System.out.println("target table offset is "+ target.offset);
	}
}
