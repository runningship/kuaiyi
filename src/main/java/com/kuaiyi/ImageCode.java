package com.kuaiyi;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.util.Random;

public class ImageCode {

	private String strRand = "";  
	  
    public final Color[] defCols = { Color.WHITE, Color.BLACK };  
  
    private static String[] CHARS = getChars();  
  
    public final Font[] defFonts = { new Font("隶书", Font.BOLD, 18),  
            new Font("宋体", Font.BOLD, 18), new Font("楷体", Font.BOLD, 18),  
            new Font("黑体", Font.BOLD, 18), new Font("rom7", Font.BOLD, 18) };  
  
    private Font getFont(int i) {  
        Random random = new Random(new Double(Math.random() * 10000 * (i + 1))  
                .longValue());  
        int a = random.nextInt(defFonts.length);  
        AffineTransform trans = new AffineTransform();  
        trans.scale(1 + random.nextFloat() * 0.2,  
                0.95 + random.nextFloat() * 0.65);  
        return defFonts[a].deriveFont(trans);  
    }  
  
    public BufferedImage creatImage() {  
        int width = 75, height = 20;  
        BufferedImage image = new BufferedImage(width, height,  
                BufferedImage.TYPE_INT_RGB);  
        Graphics g = image.getGraphics();  
  
        Random random = new Random();  
        g.setColor(new Color(202, 255, 255));  
        g.fillRect(0, 0, width, height);  
  
        String arr[] = CHARS;  
  
        Random rm = new Random(new Double(Math.random() * 10000 * 59)  
                .longValue());  
        g.setColor(Color.BLACK);  
        for (int i = 0; i < 4; i++) {  
            String rand = arr[rm.nextInt(arr.length)];  
            strRand += rand;  
            g.setFont(getFont(i));  
            if (i == 0)  
                g.drawString(rand, 2 + random.nextInt(2), 20);  
            else  
                g.drawString(rand, 16 * i + 2 + random.nextInt(3), 20);  
        }  
        g.dispose();  
        return image;  
    }  
  
    public String getStrRand() {  
        return strRand;  
    }  
  
    public void setStrRand(String strRand) {  
        this.strRand = strRand;  
    }  
  
    private static String[] getChars() {  
        String[] chars = null;  
        chars = new String[] { "2", "3", "4", "5", "6", "7", "8", "9", "A",  
                "B", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P",  
                "R", "S", "U", "V", "X", "Y", "Z" };  
        return chars;  
    }
}
