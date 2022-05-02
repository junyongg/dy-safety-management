package com.tx.admin.homepage.menu.dto;

import java.io.Serializable;

public class HTMLViewData implements Serializable{

	private static final long serialVersionUID = -293584105642402352L;
	
	private String MVD_KEYNO = "";	//키
	private String MVD_MN_KEYNO = "";	//Menu - 조인 키
	private String MVD_MN_HOMEDIV_C = "";	//Menu - 홈페이지구분 코드
	private String MVD_URL   = "";	//해당 URL
	private String MVD_DATA  = "";	//JSP소스
	private String MVD_REGDT = "";	//작성일
	private String MVD_MODDT = "";	//수정일
	private String MVD_REGNM = "";	//작성자
	private String MVD_MODNM = "";	//수정자
	private String MVD_DEL_YN = "";	//삭제여부
	private String MVD_EDITOR_TYPE = "";	//에디터 타입
	
	private String MVD_TILES = "";	//관련 타일즈
	
	
	/* 히스토리 테이블 */
	private String MVH_KEYNO = "";		//고유키
	private String MVH_MVD_KEYNO = "";	//메인키
	private String MVH_DATA = "";		// 데이터
	private String MVH_STDT = "";		// 게시기간 - 시작일
	private String MVH_ENDT = "";		// 게시기간 - 종료일
	private String MVH_MODNM = "";		//수정자
	private String MVH_DEL_YN = "";		//삭제여부
    private String MN_NAME = "";    	//컨텐트 제목
    private String MVH_COMMENT = "";    //코멘트
    private double MVH_VERSION;    		//버전

	
    
	public String getMVD_EDITOR_TYPE() {
		return MVD_EDITOR_TYPE;
	}
	public void setMVD_EDITOR_TYPE(String mVD_EDITOR_TYPE) {
		MVD_EDITOR_TYPE = mVD_EDITOR_TYPE;
	}
	public String getMVH_COMMENT() {
		return MVH_COMMENT;
	}
	public void setMVH_COMMENT(String mVH_COMMENT) {
		MVH_COMMENT = mVH_COMMENT;
	}
	public double getMVH_VERSION() {
		return MVH_VERSION;
	}
	public void setMVH_VERSION(double mVH_VERSION) {
		MVH_VERSION = mVH_VERSION;
	}
	public String getMN_NAME() {
		return MN_NAME;
	}
	public void setMN_NAME(String mN_NAME) {
		MN_NAME = mN_NAME;
	}
	public String getMVH_DEL_YN() {
		return MVH_DEL_YN;
	}
	public void setMVH_DEL_YN(String mVH_DEL_YN) {
		MVH_DEL_YN = mVH_DEL_YN;
	}
	public String getMVH_KEYNO() {
		return MVH_KEYNO;
	}
	public void setMVH_KEYNO(String mVH_KEYNO) {
		MVH_KEYNO = mVH_KEYNO;
	}
	public String getMVH_MVD_KEYNO() {
		return MVH_MVD_KEYNO;
	}
	public void setMVH_MVD_KEYNO(String mVH_MVD_KEYNO) {
		MVH_MVD_KEYNO = mVH_MVD_KEYNO;
	}
	public String getMVH_DATA() {
		return MVH_DATA;
	}
	public void setMVH_DATA(String mVH_DATA) {
		MVH_DATA = mVH_DATA;
	}
	
	public String getMVH_STDT() {
		return MVH_STDT;
	}
	public void setMVH_STDT(String mVH_STDT) {
		MVH_STDT = mVH_STDT;
	}
	public String getMVH_ENDT() {
		return MVH_ENDT;
	}
	public void setMVH_ENDT(String mVH_ENDT) {
		MVH_ENDT = mVH_ENDT;
	}
	public String getMVH_MODNM() {
		return MVH_MODNM;
	}
	public void setMVH_MODNM(String mVH_MODNM) {
		MVH_MODNM = mVH_MODNM;
	}
	public String getMVD_TILES() {
		return MVD_TILES;
	}
	public void setMVD_TILES(String mVD_TILES) {
		MVD_TILES = mVD_TILES;
	}
	public String getMVD_DEL_YN() {
		return MVD_DEL_YN;
	}
	public void setMVD_DEL_YN(String mVD_DEL_YN) {
		MVD_DEL_YN = mVD_DEL_YN;
	}
	public String getMVD_KEYNO() {
		return MVD_KEYNO;
	}
	public void setMVD_KEYNO(String mVD_KEYNO) {
		MVD_KEYNO = mVD_KEYNO;
	}
	public String getMVD_MN_KEYNO() {
		return MVD_MN_KEYNO;
	}
	public void setMVD_MN_KEYNO(String mVD_MN_KEYNO) {
		MVD_MN_KEYNO = mVD_MN_KEYNO;
	}
	public String getMVD_MN_HOMEDIV_C() {
		return MVD_MN_HOMEDIV_C;
	}
	public void setMVD_MN_HOMEDIV_C(String mVD_MN_HOMEDIV_C) {
		MVD_MN_HOMEDIV_C = mVD_MN_HOMEDIV_C;
	}
	public String getMVD_URL() {
		return MVD_URL;
	}
	public void setMVD_URL(String mVD_URL) {
		MVD_URL = mVD_URL;
	}
	public String getMVD_DATA() {
		return MVD_DATA;
	}
	public void setMVD_DATA(String mVD_DATA) {
		MVD_DATA = mVD_DATA;
	}
	public String getMVD_REGDT() {
		return MVD_REGDT;
	}
	public void setMVD_REGDT(String mVD_REGDT) {
		MVD_REGDT = mVD_REGDT;
	}
	public String getMVD_MODDT() {
		return MVD_MODDT;
	}
	public void setMVD_MODDT(String mVD_MODDT) {
		MVD_MODDT = mVD_MODDT;
	}
	public String getMVD_REGNM() {
		return MVD_REGNM;
	}
	public void setMVD_REGNM(String mVD_REGNM) {
		MVD_REGNM = mVD_REGNM;
	}
	public String getMVD_MODNM() {
		return MVD_MODNM;
	}
	public void setMVD_MODNM(String mVD_MODNM) {
		MVD_MODNM = mVD_MODNM;
	}
	
	
}
