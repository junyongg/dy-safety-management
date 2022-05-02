package com.tx.common.dto;

import java.io.Serializable;

public class Common implements Serializable {

	private static final long serialVersionUID = 5100802984234952222L;

	/** 검색관련 */
	private String searchCondition = "";	//검색조건 ex) 이름, 성별, 나이 등
	private String[] searchConditionArr;	//검색조건 배열
	private String searchKeyword = "";		//검색 Keyword
	private String keyword2 = "";
	private String[] searchKeywordArr;		//검색 Keyword 배열
	private String searchBeginDate = "";	//날짜 검색 시작 일자
	private String searchEndDate = "";		//날짜 검색 종료 일자
	private String orderCondition = "";		//정렬조건 ex) 최신,조회수
	private String orderBy = "";			//테이블 sort
	private String sortDirect = "";			//ASC, DESC
	
	/** 추가 전달 메세지
	 * ex) "입력이 완료되었습니다."	*/
	private String resultMsg = "";
	
	
	/** Pagination 관련 공용 변수 */
	private int pageUnit = 25;		//페이지 리스트 갯수
	private int pageIndex = 1;	//현재페이지
	private int firstIndex;	//첫번째 인덱스
	private int lastIndex;	//마지막 인덱스
	private int recordCountPerPage;	//페이지 카운트 수
	
	/** ROWNUM */
	private int RNUM = 0;
	
	
	
	public String getKeyword2() {
		return keyword2;
	}
	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}
	public int getRNUM() {
		return RNUM;
	}
	public void setRNUM(int rNUM) {
		RNUM = rNUM;
	}
	public String getOrderCondition() {
		return orderCondition;
	}
	public void setOrderCondition(String orderCondition) {
		this.orderCondition = orderCondition;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String[] getSearchConditionArr() {
		return searchConditionArr;
	}
	public void setSearchConditionArr(String[] searchConditionArr) {
		this.searchConditionArr = searchConditionArr;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String[] getSearchKeywordArr() {
		return searchKeywordArr;
	}
	public void setSearchKeywordArr(String[] searchKeywordArr) {
		this.searchKeywordArr = searchKeywordArr;
	}
	public String getSearchBeginDate() {
		return searchBeginDate;
	}
	public void setSearchBeginDate(String searchBeginDate) {
		this.searchBeginDate = searchBeginDate;
	}
	public String getSearchEndDate() {
		return searchEndDate;
	}
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getSortDirect() {
		return sortDirect;
	}
	public void setSortDirect(String sortDirect) {
		this.sortDirect = sortDirect;
	}

}

