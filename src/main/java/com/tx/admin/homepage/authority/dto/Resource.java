package com.tx.admin.homepage.authority.dto;

public class Resource {
	
	private String UIA_KEYNO,
				   USR_KEYNO,
				   USR_NAME,
				   USR_PATTERN,
				   USR_TYPE,
				   USR_UIR_KEYNO,
				   USR_ORDER_CLASS,
				   MN_KEYNO= "";
	private int    USR_ORDER;
	
	private String[] urlResources;
	
	public Resource(){
	}
	
	public Resource(String USR_KEYNO, String USR_NAME, String USR_PATTERN, int USR_ORDER, String USR_ORDER_CLASS ){
		this.USR_KEYNO = USR_KEYNO;
		this.USR_NAME = USR_NAME;
		this.USR_PATTERN = USR_PATTERN;
		this.USR_ORDER = USR_ORDER;
		this.USR_TYPE = "url";
		this.USR_ORDER_CLASS = USR_ORDER_CLASS;
	}
	
	
	
	public String getMN_KEYNO() {
		return MN_KEYNO;
	}

	public void setMN_KEYNO(String mN_KEYNO) {
		MN_KEYNO = mN_KEYNO;
	}

	public String getUSR_UIR_KEYNO() {
		return USR_UIR_KEYNO;
	}

	public void setUSR_UIR_KEYNO(String uSR_UIR_KEYNO) {
		USR_UIR_KEYNO = uSR_UIR_KEYNO;
	}

	public String getUIA_KEYNO() {
		return UIA_KEYNO;
	}



	public void setUIA_KEYNO(String uIA_KEYNO) {
		UIA_KEYNO = uIA_KEYNO;
	}



	public String[] getUrlResources() {
		String[] temp = new String[urlResources.length];
	    System.arraycopy(urlResources, 0, temp, 0, urlResources.length);
	    return temp;
	}

	public void setUrlResources(String[] urlResources) {
		
		String[] temp = new String[urlResources.length];
	    System.arraycopy(urlResources, 0, temp, 0, urlResources.length);
	    this.urlResources = temp;
	}



	public String getUSR_KEYNO() {
		return USR_KEYNO;
	}

	public void setUSR_KEYNO(String uSR_KEYNO) {
		USR_KEYNO = uSR_KEYNO;
	}

	public String getUSR_NAME() {
		return USR_NAME;
	}

	public void setUSR_NAME(String uSR_NAME) {
		USR_NAME = uSR_NAME;
	}

	public String getUSR_PATTERN() {
		return USR_PATTERN;
	}

	public void setUSR_PATTERN(String uSR_PATTERN) {
		USR_PATTERN = uSR_PATTERN;
	}

	public String getUSR_TYPE() {
		return USR_TYPE;
	}

	public void setUSR_TYPE(String uSR_TYPE) {
		USR_TYPE = uSR_TYPE;
	}

	public int getUSR_ORDER() {
		return USR_ORDER;
	}


	public void setUSR_ORDER(int uSR_ORDER) {
		USR_ORDER = uSR_ORDER;
	}


	public String getUSR_ORDER_CLASS() {
		return USR_ORDER_CLASS;
	}

	public void setUSR_ORDER_CLASS(String uSR_ORDER_CLASS) {
		USR_ORDER_CLASS = uSR_ORDER_CLASS;
	}
	
	
				   
}
