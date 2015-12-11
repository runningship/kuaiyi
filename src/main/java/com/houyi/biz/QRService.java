package com.houyi.biz;

import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import net.glxn.qrgen.core.image.ImageType;
import net.glxn.qrgen.javase.QRCode;

public class QRService {

	public static void main(String[] args) throws IOException{
		File stream = QRCode.from("Hello World").to(ImageType.GIF).withSize(250, 250).file();
		BufferedImage bi = ImageIO.read(stream);
	}
}
