package com.tx.admin.service.crawling.Imp;


import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.admin.service.crawling.crawlingService;
import com.tx.admin.service.crawling.type.BlogCrawling;
import com.tx.admin.service.crawling.type.FaceBookCrawling;
import com.tx.admin.service.crawling.type.InstagramCrawling;
import com.tx.common.component.ComponentService;

@Service("crawlingService")
public class crawlingServiceImpl implements crawlingService{
	
	@Autowired
	ComponentService Component;
	
	
	/**
	 * @2020-08-26
	 * @Crawling 연결 부분
	 */
	public void Crawling_Start(String type) {
		// 연결
//		System.setProperty("webdriver.chrome.driver", "/data/chrome/chromedriver");
//		System.setProperty("webdriver.chrome.driver", "/home/tronix/was/www/jact/chrome/chromedriver");
		System.setProperty("webdriver.chrome.driver", "C:/workspace/work/jncf/chromedriver.exe");
//		 option추가
		ChromeOptions options = new ChromeOptions();
		  options.addArguments("headless"); //화면 안씀
		  options.addArguments("-no-sandbox");
		  options.addArguments("-disabled-dev-shm-usage");
//		  options.addArguments("--headless", "--disable-gpu");
		  options.addArguments("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36");
		  options.addArguments("--incognito");
		  options.addArguments("lang=ko_KR");
		
		  
		  
		  // Driver Setup
		  try {
			DataInsert(type, options);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 
	 * @2020-08-26
	 * @가져온 데이터 처리하는 부분
	 */
	public void DataInsert(String type, ChromeOptions options) throws Exception {
		String url = "";
		switch (type) {
		case "blog":
			url = "https://blog.naver.com/PostList.nhn?blogId=jact123&categoryNo=0&from=postList";
				try {
					ChromeDriver driver_blog = new ChromeDriver(options);
					
					driver_blog.get(url);
					new BlogCrawling(Component,driver_blog);
				}catch (Exception e) {
					System.out.println("bolg 에러 : "  + e);
				}
			break;
		case "facebook":
			url = "https://www.facebook.com/pg/jact5800/posts/?ref=page_internal";
				try {
					ChromeDriver driver_face = new ChromeDriver(options);
					driver_face.get(url);
					new FaceBookCrawling(Component, driver_face);
				}catch (Exception e) {
					System.out.println("facebook 에러 : "  + e);
				}
			break;
		case "insta":
//			url = "https://www.instagram.com/jncf5800/";
			url = "https://www.instagram.com/";
			try {
				
				ChromeDriver driver_insta = new ChromeDriver(options);
				driver_insta.get(url);
				
				new InstagramCrawling(Component, driver_insta);
			}catch(Exception e) {
				System.out.println("insta 에러 : "  + e);
			}
			break;
		}
	}
	
	
}
