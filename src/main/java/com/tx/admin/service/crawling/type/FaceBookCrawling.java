package com.tx.admin.service.crawling.type;

import java.util.HashMap;

import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.chrome.ChromeDriver;

import com.tx.common.component.ComponentService;


public class FaceBookCrawling {
	
	/**
	 * @2020-08-27
	 * 페이스북 크롤링
	 */
	public FaceBookCrawling(ComponentService Component, ChromeDriver driver) {
		try {
			HashMap<String,Object> c = new HashMap<String,Object>();
			//예상치 못한 문제로 처리 닫기
			try {
				Thread.sleep(1000);
				driver.findElement(By.cssSelector("a.autofocus")).click();
			}catch (Exception e) {
				System.out.println("닫기 없음 계속진행");
			}	
			
			Thread.sleep(2000);
				//페이스북 내용 가져오기
				String content = driver.findElement(By.cssSelector("#content_container > div > div:nth-child(3) > div:nth-child(2) > div  > div > div:nth-child(2) > div > div:nth-child(1) > div > div> div > div:nth-child(2) > div > div:nth-child(3) > div:nth-child(2)")).getAttribute("textContent");
				try {
					String img = driver.findElement(By.cssSelector("#content_container > div > div:nth-child(3) > div:nth-child(2) > div  > div > div:nth-child(2) > div > div:nth-child(1) > div > div> div > div:nth-child(2) > div > div:nth-child(3) > div:nth-child(3) img")).getAttribute("src");
					c.put("img",img);
				}catch(Exception e) {
					c.put("img","");
				}
				
				if(content.length() < 1) {
					content = driver.findElement(By.cssSelector("#content_container > div > div:nth-child(3) > div:nth-child(2) > div  > div > div:nth-child(2) > div > div:nth-child(2) > div > div> div > div:nth-child(2) > div > div:nth-child(3) > div:nth-child(2)")).getAttribute("textContent");
					try {
						String img = driver.findElement(By.cssSelector("#content_container > div > div:nth-child(3) > div:nth-child(2) > div  > div > div:nth-child(2) > div > div:nth-child(2) > div > div> div > div:nth-child(2) > div > div:nth-child(3) > div:nth-child(3) img")).getAttribute("src");
						c.put("img",img);
					}catch(Exception e) {
						c.put("img","");
					}
				}
				
				c.put("content",content);
				c.put("title", "FaceBook");
				c.put("type", "facebook");
				Component.createData("Crawling.CrawlingInsert", c);
				driver.quit();
		}catch(Exception e) {
			System.out.println("facebook에러 :" + e);
			driver.quit();
		}
		
	}
}
