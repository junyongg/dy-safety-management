package com.tx.admin.statistics.dto;

import com.tx.common.dto.Common;

public class LogDTO extends Common {
	
	private static final long serialVersionUID = 621937432376974413L;

	private String AH_KEYNO
				 , AH_UI_KEYNO
				 , AH_IP
				 , AH_DATE
				 , AH_URL
				 , AH_DESC
				 , AH_MENU
				 , AH_REFERER
				 , AH_DEVICE = ""
				 , AH_AGENT
				 , AH_SESSION
				 , AH_HOMEDIV_C
				 , AH_BROWSER
				 , AH_OS
				 ;
	
	
	
	
	private String UI_ID = null;
	
	
	private String BROWSER = null;
	private String OS = null;
	private String DAYTIME = null;
	private String CASE = null;

	//새로운 방문자 카운트
	private String DOMAIN = null;
	private String count = null;
	private String DAYOFWEEK = null;
	private String MONTH = null;
	private String YEAR = null;
	private String TIME = null;
	
	
	private String order = "A";
	private String searchbot = null;
	
	private float persent = 0;
	private int no=0;
	
	
	
	
	public String getSearchbot() {
		return searchbot;
	}

	public void setSearchbot(String searchbot) {
		this.searchbot = searchbot;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getAH_BROWSER() {
		return AH_BROWSER;
	}
	
	public void setAH_BROWSER(String aH_BROWSER) {
		AH_BROWSER = aH_BROWSER;
	}

	public String getAH_OS() {
		return AH_OS;
	}

	public void setAH_OS(String aH_OS) {
		AH_OS = aH_OS;
	}

	public String getUI_ID() {
		return UI_ID;
	}

	public void setUI_ID(String uI_ID) {
		UI_ID = uI_ID;
	}

	public String getCASE() {
		return CASE;
	}

	public void setCASE(String cASE) {
		CASE = cASE;
	}

	public String getAH_HOMEDIV_C() {
		return AH_HOMEDIV_C;
	}

	public void setAH_HOMEDIV_C(String aH_HOMEDIV_C) {
		AH_HOMEDIV_C = aH_HOMEDIV_C;
	}

	public String getAH_SESSION() {
		return AH_SESSION;
	}

	public void setAH_SESSION(String aH_SESSION) {
		AH_SESSION = aH_SESSION;
	}

	public String getTIME() {
		return TIME;
	}

	public void setTIME(String tIME) {
		TIME = tIME;
	}

	public String getDOMAIN() {
		return DOMAIN;
	}

	public void setDOMAIN(String dOMAIN) {
		DOMAIN = dOMAIN;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getDAYOFWEEK() {
		return DAYOFWEEK;
	}

	public void setDAYOFWEEK(String dAYOFWEEK) {
		DAYOFWEEK = dAYOFWEEK;
	}

	public String getMONTH() {
		return MONTH;
	}

	public void setMONTH(String mONTH) {
		MONTH = mONTH;
	}

	public String getYEAR() {
		return YEAR;
	}

	public void setYEAR(String yEAR) {
		YEAR = yEAR;
	}

	public float getPersent() {
		return persent;
	}

	public void setPersent(float persent) {
		this.persent = persent;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getBROWSER() {
		return BROWSER;
	}

	public void setBROWSER(String bROWSER) {
		BROWSER = bROWSER;
	}

	public String getOS() {
		return OS;
	}

	public void setOS(String oS) {
		OS = oS;
	}

	public String getDAYTIME() {
		return DAYTIME;
	}

	public void setDAYTIME(String dAYTIME) {
		DAYTIME = dAYTIME;
	}

	public String getAH_MENU() {
		return AH_MENU;
	}

	public void setAH_MENU(String aH_MENU) {
		AH_MENU = aH_MENU;
	}

	public String getAH_REFERER() {
		return AH_REFERER;
	}

	public void setAH_REFERER(String aH_REFERER) {
		AH_REFERER = aH_REFERER;
	}

	public String getAH_DEVICE() {
		return AH_DEVICE;
	}

	public void setAH_DEVICE(String aH_DEVICE) {
		AH_DEVICE = aH_DEVICE;
	}

	public String getAH_AGENT() {
		return AH_AGENT;
	}

	public void setAH_AGENT(String aH_AGENT) {
		AH_AGENT = aH_AGENT;
	}

	public String getAH_KEYNO() {
		return AH_KEYNO;
	}

	public void setAH_KEYNO(String aH_KEYNO) {
		AH_KEYNO = aH_KEYNO;
	}

	public String getAH_UI_KEYNO() {
		return AH_UI_KEYNO;
	}

	public void setAH_UI_KEYNO(String aH_UI_KEYNO) {
		AH_UI_KEYNO = aH_UI_KEYNO;
	}

	public String getAH_IP() {
		return AH_IP;
	}

	public void setAH_IP(String aH_IP) {
		AH_IP = aH_IP;
	}

	public String getAH_DATE() {
		return AH_DATE;
	}

	public void setAH_DATE(String aH_DATE) {
		AH_DATE = aH_DATE;
	}

	public String getAH_URL() {
		return AH_URL;
	}

	public void setAH_URL(String aH_URL) {
		AH_URL = aH_URL;
	}

	public String getAH_DESC() {
		return AH_DESC;
	}

	public void setAH_DESC(String aH_DESC) {
		AH_DESC = aH_DESC;
	}
	
	// SELECT 용
	private int COUNT = 0;
	private String STDT = null;
	private String ENDT = null;
	private String OPTION = null;
	private String MN_NAME = null;// 메뉴페이지카운터에서 메뉴이름
	private String MN_KEYNO = null;
	private String MN_HOMEDIV_NAME = null;
	private String MN_LEV = null;
	private String HOME_DIV = null;
	private String Is_MOBILE = null;
	private String DEV = null;
	
	public String getMN_LEV() {
		return MN_LEV;
	}

	public void setMN_LEV(String mN_LEV) {
		MN_LEV = mN_LEV;
	}

	public String getMN_HOMEDIV_NAME() {
		return MN_HOMEDIV_NAME;
	}

	public void setMN_HOMEDIV_NAME(String mN_HOMEDIV_NAME) {
		MN_HOMEDIV_NAME = mN_HOMEDIV_NAME;
	}

	public String getDEV() {
		return DEV;
	}

	public void setDEV(String dEV) {
		DEV = dEV;
	}

	public String getMN_KEYNO() {
		return MN_KEYNO;
	}

	public void setMN_KEYNO(String mN_KEYNO) {
		MN_KEYNO = mN_KEYNO;
	}

	public int getCOUNT() {
		return COUNT;
	}

	public void setCOUNT(int cOUNT) {
		COUNT = cOUNT;
	}

	public String getSTDT() {
		return STDT;
	}

	public void setSTDT(String sTDT) {
		STDT = sTDT;
	}

	public String getENDT() {
		return ENDT;
	}

	public void setENDT(String eNDT) {
		ENDT = eNDT;
	}

	public String getOPTION() {
		return OPTION;
	}

	public void setOPTION(String oPTION) {
		OPTION = oPTION;
	}

	public String getMN_NAME() {
		return MN_NAME;
	}

	public void setMN_NAME(String mN_NAME) {
		MN_NAME = mN_NAME;
	}

	public String getHOME_DIV() {
		return HOME_DIV;
	}

	public void setHOME_DIV(String hOME_DIV) {
		HOME_DIV = hOME_DIV;
	}

	public String getIs_MOBILE() {
		return Is_MOBILE;
	}

	public void setIs_MOBILE(String is_MOBILE) {
		Is_MOBILE = is_MOBILE;
	}
}
