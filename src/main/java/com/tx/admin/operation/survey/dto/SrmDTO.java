package com.tx.admin.operation.survey.dto;

import com.tx.common.dto.Common;

public class SrmDTO extends Common {
	
	private static final long serialVersionUID = -8716753312865665515L;

	//설문결과 기본키
	private String SRM_KEYNO;
	
	//설문지키
	private String SRM_SM_KEYNO;
	
	//설문작성자
	private String SRM_REGNM;
	
	//설문작성일
	private String SRM_REGDT;

	//아이피
	private String SRM_IP;
	
	//설문결과 데이터 기본키
	private String SRD_KEYNO;
	
	//설문지 키
	private String SRD_SM_KEYNO;
	
	//설문결과 관리키
	private String SRD_SRM_KEYNO;
	
	//설문 문항
	private String SRD_SQ_KEYNO;
	
	//주관식 결과
	private String SRD_DATA;
	
	//객관식 결과
	private String SRD_SQO_KEYNO;
	
	//객관식 결과 배점
	private String SRD_SQO_VALUE;
	
	//보기 선택 결과
	private String CNT_CHOICE;

	//보기 종합 점수
	private String SUM_VAL;
	
	
	
	
	public String getSRM_IP() {
		return SRM_IP;
	}

	public void setSRM_IP(String sRM_IP) {
		SRM_IP = sRM_IP;
	}

	public String getSRM_KEYNO() {
		return SRM_KEYNO;
	}

	public void setSRM_KEYNO(String sRM_KEYNO) {
		SRM_KEYNO = sRM_KEYNO;
	}

	public String getSRM_SM_KEYNO() {
		return SRM_SM_KEYNO;
	}

	public void setSRM_SM_KEYNO(String sRM_SM_KEYNO) {
		SRM_SM_KEYNO = sRM_SM_KEYNO;
	}

	public String getSRM_REGNM() {
		return SRM_REGNM;
	}

	public void setSRM_REGNM(String sRM_REGNM) {
		SRM_REGNM = sRM_REGNM;
	}

	public String getSRM_REGDT() {
		return SRM_REGDT;
	}

	public void setSRM_REGDT(String sRM_REGDT) {
		SRM_REGDT = sRM_REGDT;
	}

	public String getSRD_KEYNO() {
		return SRD_KEYNO;
	}

	public void setSRD_KEYNO(String sRD_KEYNO) {
		SRD_KEYNO = sRD_KEYNO;
	}

	public String getSRD_SRM_KEYNO() {
		return SRD_SRM_KEYNO;
	}

	public void setSRD_SRM_KEYNO(String sRD_SRM_KEYNO) {
		SRD_SRM_KEYNO = sRD_SRM_KEYNO;
	}

	public String getSRD_SQ_KEYNO() {
		return SRD_SQ_KEYNO;
	}

	public void setSRD_SQ_KEYNO(String sRD_SQ_KEYNO) {
		SRD_SQ_KEYNO = sRD_SQ_KEYNO;
	}

	public String getSRD_DATA() {
		return SRD_DATA;
	}

	public void setSRD_DATA(String sRD_DATA) {
		SRD_DATA = sRD_DATA;
	}

	public String getSRD_SQO_KEYNO() {
		return SRD_SQO_KEYNO;
	}

	public void setSRD_SQO_KEYNO(String sRD_SQO_KEYNO) {
		SRD_SQO_KEYNO = sRD_SQO_KEYNO;
	}

	public String getSRD_SM_KEYNO() {
		return SRD_SM_KEYNO;
	}

	public void setSRD_SM_KEYNO(String sRD_SM_KEYNO) {
		SRD_SM_KEYNO = sRD_SM_KEYNO;
	}

	public String getSRD_SQO_VALUE() {
		return SRD_SQO_VALUE;
	}

	public void setSRD_SQO_VALUE(String sRD_SQO_VALUE) {
		SRD_SQO_VALUE = sRD_SQO_VALUE;
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
