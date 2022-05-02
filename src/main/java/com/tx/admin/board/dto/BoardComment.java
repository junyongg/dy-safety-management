package com.tx.admin.board.dto;

import com.tx.common.dto.Common;

/**
 * @BoardComment
 * 게시판 댓글관리를 담당한다.
 * 
 * @author 박혜성
 * @version 1.0
 * @since 2017-02-06
 */ 

public class BoardComment extends Common {
    
	private static final long serialVersionUID = -6636554681942407357L;

	//기본키 
	private String BC_KEYNO = "";
	
	//메인키
	private String BC_MAINKEY = "";
	
	//루트키
	private String BC_ROOTKEY = "";
	
	//게시물키 
	private String BC_BN_KEYNO = "";
	
	//내용 
	private String BC_CONTENTS = "";
	
	//작성자 코드 
	private String BC_REGNM = "";
	
	//작성일 
	private String BC_REGDT = "";
	
	//사용여부 
	private String BC_DEL_YN = "";
	
	//삭제일
	private String BC_DELDT = "";
	
	//수정일
	private String BC_MODDT = "";
	
	//좋아요
	private int BC_UP_CNT;
	
	//싫어요
	private int BC_DOWN_CNT;
	
	//작성자 
	private String UI_NAME = "";
	
	//메인 작성자 
	private String UI_MAIN_NAME = "";
	
	
	
	
	
	public String getBC_ROOTKEY() {
		return BC_ROOTKEY;
	}

	public void setBC_ROOTKEY(String bC_ROOTKEY) {
		BC_ROOTKEY = bC_ROOTKEY;
	}

	public String getUI_MAIN_NAME() {
		return UI_MAIN_NAME;
	}

	public void setUI_MAIN_NAME(String uI_MAIN_NAME) {
		UI_MAIN_NAME = uI_MAIN_NAME;
	}

	public String getUI_NAME() {
		return UI_NAME;
	}

	public void setUI_NAME(String uI_NAME) {
		UI_NAME = uI_NAME;
	}

	public String getBC_MAINKEY() {
		return BC_MAINKEY;
	}

	public void setBC_MAINKEY(String bC_MAINKEY) {
		BC_MAINKEY = bC_MAINKEY;
	}

	public String getBC_KEYNO() {
		return BC_KEYNO;
	}

	public void setBC_KEYNO(String bC_KEYNO) {
		BC_KEYNO = bC_KEYNO;
	}

	public String getBC_BN_KEYNO() {
		return BC_BN_KEYNO;
	}

	public void setBC_BN_KEYNO(String bC_BN_KEYNO) {
		BC_BN_KEYNO = bC_BN_KEYNO;
	}

	public String getBC_CONTENTS() {
		return BC_CONTENTS;
	}

	public void setBC_CONTENTS(String bC_CONTENTS) {
		BC_CONTENTS = bC_CONTENTS;
	}

	public String getBC_REGNM() {
		return BC_REGNM;
	}

	public void setBC_REGNM(String bC_REGNM) {
		BC_REGNM = bC_REGNM;
	}

	public String getBC_REGDT() {
		return BC_REGDT;
	}

	public void setBC_REGDT(String bC_REGDT) {
		BC_REGDT = bC_REGDT;
	}

	public String getBC_DEL_YN() {
		return BC_DEL_YN;
	}

	public void setBC_DEL_YN(String bC_DEL_YN) {
		BC_DEL_YN = bC_DEL_YN;
	}

	public String getBC_DELDT() {
		return BC_DELDT;
	}

	public void setBC_DELDT(String bC_DELDT) {
		BC_DELDT = bC_DELDT;
	}

	public String getBC_MODDT() {
		return BC_MODDT;
	}

	public void setBC_MODDT(String bC_MODDT) {
		BC_MODDT = bC_MODDT;
	}

	public int getBC_UP_CNT() {
		return BC_UP_CNT;
	}

	public void setBC_UP_CNT(int bC_UP_CNT) {
		BC_UP_CNT = bC_UP_CNT;
	}

	public int getBC_DOWN_CNT() {
		return BC_DOWN_CNT;
	}

	public void setBC_DOWN_CNT(int bC_DOWN_CNT) {
		BC_DOWN_CNT = bC_DOWN_CNT;
	}

	
}
