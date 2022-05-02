package com.tx.common.page.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;
import com.tx.common.page.PageAccess;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @PageAccess
 * 페이징 처리를 담당한다.
 * PaginationInfo 클래스에 갱신하기위해
 * 페이지 처리를 원하는 페이지의 현재 페이지 번호와 전체 데이터 개수를 조회하는 쿼리문을 파라미터 값으로 받는다.
 * @author 신희원
 * @version 1.0
 * @since 2014-11-14
 */
@Service("PageAccess")
public class PageAccessImpl extends EgovAbstractServiceImpl implements PageAccess{
	

	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	/**
	 * 페이지 계산 처리
	 * @throws Exception
	 */
	@Override
	public PaginationInfo getPagInfo(Integer pageIndex, String query) throws Exception{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(SettingData.BOARD_RECORD_COUNT_PER_PAGE);
		paginationInfo.setPageSize(SettingData.BOARD_PAGE_SIZE);
		paginationInfo.setTotalRecordCount(Component.getCount(query));
		if(paginationInfo.getCurrentPageNo() > paginationInfo.getTotalPageCount()){
			paginationInfo.setCurrentPageNo(paginationInfo.getTotalPageCount());
		}
		
		return paginationInfo;
	}
	
	/**
	 * 페이지 계산 처리 (파라미터 사용)
	 * @throws Exception
	 */
	@Override
	public PaginationInfo getPagInfo(Integer pageIndex, String query, Object obj) throws Exception{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(SettingData.BOARD_RECORD_COUNT_PER_PAGE);
		paginationInfo.setPageSize(SettingData.BOARD_PAGE_SIZE);
		paginationInfo.setTotalRecordCount(Component.getCount(query, obj));
		if(paginationInfo.getCurrentPageNo() > paginationInfo.getTotalPageCount()){
			paginationInfo.setCurrentPageNo(paginationInfo.getTotalPageCount());
		}
		
		return paginationInfo;
	}
	
	/**
	 * 페이지 계산 처리 (파라미터 사용 및 page unit 처리)
	 * @throws Exception
	 */
	@Override
	public PaginationInfo getPagInfo(Integer pageIndex, String query, Object obj,Integer PageUnit) throws Exception{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(PageUnit);
		paginationInfo.setPageSize(SettingData.BOARD_PAGE_SIZE);
		paginationInfo.setTotalRecordCount(Component.getCount(query,obj));
		if(paginationInfo.getCurrentPageNo() > paginationInfo.getTotalPageCount()){
			paginationInfo.setCurrentPageNo(paginationInfo.getTotalPageCount());
		}
		
		return paginationInfo;
	}
	
	/**
	 * 페이지 계산 처리 (파라미터 사용 및 pageunit,pagesize 처리)
	 * @throws Exception
	 */
	@Override
	public PaginationInfo getPagInfo(Integer pageIndex, String query, Object obj,Integer PageUnit,Integer PageSize) throws Exception{
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(PageUnit);
		paginationInfo.setPageSize(PageSize);
		paginationInfo.setTotalRecordCount(Component.getCount(query,obj));
		
		if(paginationInfo.getCurrentPageNo() > paginationInfo.getTotalPageCount()){
			paginationInfo.setCurrentPageNo(paginationInfo.getTotalPageCount());
		}
		
		return paginationInfo;
	}
	
	
	
	
}