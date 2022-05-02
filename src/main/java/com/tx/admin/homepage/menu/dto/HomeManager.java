package com.tx.admin.homepage.menu.dto;

import java.io.Serializable;
import java.util.List;

/* 홈페이지 관리 - Menu의 MN_HOMEDIV_C 연관 */
public class HomeManager extends Menu implements Serializable{

	private static final long serialVersionUID = -1966682431378308377L;
	
	private String HM_KEYNO = "";
	private String HM_TILES = "";
	private String HM_MENU_DEPTH = "";
	private String HM_DEL_YN = "";
	private String HM_MN_HOMEDIV_C = "";
	private String HM_FAVICON = "";
	private String FS_PATH = "";
	private String FS_FILENAME = "";
	private String FS_ORINM = "";
	
	private String    HM_LANG
					, HM_TITLE = "";
	
	
	
	
	private List<String> pageDivList = null;
	
	private String UIA_KEYNO = null;
	private String UIA_MAINKEY = null;

	public String getHM_LANG() {
		return HM_LANG;
	}
	public void setHM_LANG(String hM_LANG) {
		HM_LANG = hM_LANG;
	}
	public String getHM_TITLE() {
		return HM_TITLE;
	}
	public void setHM_TITLE(String hM_TITLE) {
		HM_TITLE = hM_TITLE;
	}
	public String getUIA_KEYNO() {
		return UIA_KEYNO;
	}
	public void setUIA_KEYNO(String uIA_KEYNO) {
		UIA_KEYNO = uIA_KEYNO;
	}
	public List<String> getPageDivList() {
		return pageDivList;
	}
	public void setPageDivList(List<String> pageDivList) {
		this.pageDivList = pageDivList;
	}
	public String getFS_ORINM() {
		return FS_ORINM;
	}
	public void setFS_ORINM(String fS_ORINM) {
		FS_ORINM = fS_ORINM;
	}
	public String getFS_FILENAME() {
		return FS_FILENAME;
	}
	public void setFS_FILENAME(String fS_FILENAME) {
		FS_FILENAME = fS_FILENAME;
	}
	public String getFS_PATH() {
		return FS_PATH;
	}
	public void setFS_PATH(String fS_PATH) {
		FS_PATH = fS_PATH;
	}
	public String getHM_KEYNO() {
		return HM_KEYNO;
	}
	public void setHM_KEYNO(String hM_KEYNO) {
		HM_KEYNO = hM_KEYNO;
	}
	public String getHM_TILES() {
		return HM_TILES;
	}
	public void setHM_TILES(String hM_TILES) {
		HM_TILES = hM_TILES;
	}
	public String getHM_MENU_DEPTH() {
		return HM_MENU_DEPTH;
	}
	public void setHM_MENU_DEPTH(String hM_MENU_DEPTH) {
		HM_MENU_DEPTH = hM_MENU_DEPTH;
	}
	public String getHM_DEL_YN() {
		return HM_DEL_YN;
	}
	public void setHM_DEL_YN(String hM_DEL_YN) {
		HM_DEL_YN = hM_DEL_YN;
	}
	public String getHM_MN_HOMEDIV_C() {
		return HM_MN_HOMEDIV_C;
	}
	public void setHM_MN_HOMEDIV_C(String hM_MN_HOMEDIV_C) {
		HM_MN_HOMEDIV_C = hM_MN_HOMEDIV_C;
	}
	public String getHM_FAVICON() {
		return HM_FAVICON;
	}
	public void setHM_FAVICON(String hM_FAVICON) {
		HM_FAVICON = hM_FAVICON;
	}
	public String getUIA_MAINKEY() {
		return UIA_MAINKEY;
	}
	public void setUIA_MAINKEY(String uIA_MAINKEY) {
		UIA_MAINKEY = uIA_MAINKEY;
	}
	
	
}