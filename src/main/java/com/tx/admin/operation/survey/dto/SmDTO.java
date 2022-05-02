package com.tx.admin.operation.survey.dto;

import com.tx.common.dto.Common;

/**
 * @SurDTO
 * 설문지 등록을 담당.
 * 
 * @author 김영탁
 * @version 1.0
 * @since 2017-03-09
 */ 

public class SmDTO extends Common {
	
	private static final long serialVersionUID = 1251301280729605203L;

	//이벤트 결과값 저장을 위한 처리
	private String USER_ID;
	private String USER_NM;
	private String USER_PH;
	private String USER_EM;
	private String Q1;
	private String Q2;
	private String Q3;
	private String Q4;
	private String URL;
	private String CONTENT;
	private String DATE;
	
	
	
	
	public String getDATE() {
		return DATE;
	}

	public void setDATE(String dATE) {
		DATE = dATE;
	}

	public String getUSER_ID() {
		return USER_ID;
	}

	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}

	public String getUSER_NM() {
		return USER_NM;
	}

	public void setUSER_NM(String uSER_NM) {
		USER_NM = uSER_NM;
	}

	public String getUSER_PH() {
		return USER_PH;
	}

	public void setUSER_PH(String uSER_PH) {
		USER_PH = uSER_PH;
	}

	public String getUSER_EM() {
		return USER_EM;
	}

	public void setUSER_EM(String uSER_EM) {
		USER_EM = uSER_EM;
	}

	public String getQ1() {
		return Q1;
	}

	public void setQ1(String q1) {
		Q1 = q1;
	}

	public String getQ2() {
		return Q2;
	}

	public void setQ2(String q2) {
		Q2 = q2;
	}

	public String getQ3() {
		return Q3;
	}

	public void setQ3(String q3) {
		Q3 = q3;
	}

	public String getQ4() {
		return Q4;
	}

	public void setQ4(String q4) {
		Q4 = q4;
	}

	public String getURL() {
		return URL;
	}

	public void setURL(String uRL) {
		URL = uRL;
	}

	public String getCONTENT() {
		return CONTENT;
	}

	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}

	//끗
	
	
	//  설문지 기본키
    private String SM_KEYNO;

    //  설문지 제목
    private String SM_TITLE;

    //  설문지 기초 설명
    private String SM_EXP;

    //  설문시작일
    private String SM_STARTDT;

    //  설문종료일
    private String SM_ENDDT;

    //  작성자
    private String SM_REGNM;

    //  작성일
    private String SM_REGDT;

    //  익명여부
    private String SM_IDYN;

    //  설문 홈페이지사용여부
    private String SM_HOMEYN;

    //  설문삭제여부 
    private String SM_DELYN;
    
    // 설문참여인원
    private String SM_PANEL_CNT;
    
    // 설문점수타입 (점수 / 사람수)
    // 점수 : S / 사람수 : H
    private String SM_CNT_TYPE;
    
    private String SM_MN_KEYNO;

    
	public String getSM_MN_KEYNO() {
		return SM_MN_KEYNO;
	}

	public void setSM_MN_KEYNO(String sM_MN_KEYNO) {
		SM_MN_KEYNO = sM_MN_KEYNO;
	}

	public String getSM_KEYNO() {
		return SM_KEYNO;
	}

	public void setSM_KEYNO(String sM_KEYNO) {
		SM_KEYNO = sM_KEYNO;
	}

	public String getSM_TITLE() {
		return SM_TITLE;
	}

	public void setSM_TITLE(String sM_TITLE) {
		SM_TITLE = sM_TITLE;
	}

	public String getSM_EXP() {
		return SM_EXP;
	}

	public void setSM_EXP(String sM_EXP) {
		SM_EXP = sM_EXP;
	}

	public String getSM_REGNM() {
		return SM_REGNM;
	}

	public void setSM_REGNM(String sM_REGNM) {
		SM_REGNM = sM_REGNM;
	}

	public String getSM_IDYN() {
		return SM_IDYN;
	}

	public void setSM_IDYN(String sM_IDYN) {
		SM_IDYN = sM_IDYN;
	}

	public String getSM_HOMEYN() {
		return SM_HOMEYN;
	}

	public void setSM_HOMEYN(String sM_HOMEYN) {
		SM_HOMEYN = sM_HOMEYN;
	}

	public String getSM_DELYN() {
		return SM_DELYN;
	}

	public void setSM_DELYN(String sM_DELYN) {
		SM_DELYN = sM_DELYN;
	}

	public String getSM_PANEL_CNT() {
		return SM_PANEL_CNT;
	}

	public void setSM_PANEL_CNT(String sM_PANEL_CNT) {
		SM_PANEL_CNT = sM_PANEL_CNT;
	}

	public String getSM_CNT_TYPE() {
		return SM_CNT_TYPE;
	}

	public void setSM_CNT_TYPE(String sM_CNT_TYPE) {
		SM_CNT_TYPE = sM_CNT_TYPE;
	}

	public String getSM_STARTDT() {
		return SM_STARTDT;
	}

	public void setSM_STARTDT(String sM_STARTDT) {
		SM_STARTDT = sM_STARTDT;
	}

	public String getSM_ENDDT() {
		return SM_ENDDT;
	}

	public void setSM_ENDDT(String sM_ENDDT) {
		SM_ENDDT = sM_ENDDT;
	}

	public String getSM_REGDT() {
		return SM_REGDT;
	}

	public void setSM_REGDT(String sM_REGDT) {
		SM_REGDT = sM_REGDT;
	}
	
	

}
