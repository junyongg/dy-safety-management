package com.tx.admin.service.crawling.type;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.tx.common.component.ComponentService;


public class InstagramCrawling {
	
	public InstagramCrawling(ComponentService Component, ChromeDriver driver) {
		try {
			Thread.sleep(3000);
			
			
			Thread.sleep(1000);
			driver.findElement(By.cssSelector("#loginForm > div > div:nth-child(1) > div > label > input")).sendKeys("wjsskaansghkwoeks@gmail.com");
			driver.findElement(By.cssSelector("#loginForm > div > div:nth-child(2) > div > label > input")).sendKeys("qwer4321!");
			driver.findElement(By.cssSelector("#loginForm > div > div:nth-child(3) > button")).click();
			Thread.sleep(3000);
			driver.get("https://www.instagram.com/jncf5800/");
			Thread.sleep(3000);
			
			HashMap<String,Object> c = new HashMap<String,Object>();
			//첫번째 클릭
			driver.findElement(By.cssSelector("#react-root > section > main > div > div > article > div:nth-child(1) > div > div:nth-child(1) > div:nth-child(1) > a")).sendKeys(Keys.ENTER);
			Thread.sleep(3000);
			String contents ;
			//컨텐츠
			contents = driver.findElement(By.cssSelector("div > article > div> div> ul > div > li > div > div > div> span")).getText();
			contents = Normalizer.normalize(contents, Normalizer.Form.NFC);
			c.put("content",contents);
			//컨텐츠
			c.put("title","Instagram");
			String img ;
			try{
				img = driver.findElement(By.cssSelector("div > div  > div > img")).getAttribute("src");
			}catch(Exception e){
				img = "";
			}
			
			Date CurrentTime = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
			String date = format.format(CurrentTime);
			
			String ImgName = "insta_" + date;
			c.put("img",saveImage(img,ImgName));
			
//			c.put("img",img);
			c.put("type", "instagram");
			Component.createData("Crawling.CrawlingInsert", c);
			driver.quit();
		}catch(Exception e) {
			System.out.println("instagram 에러:" + e);
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
