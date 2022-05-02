package com.tx.admin.service.crawling.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tx.admin.service.crawling.crawlingService;
import com.tx.common.component.ComponentService;

@Controller
public class crawlingController {

	@Autowired
	crawlingService crawling;
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	/**
	 * 
	 * 데이터 수집하는 곳
	 */
	@RequestMapping("/crawling.do")
	@Transactional
	public void crawling(
			) throws Exception{
		deleteFile();
		Component.deleteData("Crawling.CrawlingDelete");
		crawling.Crawling_Start("blog");
		crawling.Crawling_Start("insta");
		crawling.Crawling_Start("facebook");
	}
	
	
	/**
	 * 파일 삭제처리
	 */
	public void deleteFile() throws Exception {
//        String property = "/home/tronix/was/www/jact/webapps/ROOT";
//        String property = "/usr/local/server/apache-tomcat-9.0.24/webapps/ROOT";
		String property = "C:/workspace/work/jncf/src/main/webapp";
		String filePath = "/resources/img/blog/";
    	File folder = new File(property+filePath);
    	if(folder.exists()){
			File[] deleteFolderList = folder.listFiles();
			System.out.println("폴더내 사이즈 :: " + deleteFolderList.length);
			if(deleteFolderList.length != 0) {
				System.out.println(deleteFolderList[0].getName());
				deleteFolderList[0].delete(); 
			}
		}
	}
}
