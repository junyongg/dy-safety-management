package com.tx.admin.program.application.dto;

import com.tx.common.dto.Common;

public class PlaceSeatDTO extends Common {

	private static final long serialVersionUID = -7592042390730815233L;

	private String
			  PSM_KEYNO
			, PSM_PM_KEYNO
			, PSM_NAME
			
			, PSS_KEYNO
			, PSS_PSM_KEYNO
			, PSS_CODE;
	
	private int 
			  PSM_ROW
			, PSM_COL
			, PSM_TOP
			, PSM_LEFT
			
			, PSS_ROW
			, PSS_COL;
	
	
	
	public String getPSM_PM_KEYNO() {
		return PSM_PM_KEYNO;
	}

	public void setPSM_PM_KEYNO(String pSM_PM_KEYNO) {
		PSM_PM_KEYNO = pSM_PM_KEYNO;
	}

	public String getPSM_KEYNO() {
		return PSM_KEYNO;
	}

	public void setPSM_KEYNO(String pSM_KEYNO) {
		PSM_KEYNO = pSM_KEYNO;
	}

	public String getPSM_NAME() {
		return PSM_NAME;
	}

	public void setPSM_NAME(String pSM_NAME) {
		PSM_NAME = pSM_NAME;
	}

	public String getPSS_KEYNO() {
		return PSS_KEYNO;
	}

	public void setPSS_KEYNO(String pSS_KEYNO) {
		PSS_KEYNO = pSS_KEYNO;
	}

	public String getPSS_PSM_KEYNO() {
		return PSS_PSM_KEYNO;
	}

	public void setPSS_PSM_KEYNO(String pSS_PSM_KEYNO) {
		PSS_PSM_KEYNO = pSS_PSM_KEYNO;
	}

	public String getPSS_CODE() {
		return PSS_CODE;
	}

	public void setPSS_CODE(String pSS_CODE) {
		PSS_CODE = pSS_CODE;
	}

	public int getPSM_ROW() {
		return PSM_ROW;
	}

	public void setPSM_ROW(int pSM_ROW) {
		PSM_ROW = pSM_ROW;
	}

	public int getPSM_COL() {
		return PSM_COL;
	}

	public void setPSM_COL(int pSM_COL) {
		PSM_COL = pSM_COL;
	}

	public int getPSM_TOP() {
		return PSM_TOP;
	}

	public void setPSM_TOP(int pSM_TOP) {
		PSM_TOP = pSM_TOP;
	}

	public int getPSM_LEFT() {
		return PSM_LEFT;
	}

	public void setPSM_LEFT(int PSM_LEFT) {
		this.PSM_LEFT = PSM_LEFT;
	}

	public int getPSS_ROW() {
		return PSS_ROW;
	}

	public void setPSS_ROW(int pSS_ROW) {
		PSS_ROW = pSS_ROW;
	}

	public int getPSS_COL() {
		return PSS_COL;
	}

	public void setPSS_COL(int pSS_COL) {
		PSS_COL = pSS_COL;
	}

	
	
}
