package com.kuaiyi;

import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

@Module(name="/")
public class YzmService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView yzm(){
		ModelAndView mv = new ModelAndView();
		HttpSession session = ThreadSession.getHttpSession();
        ImageCode image = new ImageCode();  
        // 将四位数字的验证码保存到Session中.
        HttpServletResponse response = ThreadSession.getHttpservletresponse();
//        // 禁止图像缓存。  
        response.setHeader("Pragma", "no-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);  
        response.setContentType("image/jpeg");  
  
        // 将图像输出到Servlet输出流中。  
        ServletOutputStream outStream;
		try {
			outStream = response.getOutputStream();
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(outStream);  
	        encoder.encode(image.creatImage());  
	        outStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
        session.setAttribute(MakesiteConstant.Session_Attr_YZM, image.getStrRand());
        mv.outputByService = true;
		return mv;
	}
}
