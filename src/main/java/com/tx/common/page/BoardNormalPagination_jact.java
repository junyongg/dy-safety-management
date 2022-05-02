package com.tx.common.page;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

/**
 * @Pagination
 * Jsp 화면 페이지 처리 UI 생성 클래스 (게시판) 
 * @author 신희원
 * @version 1.0
 * @since 2014-11-14
 */
public class BoardNormalPagination_jact extends AbstractPaginationRenderer implements ServletContextAware{
	public BoardNormalPagination_jact() {
	} 
	
	public void initVariables(){
		firstPageLabel    = "<li><button type=\"button\" class=\"btn-page2\" title=\"처음으로\" onclick=\"{0}({1});return false; \" ><span class=\"icon prevAll\"></span></button></li>"; 
        previousPageLabel = "<li><button type=\"button\" class=\"btn-page2\" title=\"이전\" onclick=\"{0}({1});return false; \" ><span class=\"icon prev\"></span></button></li>"; 
        currentPageLabel  = "<li class=\"active\"><a href=\"javascript:;\" title=\"선택됨\"><span class=\"num\">{0}</span></a></li>";
        otherPageLabel    = "<li><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false;\" title=\"선택안됨\"><span class=\"num\">{2}</span></a></li>";
        nextPageLabel     = "<li><button type=\"button\" class=\"btn-page2\" title=\"다음\" onclick=\"{0}({1});return false; \" ><span class=\"icon next\"></span></button></li>"; 
        lastPageLabel     = "<li><button type=\"button\" class=\"btn-page2\" title=\"끝으로\" onclick=\"{0}({1});return false; \" ><span class=\"icon nextAll\"></span></button></li>"; 
	} 
	
	public void setServletContext(ServletContext servletContext){
		initVariables();
	} 
}

