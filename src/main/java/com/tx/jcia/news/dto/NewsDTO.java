package com.tx.jcia.news.dto;

import com.tx.common.dto.Common;

/**
 * 신청 팝업 DTO
 *
 */
public class NewsDTO extends Common {

	private static final long serialVersionUID = 5277894531127242992L;

	private String  
					/*뉴스레터*/
					/*T_NEWS_LETTER_MEMBER*/
					  NL_KEYNO
					, NL_NAME
					, NL_POSITION
					, NL_BELONG
					, NL_EMAIL
					, NL_IP
					, NL_REGDT
					, NL_DELYN
					, NL_MAILING
					
					/*T_NEWSLETTER_MANAGER*/
					, NM_KEYNO
					, NM_TITLE
					, NM_FS_KEYNO
					, NM_YEAR
					, NM_MONTH
					, NM_NUMBERING
					, NM_CONTENT
					, NM_REGDT
					, NM_REGNM
					, NM_DELYN
					, NM_HITS
					
					, IMG_PATH
					;
	
	private int pageUnit2 = 16;
	
	
	

	public String getIMG_PATH() {
		return IMG_PATH;
	}

	public void setIMG_PATH(String iMG_PATH) {
		IMG_PATH = iMG_PATH;
	}

	public int getPageUnit2() {
		return pageUnit2;
	}

	public void setPageUnit2(int pageUnit2) {
		this.pageUnit2 = pageUnit2;
	}

	public String getNL_KEYNO() {
		return NL_KEYNO;
	}

	public void setNL_KEYNO(String nL_KEYNO) {
		NL_KEYNO = nL_KEYNO;
	}

	public String getNL_NAME() {
		return NL_NAME;
	}

	public void setNL_NAME(String nL_NAME) {
		NL_NAME = nL_NAME;
	}

	public String getNL_POSITION() {
		return NL_POSITION;
	}

	public void setNL_POSITION(String nL_POSITION) {
		NL_POSITION = nL_POSITION;
	}

	public String getNL_BELONG() {
		return NL_BELONG;
	}

	public void setNL_BELONG(String nL_BELONG) {
		NL_BELONG = nL_BELONG;
	}

	public String getNL_EMAIL() {
		return NL_EMAIL;
	}

	public void setNL_EMAIL(String nL_EMAIL) {
		NL_EMAIL = nL_EMAIL;
	}

	public String getNL_IP() {
		return NL_IP;
	}

	public void setNL_IP(String nL_IP) {
		NL_IP = nL_IP;
	}

	public String getNL_REGDT() {
		return NL_REGDT;
	}

	public void setNL_REGDT(String nL_REGDT) {
		NL_REGDT = nL_REGDT;
	}

	public String getNL_DELYN() {
		return NL_DELYN;
	}

	public void setNL_DELYN(String nL_DELYN) {
		NL_DELYN = nL_DELYN;
	}

	public String getNM_KEYNO() {
		return NM_KEYNO;
	}

	public void setNM_KEYNO(String nM_KEYNO) {
		NM_KEYNO = nM_KEYNO;
	}

	public String getNM_TITLE() {
		return NM_TITLE;
	}

	public void setNM_TITLE(String nM_TITLE) {
		NM_TITLE = nM_TITLE;
	}

	public String getNM_FS_KEYNO() {
		return NM_FS_KEYNO;
	}

	public void setNM_FS_KEYNO(String nM_FS_KEYNO) {
		NM_FS_KEYNO = nM_FS_KEYNO;
	}

	public String getNM_YEAR() {
		return NM_YEAR;
	}

	public void setNM_YEAR(String nM_YEAR) {
		NM_YEAR = nM_YEAR;
	}

	public String getNM_MONTH() {
		return NM_MONTH;
	}

	public void setNM_MONTH(String nM_MONTH) {
		NM_MONTH = nM_MONTH;
	}

	public String getNM_NUMBERING() {
		return NM_NUMBERING;
	}

	public void setNM_NUMBERING(String nM_NUMBERING) {
		NM_NUMBERING = nM_NUMBERING;
	}

	public String getNM_CONTENT() {
		return NM_CONTENT;
	}

	public void setNM_CONTENT(String nM_CONTENT) {
		NM_CONTENT = nM_CONTENT;
	}

	public String getNM_REGDT() {
		return NM_REGDT;
	}

	public void setNM_REGDT(String nM_REGDT) {
		NM_REGDT = nM_REGDT;
	}

	public String getNM_REGNM() {
		return NM_REGNM;
	}

	public void setNM_REGNM(String nM_REGNM) {
		NM_REGNM = nM_REGNM;
	}

	public String getNM_DELYN() {
		return NM_DELYN;
	}

	public void setNM_DELYN(String nM_DELYN) {
		NM_DELYN = nM_DELYN;
	}

	public String getNL_MAILING() {
		return NL_MAILING;
	}

	public void setNL_MAILING(String nL_MAILING) {
		NL_MAILING = nL_MAILING;
	}

	public String getNM_HITS() {
		return NM_HITS;
	}

	public void setNM_HITS(String nM_HITS) {
		NM_HITS = nM_HITS;
	}
	
	
}
