package com.tx.admin.board.dto;

/**
 * @BoardMainMini
 * 메인미니게시판의 컬럼정보관리를 담당한다.
 * 
 * @author 주지은
 * @version 1.0
 * @since 2019-05-16
 */ 

public class BoardMainMini {
    
	private String    BMM_KEYNO
					, KEYNO
					, BMM_MN_KEYNO
					, BMM_SIZE
					, BMM_FORM
					, BMM_REGDT
					, BMM_REGNM
					, BMM_DELYN
					, BMM_MN_HOMEDIV_C
					, BMM_FILE_NAME
					, BMM_FILE_PATH = "";
	
	private String	  BMM_MNNAME
					, BMM_MN_HOMEDIVNM
					, BMM_MN_HOMEDIV_URL
					, BMM_MN_HOMEDIV_TILES = "";
	
	
	

	public String getKEYNO() {
		return KEYNO;
	}

	public void setKEYNO(String kEYNO) {
		KEYNO = kEYNO;
	}

	public String getBMM_KEYNO() {
		return BMM_KEYNO;
	}

	public void setBMM_KEYNO(String bMM_KEYNO) {
		BMM_KEYNO = bMM_KEYNO;
	}

	public String getBMM_MN_KEYNO() {
		return BMM_MN_KEYNO;
	}

	public void setBMM_MN_KEYNO(String bMM_MN_KEYNO) {
		BMM_MN_KEYNO = bMM_MN_KEYNO;
	}

	public String getBMM_SIZE() {
		return BMM_SIZE;
	}

	public void setBMM_SIZE(String bMM_SIZE) {
		BMM_SIZE = bMM_SIZE;
	}

	public String getBMM_FORM() {
		return BMM_FORM;
	}

	public void setBMM_FORM(String bMM_FORM) {
		BMM_FORM = bMM_FORM;
	}

	public String getBMM_REGDT() {
		return BMM_REGDT;
	}

	public void setBMM_REGDT(String bMM_REGDT) {
		BMM_REGDT = bMM_REGDT;
	}

	public String getBMM_REGNM() {
		return BMM_REGNM;
	}

	public void setBMM_REGNM(String bMM_REGNM) {
		BMM_REGNM = bMM_REGNM;
	}

	public String getBMM_DELYN() {
		return BMM_DELYN;
	}

	public void setBMM_DELYN(String bMM_DELYN) {
		BMM_DELYN = bMM_DELYN;
	}

	public String getBMM_MN_HOMEDIV_C() {
		return BMM_MN_HOMEDIV_C;
	}

	public void setBMM_MN_HOMEDIV_C(String bMM_MN_HOMEDIV_C) {
		BMM_MN_HOMEDIV_C = bMM_MN_HOMEDIV_C;
	}

	public String getBMM_FILE_NAME() {
		return BMM_FILE_NAME;
	}

	public void setBMM_FILE_NAME(String bMM_FILE_NAME) {
		BMM_FILE_NAME = bMM_FILE_NAME;
	}

	public String getBMM_MNNAME() {
		return BMM_MNNAME;
	}

	public void setBMM_MNNAME(String bMM_MNNAME) {
		BMM_MNNAME = bMM_MNNAME;
	}

	public String getBMM_MN_HOMEDIVNM() {
		return BMM_MN_HOMEDIVNM;
	}

	public void setBMM_MN_HOMEDIVNM(String bMM_MN_HOMEDIVNM) {
		BMM_MN_HOMEDIVNM = bMM_MN_HOMEDIVNM;
	}

	public String getBMM_FILE_PATH() {
		return BMM_FILE_PATH;
	}

	public void setBMM_FILE_PATH(String bMM_FILE_PATH) {
		BMM_FILE_PATH = bMM_FILE_PATH;
	}

	public String getBMM_MN_HOMEDIV_URL() {
		return BMM_MN_HOMEDIV_URL;
	}

	public void setBMM_MN_HOMEDIV_URL(String bMM_MN_HOMEDIV_URL) {
		BMM_MN_HOMEDIV_URL = bMM_MN_HOMEDIV_URL;
	}

	public String getBMM_MN_HOMEDIV_TILES() {
		return BMM_MN_HOMEDIV_TILES;
	}

	public void setBMM_MN_HOMEDIV_TILES(String bMM_MN_HOMEDIV_TILES) {
		BMM_MN_HOMEDIV_TILES = bMM_MN_HOMEDIV_TILES;
	}
}
