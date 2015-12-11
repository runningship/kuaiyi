<%@page import="com.houyi.util.EndecryptHelper"%>
<%@page import="com.houyi.util.QRCodeUtil"%>
<%@page import="com.google.zxing.EncodeHintType"%>
<%@page import="com.houyi.entity.ProductItem"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="net.glxn.qrgen.core.image.ImageType"%>
<%@page import="net.glxn.qrgen.javase.QRCode"%>
<%@page import="javax.imageio.ImageIO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
ProductItem item = dao.get(ProductItem.class, Integer.valueOf(id));
EndecryptHelper.get3DESEncrypt(item.qrCode, "kuaiyisao");
String code = "kuaiyisao:"+item.qrCode;
//String url = "http://192.168.1.222:7080/public/itemView.jsp?qrCode="+ item.qrCode;
//String url = code;
String url = "http://kcloud.iflytek.com/public/itemView.jsp?qrCode="+item.qrCode; 
//String url = "http://www.zhongjiebao.com/old/product3.html?pici="+item.pici+"&qrCode="+item.qrCode+"&lottery="+item.lottery;

//File stream = QRCode.from(url).to(ImageType.JPG).withSize(250, 250).file();
//BufferedImage bufImg = ImageIO.read(stream);
response.setContentType("image/jpeg");
OutputStream os = response.getOutputStream();
//ImageIO.write(bufImg, "jpg", os);
String realPath = request.getServletContext().getRealPath("public/logo.png");
QRCodeUtil.encode(url, realPath , os , true);

os.close();
out.clear();
out = pageContext.pushBody();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生成二维码</title>
</head>
<body>

</body>
</html>