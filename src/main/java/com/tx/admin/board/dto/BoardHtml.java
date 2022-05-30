package com.tx.admin.board.dto;

/**
 * @BoardHtml
 * 게시판HTML필요페이지
 * 테이블은 없음
 * 
 * @author 박혜성
 * @version 1.0
 * @since 2020-02-06
 */ 

public class BoardHtml {
    
	//기본키 
	private String BIH_KEYNO;
	
	//메뉴키 
	private String BIH_MN_KEYNO;
	
	//게시판타입키 
	private String BIH_BT_KEYNO;
	
	//HTML내용 
	private String BIH_CONTENTS;
	
	//작성자 
	private String BIH_REGNM;
	
	//작성일 
	private String BIH_REGDT;
	
	//수정일 
	private String BIH_MODDT;
	
	//사용여부 
	private String BIH_USE_YN;
	
	//DIV위치 
	private String BIH_DIV_LOCATION;

	public String getBIH_KEYNO() {
		return BIH_KEYNO;
	}

	public void setBIH_KEYNO(String bIH_KEYNO) {
		BIH_KEYNO = bIH_KEYNO;
	}

	public String getBIH_MN_KEYNO() {
		return BIH_MN_KEYNO;
	}

	public void setBIH_MN_KEYNO(String bIH_MN_KEYNO) {
		BIH_MN_KEYNO = bIH_MN_KEYNO;
	}

	public String getBIH_BT_KEYNO() {
		return BIH_BT_KEYNO;
	}

	public void setBIH_BT_KEYNO(String bIH_BT_KEYNO) {
		BIH_BT_KEYNO = bIH_BT_KEYNO;
	}

	public String getBIH_CONTENTS() {
		return BIH_CONTENTS;
	}

	public void setBIH_CONTENTS(String bIH_CONTENTS) {
		BIH_CONTENTS = bIH_CONTENTS;
	}

	public String getBIH_REGNM() {
		return BIH_REGNM;
	}

	public void setBIH_REGNM(String bIH_REGNM) {
		BIH_REGNM = bIH_REGNM;
	}

	public String getBIH_REGDT() {
		return BIH_REGDT;
	}

	public void setBIH_REGDT(String bIH_REGDT) {
		BIH_REGDT = bIH_REGDT;
	}

	public String getBIH_MODDT() {
		return BIH_MODDT;
	}

	public void setBIH_MODDT(String bIH_MODDT) {
		BIH_MODDT = bIH_MODDT;
	}

	public String getBIH_USE_YN() {
		return BIH_USE_YN;
	}

	public void setBIH_USE_YN(String bIH_USE_YN) {
		BIH_USE_YN = bIH_USE_YN;
	}

	public String getBIH_DIV_LOCATION() {
		return BIH_DIV_LOCATION;
	}

	public void setBIH_DIV_LOCATION(String bIH_DIV_LOCATION) {
		BIH_DIV_LOCATION = bIH_DIV_LOCATION;
	}
	
}
