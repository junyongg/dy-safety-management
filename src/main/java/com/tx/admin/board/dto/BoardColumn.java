package com.tx.admin.board.dto;

/**
 * @BoardColumn
 * 게시판타입의 컬럼정보관리를 담당한다.
 * 
 * @author 박혜성
 * @version 1.0
 * @since 2020-02-06
 */ 

public class BoardColumn {
    
	//고유키 
	private String BL_KEYNO;
	
	//게시판 타입관리 키
	private String BL_BT_KEYNO;
	
	//컬럼명
	private String BL_COLUMN_NAME;
	
	//컬럼 가로크기
	private String BL_COLUMN_SIZE;
	
	//정렬순서
	private String BL_COLUMN_LEVEL;
	
	//컬럼정보 리스트에 노출여부
	private String BL_LISTVIEW_YN;

	//컬럼타입
	private String BL_TYPE;
	
	//컬럼 옵션데이터(SELECT, RADIO)옵션
	private String BL_OPTION_DATA;
	
	//사용여부
	private String BL_USE_YN;

	//등록일
	private String BL_REGDT;
	
	//폼 필수입력값
	private String BL_VALIDATE;
	
	//고유키 
	private String KEYNO;
	
	public String getKEYNO() {
		return KEYNO;
	}

	public void setKEYNO(String kEYNO) {
		KEYNO = kEYNO;
	}

	public String getBL_KEYNO() {
		return BL_KEYNO;
	}

	public void setBL_KEYNO(String bL_KEYNO) {
		BL_KEYNO = bL_KEYNO;
	}

	public String getBL_BT_KEYNO() {
		return BL_BT_KEYNO;
	}

	public void setBL_BT_KEYNO(String bL_BT_KEYNO) {
		BL_BT_KEYNO = bL_BT_KEYNO;
	}

	public String getBL_COLUMN_NAME() {
		return BL_COLUMN_NAME;
	}

	public void setBL_COLUMN_NAME(String bL_COLUMN_NAME) {
		BL_COLUMN_NAME = bL_COLUMN_NAME;
	}

	public String getBL_COLUMN_SIZE() {
		return BL_COLUMN_SIZE;
	}

	public void setBL_COLUMN_SIZE(String bL_COLUMN_SIZE) {
		BL_COLUMN_SIZE = bL_COLUMN_SIZE;
	}

	public String getBL_COLUMN_LEVEL() {
		return BL_COLUMN_LEVEL;
	}

	public void setBL_COLUMN_LEVEL(String bL_COLUMN_LEVEL) {
		BL_COLUMN_LEVEL = bL_COLUMN_LEVEL;
	}

	public String getBL_LISTVIEW_YN() {
		return BL_LISTVIEW_YN;
	}

	public void setBL_LISTVIEW_YN(String bL_LISTVIEW_YN) {
		BL_LISTVIEW_YN = bL_LISTVIEW_YN;
	}

	public String getBL_TYPE() {
		return BL_TYPE;
	}

	public void setBL_TYPE(String bL_TYPE) {
		BL_TYPE = bL_TYPE;
	}

	public String getBL_OPTION_DATA() {
		return BL_OPTION_DATA;
	}

	public void setBL_OPTION_DATA(String bL_OPTION_DATA) {
		BL_OPTION_DATA = bL_OPTION_DATA;
	}

	public String getBL_USE_YN() {
		return BL_USE_YN;
	}

	public void setBL_USE_YN(String bL_USE_YN) {
		BL_USE_YN = bL_USE_YN;
	}

	public String getBL_REGDT() {
		return BL_REGDT;
	}

	public void setBL_REGDT(String bL_REGDT) {
		BL_REGDT = bL_REGDT;
	}

	public String getBL_VALIDATE() {
		return BL_VALIDATE;
	}

	public void setBL_VALIDATE(String bL_VALIDATE) {
		BL_VALIDATE = bL_VALIDATE;
	}

	
	
}
