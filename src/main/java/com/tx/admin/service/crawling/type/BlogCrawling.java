package com.tx.admin.service.crawling.type;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.annotation.Resource;

import org.openqa.selenium.By;
import org.openqa.selenium.chrome.ChromeDriver;

import com.tx.common.component.ComponentService;




public class BlogCrawling {
	/**
	 * @2020-08-27
	 * 블로그 크롤링
	 */
	public BlogCrawling(ComponentService Component, ChromeDriver driver) {
		try {
			
			Date CurrentTime = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
			String date = format.format(CurrentTime);
			
			HashMap<String,Object> map = new HashMap<>();
			//iframe 전환
//			driver.switchTo().frame("mainFrame");
//		    driver.findElement(By.cssSelector("ul.thumblist > li:nth-child(1)")).click();
//		    driver.getPageSource();
		    
		    Thread.sleep(1000);
		    
		    String title = driver.findElement(By.cssSelector("div.pcol1 > div > p > span")).getText();
		    map.put("title", title);
		    try {
		    	String imgsrc = driver.findElement(By.cssSelector("div.se-module-image > a > img")).getAttribute("src");
		    	String ImgName = "blog_" + date;
		    	map.put("img",saveImage(imgsrc,ImgName));
		    }catch(Exception e) {
		    	map.put("img","");
		    }
		    String Content = driver.findElement(By.cssSelector("div.se-main-container")).getText();
		    map.put("content", Content);
		    map.put("type", "blog");
		    //insert
		    Component.createData("Crawling.CrawlingInsert", map);
			driver.quit();
		}catch(Exception e) {
			System.out.println("blog에러 :" + e);
			driver.quit();
		}
	}
	
	
	public String saveImage(String imgurl,String ImgName) throws Exception{
		URL url = null;
		InputStream in = null;
		OutputStream out = null;
		String result = null;
		
		try {
			String path = "/resources/img/blog/";
			String property = "/usr/local/server/apache-tomcat-9.0.24/webapps/ROOT";
//			String property = "/home/tronix/was/www/jact/webapps/ROOT";
//			String property = "C:/workspace/work/jncf/src/main/webapp";
//			String path = property + "/resources/img/blog/";
			
			url = new URL(imgurl);
//			imgurl = imgurl.substring(imgurl.lastIpropertiespathndexOf("/"),imgurl.lastIndexOf("?"));
			in = url.openStream();
			out = new FileOutputStream(property + path + ImgName+".png");
			
			while(true) {
				int data = in.read();
				if(data == -1) {
					break;
				}
				out.write(data);
			}
			result = path+ ImgName.trim()+".png";
			in.close();
			out.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(in != null) {in.close();}
			if(out !=null) {out.close();}
		}
		return result;
	}
	
}
