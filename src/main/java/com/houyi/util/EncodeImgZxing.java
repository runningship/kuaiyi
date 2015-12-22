package com.houyi.util;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;  
import java.io.File;  
import java.io.IOException;  
import java.io.OutputStream;  
import java.util.EnumMap;  
  

import javax.imageio.ImageIO;  
  

import com.google.zxing.BarcodeFormat;  
import com.google.zxing.EncodeHintType;  
import com.google.zxing.MultiFormatWriter;  
import com.google.zxing.common.BitMatrix;  
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

public class EncodeImgZxing {
	//二维码颜色  
    private static final int BLACK = 0xFF000000;//0xFFFF0000，红色  
    //二维码背景色  
    private static final int WHITE = 0xFFFFFFFF;//0xFF0000FF，蓝色  
    //注：二维码颜色色差大，扫描快，但如果"BLACK'设置为黑色外其他颜色，可能无法扫描  
    //二维码图片宽度  
    private static final int width = 200;  
    //二维码图片高度  
    private static final int height = 200;  
    //二维码格式参数  
    private static final EnumMap<EncodeHintType, Object> hints = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);  
    static{  
        /*二维码的纠错级别(排错率),4个级别： 
         L (7%)、 
         M (15%)、 
         Q (25%)、 
         H (30%)(最高H) 
         纠错信息同样存储在二维码中，纠错级别越高，纠错信息占用的空间越多，那么能存储的有用讯息就越少；共有四级； 
         选择M，扫描速度快。 
         */  
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);  
        // 二维码边界空白大小 1,2,3,4 (4为默认,最大)  
        hints.put(EncodeHintType.MARGIN, 0);  
        hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");  
        hints.put(EncodeHintType.MAX_SIZE, 350);  
        hints.put(EncodeHintType.MIN_SIZE, 150);  
    }  
    /** 
     * 绘制二维码 
     * @param contents 二维码内容   
     * @return image 二维码图片 
     * */  
    public static BufferedImage encodeImg(String contents){  
        BufferedImage image = null;  
        try{  
            BitMatrix matrix = new MultiFormatWriter().encode(contents, BarcodeFormat.QR_CODE, width, height, hints);  
            image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);  
            int width = matrix.getWidth();  
            int height = matrix.getHeight();  
            for(int x = 0; x < width; x++){  
                for(int y =0;y < height; y++){  
                    image.setRGB(x, y, matrix.get(x, y) ? BLACK : WHITE);  
                }  
            }  
        }catch(Exception e){  
            System.out.println("生成二维码失败"+e.getMessage());  
        }  
        return image;  
    }  
      
    /** 
     * 二维码输出到文件 
     *  @param contents 二维码内容 
     * @param format 图片格式 
     * @param file 输出文件 
     * */  
    public static void writeToFile(String contents,File logoImg ,String format,File file){  
        BufferedImage image = encodeImg(contents);  
        //image = encodeImgLogo(image , logoImg);
        try {  
            ImageIO.write(image, format, file);  
        } catch (IOException e) {  
            System.out.println("二维码写入文件失败"+e.getMessage());  
        }  
    }  
    /** 
     * 二维码流式输出 
     *  @param contents 二维码内容 
     * @param format 图片格式 
     * @param stream 输出流 
     * */  
    public static void writeToStream(String contents,File logoImg , String format,OutputStream stream){  
        BufferedImage image = encodeImg(contents);
        image = encodeImgLogo(image, logoImg);
        try {  
            ImageIO.write(image, format, stream);  
        } catch (IOException e) {  
            System.out.println("二维码写入流失败"+e.getMessage());  
        }  
    }  
    
    /** 
     * 二维码绘制logo 
     * @param twodimensioncodeImg 二维码图片文件 
     * @param logoImg logo图片文件 
     * */  
    private static BufferedImage encodeImgLogo(BufferedImage twodimensioncode , File logoImg){  
        try{  
            //获取画笔  
            Graphics2D g = twodimensioncode.createGraphics();  
            //读取logo图片  
            BufferedImage logo = ImageIO.read(logoImg);  
            //设置二维码大小，太大，会覆盖二维码，此处20%  
            int logoWidth = logo.getWidth(null) > twodimensioncode.getWidth()*2 /10 ? (twodimensioncode.getWidth()*2 /10) : logo.getWidth(null);  
            int logoHeight = logo.getHeight(null) > twodimensioncode.getHeight()*2 /10 ? (twodimensioncode.getHeight()*2 /10) : logo.getHeight(null);  
            //设置logo图片放置位置  
            //中心  
            int x = (twodimensioncode.getWidth() - logoWidth) / 2;  
            int y = (twodimensioncode.getHeight() - logoHeight) / 2;  
            //右下角，15为调整值  
//          int x = twodimensioncode.getWidth()  - logoWidth-15;  
//          int y = twodimensioncode.getHeight() - logoHeight-15;  
            //开始合并绘制图片  
            g.drawImage(logo, x, y, logoWidth, logoHeight, null);  
            g.drawRoundRect(x, y, logoWidth, logoHeight, 15 ,15);  
            //logo边框大小  
            g.setStroke(new BasicStroke(2));  
            //logo边框颜色  
            g.setColor(Color.WHITE);  
            g.drawRect(x, y, logoWidth, logoHeight);  
            g.dispose();  
            logo.flush();  
            twodimensioncode.flush();  
        }catch(Exception ex){
        	ex.printStackTrace();
            System.out.println("二维码绘制logo失败");  
        }  
        return twodimensioncode;  
    }  
    public static void main(String[] args){
    	String contents = "http://kcloud.iflytek.com/p/v/14503241303791";  
        String format = "png"; //***此处如果格式为"gif"，则logo图片为黑色，其他格式ok  
        //生成二维码  
        File logoImg = new File("G:\\8034.png");  
        File img = new File("D:"+File.separator+"csdn.jpg");  
        EncodeImgZxing.writeToFile(contents, logoImg, format, img); 
    }
}
