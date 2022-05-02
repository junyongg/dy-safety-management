package com.tx.admin.member.dto;

/**
 * 회원관리 설정 DTO
 * @author 이재령
 *
 */
public class UserSettingDTO  {
	
	private String US_TYPE
				   , US_UIA_KEYNO
				   , US_AUTH
				   , US_ID_FILTER
				   , US_INFO1
				   , US_INFO2 = "";

	public String getUS_TYPE() {
		return US_TYPE;
	}

	public void setUS_TYPE(String uS_TYPE) {
		US_TYPE = uS_TYPE;
	}

	public String getUS_UIA_KEYNO() {
		return US_UIA_KEYNO;
	}

	public void setUS_UIA_KEYNO(String uS_UIA_KEYNO) {
		US_UIA_KEYNO = uS_UIA_KEYNO;
	}

	public String getUS_AUTH() {
		return US_AUTH;
	}

	public void setUS_AUTH(String uS_AUTH) {
		US_AUTH = uS_AUTH;
	}

	public String getUS_ID_FILTER() {
		return US_ID_FILTER;
	}

	public void setUS_ID_FILTER(String uS_ID_FILTER) {
		US_ID_FILTER = uS_ID_FILTER;
	}

	public String getUS_INFO1() {
		return US_INFO1;
	}

	public void setUS_INFO1(String uS_INFO1) {
		US_INFO1 = uS_INFO1;
	}

	public String getUS_INFO2() {
		return US_INFO2;
	}

	public void setUS_INFO2(String uS_INFO2) {
		US_INFO2 = uS_INFO2;
	}
	
	
	

}
