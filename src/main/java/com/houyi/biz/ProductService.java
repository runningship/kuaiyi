package com.houyi.biz;

import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.houyi.entity.Article;
import com.houyi.entity.Product;
import com.houyi.entity.ProductItem;
import com.houyi.entity.QRTableInfo;


@Module(name="/admin/product")
public class ProductService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView save(Product product){
		ModelAndView mv = new ModelAndView();
		product.addtime = new Date();
		dao.saveOrUpdate(product);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Product product){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(product.title)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		product.addtime = new Date();
		dao.saveOrUpdate(product);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Product po = dao.get(Product.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView getItem(String code){
		ModelAndView mv = new ModelAndView();
		ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", code);
		if(item==null){
			throw new GException(PlatformExceptionType.BusinessException,"没有找到商品信息");
		}
		mv.data.put("item", JSONHelper.toJSON(item));

		Product product = dao.get(Product.class, item.productId);
		mv.data.put("product", JSONHelper.toJSON(product));
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView addItems(Integer productId , Integer count , Integer lottery , String pici){
		ModelAndView mv = new ModelAndView();
		if(count==null){
			throw new GException(PlatformExceptionType.BusinessException,"数量不能为空");
		}
		TableService ts = new TableService();
		List<QRTableInfo> tables = ts.getTargetTable(3);
		long start = System.currentTimeMillis();
		for(QRTableInfo table : tables){
			ProductItemWorker w = new ProductItemWorker(table ,count , pici , lottery, productId);
			w.startTime = start;
			w.start();
		}
		return mv;
	}
}
