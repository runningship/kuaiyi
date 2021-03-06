<%@page import="com.houyi.util.FileHelper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.io.filefilter.DirectoryFileFilter"%>
<%@page import="org.apache.commons.io.filefilter.FileFileFilter"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//需要缓存
String rootPath = request.getServletContext().getRealPath("/public/mobile/");
String cssPath = request.getServletContext().getRealPath("/public/mobile/css");
String jsPath = request.getServletContext().getRealPath("/public/mobile/js");
String htmlPath = request.getServletContext().getRealPath("/public/mobile/html");
String imgPath = request.getServletContext().getRealPath("/public/mobile/images");
List<File> allFiles = new ArrayList<File>();
allFiles.addAll(FileHelper.listFiles(new File(cssPath)));
allFiles.addAll(FileHelper.listFiles(new File(jsPath)));
allFiles.addAll(FileHelper.listFiles(new File(htmlPath)));
allFiles.addAll(FileHelper.listFiles(new File(imgPath)));
JSONArray files = new JSONArray();
JSONObject jobj = new JSONObject();
for(File file : allFiles){
	if(file.isDirectory()){
		continue;
	}
	if(file.getPath().contains("\\ad\\")){
		continue;
	}
	String fileName =file.getAbsolutePath().replace(rootPath, "").replace("\\","/"); 
	jobj.put(fileName , file.length());
	files.add(fileName);
}
jobj.put("files", files);
//jobj.put("statusBarHeight", 25);
String server = request.getServerName();
if("192.168.1.222".equals(server)){
	jobj.put("version","debug");	
}else{
	jobj.put("version",15121101);
}
//jobj.put("version",15110904);
out.write(jobj.toString());
%>
