package com.tx.admin.operation.organization.dto;

import com.tx.common.dto.Common;

/**
 * 조직도 DTO
 * @author 이재령
 *
 */
public class OrganDTO extends Common{
	
	private static final long serialVersionUID = -1551175321744444629L;


					/** T_DEPARTMENT_MANAGER  */
	private String  DN_KEYNO
				  , DN_NAME
				  , DN_MAINKEY
				  , DN_MAINKEY_BEFORE
				  , DN_CONTENTS
				  , DN_DEL_YN
				  , DN_TEMP
				  , DN_HOMEDIV_C
	
					/** T_DEPARTMENT_USER_MANAGER  */
				  , DU_KEYNO
				  , DU_NAME
				  , DU_DN_KEYNO
				  , DU_ROLE
				  , DU_CONTENTS
				  , CONTENTS_BR
				  , DU_TEL
				  , TEL_BR
				  , DU_DEL_YN 
				  , DU_HOMEDIV_C = "";
	
	
	private Integer	DU_LEV = 0;
	private Integer	DN_LEV = 0;
	private Integer	DU_LEV_AFTER = 0;
	private Integer	DN_LEV_AFTER = 0;
	
	private int     DN_COUNT = 0; // 부서원 수
	private int     DN_COUNT_DEPARTMENT = 0; // 하위부서 수
	
	private String  DN_MAINNAME = ""; // 상위부서명
	
	
	
	
	
	
	
	public String getCONTENTS_BR() {
		return CONTENTS_BR;
	}

	public void setCONTENTS_BR(String cONTENTS_BR) {
		CONTENTS_BR = cONTENTS_BR;
	}

	public String getTEL_BR() {
		return TEL_BR;
	}

	public void setTEL_BR(String tEL_BR) {
		TEL_BR = tEL_BR;
	}

	public String getDN_MAINKEY_BEFORE() {
		return DN_MAINKEY_BEFORE;
	}

	public void setDN_MAINKEY_BEFORE(String dN_MAINKEY_BEFORE) {
		DN_MAINKEY_BEFORE = dN_MAINKEY_BEFORE;
	}

	public Integer getDN_LEV() {
		return DN_LEV;
	}

	public void setDN_LEV(Integer dN_LEV) {
		DN_LEV = dN_LEV;
	}

	public Integer getDN_LEV_AFTER() {
		return DN_LEV_AFTER;
	}

	public void setDN_LEV_AFTER(Integer dN_LEV_AFTER) {
		DN_LEV_AFTER = dN_LEV_AFTER;
	}

	public Integer getDU_LEV_AFTER() {
		return DU_LEV_AFTER;
	}

	public void setDU_LEV_AFTER(Integer dU_LEV_AFTER) {
		DU_LEV_AFTER = dU_LEV_AFTER;
	}

	public String getDN_TEMP() {
		return DN_TEMP;
	}

	public void setDN_TEMP(String dN_TEMP) {
		DN_TEMP = dN_TEMP;
	}

	public int getDN_COUNT_DEPARTMENT() {
		return DN_COUNT_DEPARTMENT;
	}

	public void setDN_COUNT_DEPARTMENT(int dN_COUNT_DEPARTMENT) {
		DN_COUNT_DEPARTMENT = dN_COUNT_DEPARTMENT;
	}

	public String getDU_TEL() {
		return DU_TEL;
	}

	public void setDU_TEL(String dU_TEL) {
		DU_TEL = dU_TEL;
	}

	public String getDU_CONTENTS() {
		return DU_CONTENTS;
	}

	public void setDU_CONTENTS(String dU_CONTENTS) {
		DU_CONTENTS = dU_CONTENTS;
	}

	

	public Integer getDU_LEV() {
		return DU_LEV;
	}

	public void setDU_LEV(Integer dU_LEV) {
		DU_LEV = dU_LEV;
	}

	public String getDU_ROLE() {
		return DU_ROLE;
	}

	public void setDU_ROLE(String dU_ROLE) {
		DU_ROLE = dU_ROLE;
	}

	public String getDN_MAINNAME() {
		return DN_MAINNAME;
	}

	public void setDN_MAINNAME(String dN_MAINNAME) {
		DN_MAINNAME = dN_MAINNAME;
	}

	public String getDU_KEYNO() {
		return DU_KEYNO;
	}

	public void setDU_KEYNO(String dU_KEYNO) {
		DU_KEYNO = dU_KEYNO;
	}

	public String getDU_NAME() {
		return DU_NAME;
	}

	public void setDU_NAME(String dU_NAME) {
		DU_NAME = dU_NAME;
	}

	public String getDU_DN_KEYNO() {
		return DU_DN_KEYNO;
	}

	public void setDU_DN_KEYNO(String dU_DN_KEYNO) {
		DU_DN_KEYNO = dU_DN_KEYNO;
	}

	public String getDU_DEL_YN() {
		return DU_DEL_YN;
	}

	public void setDU_DEL_YN(String dU_DEL_YN) {
		DU_DEL_YN = dU_DEL_YN;
	}

	public String getDN_CONTENTS() {
		return DN_CONTENTS;
	}

	public void setDN_CONTENTS(String dN_CONTENTS) {
		DN_CONTENTS = dN_CONTENTS;
	}

	public String getDN_KEYNO() {
		return DN_KEYNO;
	}

	public void setDN_KEYNO(String DN_KEYNO) {
		this.DN_KEYNO = DN_KEYNO;
	}

	public String getDN_NAME() {
		return DN_NAME;
	}

	public void setDN_NAME(String dN_NAME) {
		DN_NAME = dN_NAME;
	}

	public String getDN_MAINKEY() {
		return DN_MAINKEY;
	}

	public void setDN_MAINKEY(String DN_MAINKEY) {
		this.DN_MAINKEY = DN_MAINKEY;
	}

	public String getDN_DEL_YN() {
		return DN_DEL_YN;
	}

	public void setDN_DEL_YN(String dN_DEL_YN) {
		DN_DEL_YN = dN_DEL_YN;
	}

	public int getDN_COUNT() {
		return DN_COUNT;
	}

	public void setDN_COUNT(int dN_COUNT) {
		DN_COUNT = dN_COUNT;
	}

	public String getDN_HOMEDIV_C() {
		return DN_HOMEDIV_C;
	}

	public void setDN_HOMEDIV_C(String dN_HOMEDIV_C) {
		DN_HOMEDIV_C = dN_HOMEDIV_C;
	}

	public String getDU_HOMEDIV_C() {
		return DU_HOMEDIV_C;
	}

	public void setDU_HOMEDIV_C(String dU_HOMEDIV_C) {
		DU_HOMEDIV_C = dU_HOMEDIV_C;
	}
	
	
	
	
	
}
