package com.tx.admin.program.application.service;

import javax.servlet.http.HttpServletRequest;

public interface ApplicationService {

	/**
	 * 결제만료로 업데이트
	 * @param req 
	 * */
	public void checkExpiredDate(String type, HttpServletRequest req) throws Exception;	
	
	/**
	 * 관람완료로 업데이트
	 * @param req 
	 * */
	public void ViewExpiredDate(String type, HttpServletRequest req) throws Exception;	
}
