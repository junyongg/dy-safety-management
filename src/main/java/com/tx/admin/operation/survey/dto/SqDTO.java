package com.tx.admin.operation.survey.dto;

import com.tx.common.dto.Common;

public class SqDTO extends Common {
	
	private static final long serialVersionUID = 3633419050609616095L;

	// 설문 문항 기본키
	private String SQ_KEYNO;
	
	// 설문지 키
	private String SQ_SM_KEYNO;
	
	// 정렬순서
	private String SQ_ALIGN;
	
	// 설문번호
	private String SQ_NUM;
	
	// 설문타입
	private String SQ_ST_TYPE;
	
	// 설문 질문
	private String SQ_QUESTION;
	
    // 작성자
    private String SQ_REGNM;
	
	// 설문문항 보기 기본키
	private String SQO_KEYNO;
	
	// 설문문항 키
	private String SQO_SQ_KEYNO;
	
	// 보기번호
	private String SQO_NUM;
	
	// 보기내용
	private String SQO_OPTION;
	
	// 보기배점
	private String SQO_VALUE;
	
	
	//보기 선택 결과
	private String CNT_CHOICE;

	//보기 종합 점수
	private String SUM_VAL;
	
	
	
	
	public String getSQ_REGNM() {
		return SQ_REGNM;
	}

	public void setSQ_REGNM(String sQ_REGNM) {
		SQ_REGNM = sQ_REGNM;
	}

	public String getSQ_KEYNO() {
		return SQ_KEYNO;
	}

	public void setSQ_KEYNO(String sQ_KEYNO) {
		SQ_KEYNO = sQ_KEYNO;
	}

	public String getSQ_SM_KEYNO() {
		return SQ_SM_KEYNO;
	}

	public void setSQ_SM_KEYNO(String sQ_SM_KEYNO) {
		SQ_SM_KEYNO = sQ_SM_KEYNO;
	}

	public String getSQ_ALIGN() {
		return SQ_ALIGN;
	}

	public void setSQ_ALIGN(String sQ_ALIGN) {
		SQ_ALIGN = sQ_ALIGN;
	}

	public String getSQ_NUM() {
		return SQ_NUM;
	}

	public void setSQ_NUM(String sQ_NUM) {
		SQ_NUM = sQ_NUM;
	}

	public String getSQ_ST_TYPE() {
		return SQ_ST_TYPE;
	}

	public void setSQ_ST_TYPE(String sQ_ST_TYPE) {
		SQ_ST_TYPE = sQ_ST_TYPE;
	}

	public String getSQ_QUESTION() {
		return SQ_QUESTION;
	}

	public void setSQ_QUESTION(String sQ_QUESTION) {
		SQ_QUESTION = sQ_QUESTION;
	}

	public String getSQO_KEYNO() {
		return SQO_KEYNO;
	}

	public void setSQO_KEYNO(String sQO_KEYNO) {
		SQO_KEYNO = sQO_KEYNO;
	}

	public String getSQO_SQ_KEYNO() {
		return SQO_SQ_KEYNO;
	}

	public void setSQO_SQ_KEYNO(String sQO_SQ_KEYNO) {
		SQO_SQ_KEYNO = sQO_SQ_KEYNO;
	}

	public String getSQO_NUM() {
		return SQO_NUM;
	}

	public void setSQO_NUM(String sQO_NUM) {
		SQO_NUM = sQO_NUM;
	}

	public String getSQO_OPTION() {
		return SQO_OPTION;
	}

	public void setSQO_OPTION(String sQO_OPTION) {
		SQO_OPTION = sQO_OPTION;
	}

	public String getSQO_VALUE() {
		return SQO_VALUE;
	}

	public void setSQO_VALUE(String sQO_VALUE) {
		SQO_VALUE = sQO_VALUE;
	}

	public String getCNT_CHOICE() {
		return CNT_CHOICE;
	}

	public void setCNT_CHOICE(String cNT_CHOICE) {
		CNT_CHOICE = cNT_CHOICE;
	}

	public String getSUM_VAL() {
		return SUM_VAL;
	}

	public void setSUM_VAL(String sUM_VAL) {
		SUM_VAL = sUM_VAL;
	}

	
	
	
	
	
	
	
	
	
	
	
	

}
