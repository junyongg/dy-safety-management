package com.tx.admin.function.ipfilter.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.tx.admin.function.ipfilter.service.IpFilter;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

public class IpFilterInterceptor extends HandlerInterceptorAdapter {
    protected Log log = LogFactory.getLog(IpFilterInterceptor.class);
    
    /** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
    
    /** IP FILTER */
	@Autowired IpFilter ipFilter;
    
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	

		String clientIP = CommonService.getClientIP(request);
//		System.out.println("당신의 아이피 :: "+clientIP);
		String url = request.getRequestURI();
//		System.out.println("URL :: "+ url);
		//개발편의성을 위해 로컬시 예외처리
		//if(!clientIP.equals("192.168.0.2") && !clientIP.equals("0:0:0:0:0:0:0:1")){
			RequestDispatcher rd =request.getRequestDispatcher("/txap/func/ipfilter/error.do");
			if(!ipFilter.checkIP(url, clientIP)){
				rd.forward(request, response);
			}
		//}
			
        return super.preHandle(request, response, handler);
    }
     
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	
    	super.postHandle(request, response, handler, modelAndView);
    }
    
    
}