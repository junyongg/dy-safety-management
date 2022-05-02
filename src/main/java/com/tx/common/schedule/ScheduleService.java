package com.tx.common.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import com.tx.admin.service.crawling.crawlingService;
import com.tx.admin.service.crawling.controller.crawlingController;
import com.tx.common.component.ComponentService;

/**
 * @author admin
 * 스케쥴 관리
 *
 */
@Service("ScheduleService")
public class ScheduleService {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;
  
	@Autowired
	crawlingService crawling;
	
//  @Scheduled(cron="0 0 0 * * ?")  
//  @Scheduled(cron="0 0 2 * * ?")
  public void test(){
	  	System.out.println("스케쥴링 시작");
	  	crawlingController c = new crawlingController();
		try {
			c.deleteFile();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Component.deleteData("Crawling.CrawlingDelete");
		crawling.Crawling_Start("blog");
		crawling.Crawling_Start("insta");
		crawling.Crawling_Start("facebook");
     }
}