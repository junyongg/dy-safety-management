package com.tx.admin.function.code.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @MainCode
 * 공통기능의 상위 서브코드 기능을 담당하는 빈즈
 * @author 신희원
 * @version 1.0
 * @since 2014-11-12
 */
public class SubCode implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1579355038899944705L;

	
	
	private String MC_CODENM = null;
	
	//서브코드 고유키
	private String SC_KEYNO = null;
	
	//상위코드 
	private String SC_MC_IN_C = null;
	
	//서브코드 명칭
	private String SC_CODENM = null;
	
	//서브코드 값 1
	private String SC_CODEVAL01 = null;
	
	//서브코드 값 2
	private String SC_CODEVAL02 = null;
	
	//서브코드 정렬순서 ex) 1,2,3,4...순번으로 정렬
	private Integer SC_CODELV = null;
	
	//서브코드 사용  여부 
	private String SC_USE_YN = null;
	
	//코드 정보 내역
	private List<String> In_Code_Array = new ArrayList<String>();	
	
	public List<String> getIn_Code_Array() {
		return In_Code_Array;
	}
	
	public void setIn_Code_Array(List<String> in_Code_Array) {
		In_Code_Array = in_Code_Array;
	}

	public String getSC_KEYNO() {
		return SC_KEYNO;
	}

	public void setSC_KEYNO(String sC_KEYNO) {
		SC_KEYNO = sC_KEYNO;
	}

	public String getSC_MC_IN_C() {
		return SC_MC_IN_C;
	}

	public void setSC_MC_IN_C(String sC_MC_IN_C) {
		SC_MC_IN_C = sC_MC_IN_C;
	}

	public String getSC_CODENM() {
		return SC_CODENM;
	}

	public void setSC_CODENM(String sC_CODENM) {
		SC_CODENM = sC_CODENM;
	}

	public String getSC_CODEVAL01() {
		return SC_CODEVAL01;
	}

	public void setSC_CODEVAL01(String sC_CODEVAL01) {
		SC_CODEVAL01 = sC_CODEVAL01;
	}

	public String getSC_CODEVAL02() {
		return SC_CODEVAL02;
	}

	public void setSC_CODEVAL02(String sC_CODEVAL02) {
		SC_CODEVAL02 = sC_CODEVAL02;
	}

	public Integer getSC_CODELV() {
		return SC_CODELV;
	}

	public void setSC_CODELV(Integer sC_CODELV) {
		SC_CODELV = sC_CODELV;
	}

	public String getSC_USE_YN() {
		return SC_USE_YN;
	}

	public void setSC_USE_YN(String sC_USE_YN) {
		SC_USE_YN = sC_USE_YN;
	}

	public String getMC_CODENM() {
		return MC_CODENM;
	}

	public void setMC_CODENM(String mC_CODENM) {
		MC_CODENM = mC_CODENM;
	}

	
	

}
