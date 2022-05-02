package com.tx.admin.operation.satisfaction.dto;

import com.tx.common.dto.Common;

/**
 * 페이지 만족도 DTO
 * @author admin
 *
 */
public class SatisfactionDTO extends Common {

	private static final long serialVersionUID = 9179373720866683626L;
	private String  
		/* T_PAGE_RESEARCH_MANAGER */
		  TPS_KEYNO
		, TPS_MN_KEYNO
		, TPS_HOME_KEYNO
		, TPS_SCORE
		, TPS_COMMENT
		, TPS_REGDT
		, TPS_IP
		, TPS_SCORE_NAME
		;
		
	public String getTPS_KEYNO() {
		return TPS_KEYNO;
	}

	public void setTPS_KEYNO(String tPS_KEYNO) {
		TPS_KEYNO = tPS_KEYNO;
	}

	public String getTPS_MN_KEYNO() {
		return TPS_MN_KEYNO;
	}

	public void setTPS_MN_KEYNO(String tPS_MN_KEYNO) {
		TPS_MN_KEYNO = tPS_MN_KEYNO;
	}

	public String getTPS_HOME_KEYNO() {
		return TPS_HOME_KEYNO;
	}

	public void setTPS_HOME_KEYNO(String tPS_HOME_KEYNO) {
		TPS_HOME_KEYNO = tPS_HOME_KEYNO;
	}

	public String getTPS_SCORE() {
		return TPS_SCORE;
	}

	public void setTPS_SCORE(String tPS_SCORE) {
		TPS_SCORE = tPS_SCORE;
	}

	public String getTPS_COMMENT() {
		return TPS_COMMENT;
	}

	public void setTPS_COMMENT(String tPS_COMMENT) {
		TPS_COMMENT = tPS_COMMENT;
	}

	public String getTPS_REGDT() {
		return TPS_REGDT;
	}

	public void setTPS_REGDT(String tPS_REGDT) {
		TPS_REGDT = tPS_REGDT;
	}

	public String getTPS_IP() {
		return TPS_IP;
	}

	public void setTPS_IP(String tPS_IP) {
		TPS_IP = tPS_IP;
	}

	public String getTPS_SCORE_NAME() {
		return TPS_SCORE_NAME;
	}

	public void setTPS_SCORE_NAME(String tPS_SCORE_NAME) {
		TPS_SCORE_NAME = tPS_SCORE_NAME;
	}
		
		
}
