package com.tx.admin.board.dto;

/**
 * @BoardColumnData
 * 게시판 컬럼데이터 관리를 담당한다.
 * 
 * @author 박혜성
 * @version 1.0
 * @since 2020-02-06
 */ 

public class BoardColumnData extends BoardColumn {
    
	//고유키 
	private String BD_KEYNO;
	
	//게시판타입키 
	private String BD_BT_KEYNO;
	
	//게시물키 
	private String BD_BN_KEYNO;
	
	//게시판컬럼키 
	private String BD_BL_KEYNO;
	
	//컬럼타입 
	private String BD_BL_TYPE;
	
	//해당컬럼데이터 
	private String BD_DATA;
	
	//데이터가 어디메뉴의 데이터인지 바로알기위해 추가 
	private String BD_MN_KEYNO;
	
	//상세페이지 데이터 셀렉트하려고 선언
	private String COLUMN_NAME;
	
	private String BDH_KEYNO;
	private String BDH_BD_KEYNO;
	private String BDH_BD_BT_KEYNO;
	private String BDH_BD_BN_KEYNO;
	private String BDH_BD_BL_KEYNO;
	private String BDH_BD_MN_KEYNO;
	private String BDH_BD_BL_TYPE;
	private String BDH_BD_DATA;
	
	private String BDH_BNH_KEYNO;
	
	private String BD_COMPARE;

	public String getCOLUMN_NAME() {
		return COLUMN_NAME;
	}

	public void setCOLUMN_NAME(String cOLUMN_NAME) {
		COLUMN_NAME = cOLUMN_NAME;
	}

	public String getBD_KEYNO() {
		return BD_KEYNO;
	}

	public void setBD_KEYNO(String bD_KEYNO) {
		BD_KEYNO = bD_KEYNO;
	}

	public String getBD_BT_KEYNO() {
		return BD_BT_KEYNO;
	}

	public void setBD_BT_KEYNO(String bD_BT_KEYNO) {
		BD_BT_KEYNO = bD_BT_KEYNO;
	}

	public String getBD_BN_KEYNO() {
		return BD_BN_KEYNO;
	}

	public void setBD_BN_KEYNO(String bD_BN_KEYNO) {
		BD_BN_KEYNO = bD_BN_KEYNO;
	}

	public String getBD_BL_KEYNO() {
		return BD_BL_KEYNO;
	}

	public void setBD_BL_KEYNO(String bD_BL_KEYNO) {
		BD_BL_KEYNO = bD_BL_KEYNO;
	}

	public String getBD_BL_TYPE() {
		return BD_BL_TYPE;
	}

	public void setBD_BL_TYPE(String bD_BL_TYPE) {
		BD_BL_TYPE = bD_BL_TYPE;
	}

	public String getBD_DATA() {
		return BD_DATA;
	}

	public void setBD_DATA(String bD_DATA) {
		BD_DATA = bD_DATA;
	}

	public String getBD_MN_KEYNO() {
		return BD_MN_KEYNO;
	}

	public void setBD_MN_KEYNO(String bD_MN_KEYNO) {
		BD_MN_KEYNO = bD_MN_KEYNO;
	}

	public String getBDH_BNH_KEYNO() {
		return BDH_BNH_KEYNO;
	}

	public void setBDH_BNH_KEYNO(String bDH_BNH_KEYNO) {
		BDH_BNH_KEYNO = bDH_BNH_KEYNO;
	}

	public String getBDH_KEYNO() {
		return BDH_KEYNO;
	}

	public void setBDH_KEYNO(String bDH_KEYNO) {
		BDH_KEYNO = bDH_KEYNO;
	}

	public String getBDH_BD_KEYNO() {
		return BDH_BD_KEYNO;
	}

	public void setBDH_BD_KEYNO(String bDH_BD_KEYNO) {
		BDH_BD_KEYNO = bDH_BD_KEYNO;
	}

	public String getBDH_BD_BT_KEYNO() {
		return BDH_BD_BT_KEYNO;
	}

	public void setBDH_BD_BT_KEYNO(String bDH_BD_BT_KEYNO) {
		BDH_BD_BT_KEYNO = bDH_BD_BT_KEYNO;
	}

	public String getBDH_BD_BN_KEYNO() {
		return BDH_BD_BN_KEYNO;
	}

	public void setBDH_BD_BN_KEYNO(String bDH_BD_BN_KEYNO) {
		BDH_BD_BN_KEYNO = bDH_BD_BN_KEYNO;
	}

	public String getBDH_BD_BL_KEYNO() {
		return BDH_BD_BL_KEYNO;
	}

	public void setBDH_BD_BL_KEYNO(String bDH_BD_BL_KEYNO) {
		BDH_BD_BL_KEYNO = bDH_BD_BL_KEYNO;
	}

	public String getBDH_BD_MN_KEYNO() {
		return BDH_BD_MN_KEYNO;
	}

	public void setBDH_BD_MN_KEYNO(String bDH_BD_MN_KEYNO) {
		BDH_BD_MN_KEYNO = bDH_BD_MN_KEYNO;
	}

	public String getBDH_BD_BL_TYPE() {
		return BDH_BD_BL_TYPE;
	}

	public void setBDH_BD_BL_TYPE(String bDH_BD_BL_TYPE) {
		BDH_BD_BL_TYPE = bDH_BD_BL_TYPE;
	}

	public String getBDH_BD_DATA() {
		return BDH_BD_DATA;
	}

	public void setBDH_BD_DATA(String bDH_BD_DATA) {
		BDH_BD_DATA = bDH_BD_DATA;
	}

	public String getBD_COMPARE() {
		return BD_COMPARE;
	}

	public void setBD_COMPARE(String bD_COMPARE) {
		BD_COMPARE = bD_COMPARE;
	}
	
	
	
}
