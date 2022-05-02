package com.tx.admin.function.keyword.dto;

import java.io.Serializable;

public class KeywordDTO implements Serializable {
	
	private static final long serialVersionUID = 2437118979080772052L;

	private String SK_KEYWORD,SK_REGDT,SK_IP,SK_USERID,UI_ID = "";
	
	private int SK_SIZE,KeywordSize,minCount = 0;
	
	
	
	
	public int getKeywordSize() {
		return KeywordSize;
	}

	public void setKeywordSize(int keywordSize) {
		KeywordSize = keywordSize;
	}

	public int getMinCount() {
		return minCount;
	}

	public void setMinCount(int minCount) {
		this.minCount = minCount;
	}

	public String getUI_ID() {
		return UI_ID;
	}

	public void setUI_ID(String uI_ID) {
		UI_ID = uI_ID;
	}

	public int getSK_SIZE() {
		return SK_SIZE;
	}

	public void setSK_SIZE(int sK_SIZE) {
		SK_SIZE = sK_SIZE;
	}

	public String getSK_KEYWORD() {
		return SK_KEYWORD;
	}

	public void setSK_KEYWORD(String sK_KEYWORD) {
		SK_KEYWORD = sK_KEYWORD;
	}

	public String getSK_REGDT() {
		return SK_REGDT;
	}

	public void setSK_REGDT(String sK_REGDT) {
		SK_REGDT = sK_REGDT;
	}

	public String getSK_IP() {
		return SK_IP;
	}

	public void setSK_IP(String sK_IP) {
		SK_IP = sK_IP;
	}

	public String getSK_USERID() {
		return SK_USERID;
	}

	public void setSK_USERID(String sK_USERID) {
		SK_USERID = sK_USERID;
	}
	
	
	
	
}
