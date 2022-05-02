package com.tx.admin.function.code.dto;

import java.io.Serializable;

/**
 * @MainCode
 * 공통기능의 메인코드 기능을 담당하는 빈즈
 * @author 신희원
 * @version 1.0
 * @since 2014-11-12
 */
public class MainCode extends SubCode implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6333542920612844790L;

	//상위 코드 고유 키
	private String MC_KEYNO = null;
	
	//상위 코드 코드 명칭
	private String MC_CODENM = null;

	//상위 코드 생성일자
	private String MC_REGDT = null;
	
	//상위 코드 최근 수정 일자
	private String MC_MODDT = null;
	
	//내부 코드 값
	private String MC_IN_C = null;

	//상위 코드 시스템전용 코드 사용 여부 (Y일 경우 수정/변경/삭제가 불가)
	private String MC_SYS_YN = null;
	
	//상위 코드 사용 여부
	private String MC_USE_YN = null;

	public String getMC_KEYNO() {
		return MC_KEYNO;
	}

	public void setMC_KEYNO(String mC_KEYNO) {
		MC_KEYNO = mC_KEYNO;
	}

	public String getMC_CODENM() {
		return MC_CODENM;
	}

	public void setMC_CODENM(String mC_CODENM) {
		MC_CODENM = mC_CODENM;
	}

	public String getMC_REGDT() {
		return MC_REGDT;
	}

	public void setMC_REGDT(String mC_REGDT) {
		MC_REGDT = mC_REGDT;
	}

	public String getMC_MODDT() {
		return MC_MODDT;
	}

	public void setMC_MODDT(String mC_MODDT) {
		MC_MODDT = mC_MODDT;
	}

	public String getMC_IN_C() {
		return MC_IN_C;
	}

	public void setMC_IN_C(String mC_IN_C) {
		MC_IN_C = mC_IN_C;
	}

	public String getMC_SYS_YN() {
		return MC_SYS_YN;
	}

	public void setMC_SYS_YN(String mC_SYS_YN) {
		MC_SYS_YN = mC_SYS_YN;
	}

	public String getMC_USE_YN() {
		return MC_USE_YN;
	}

	public void setMC_USE_YN(String mC_USE_YN) {
		MC_USE_YN = mC_USE_YN;
	}

	
	
}
