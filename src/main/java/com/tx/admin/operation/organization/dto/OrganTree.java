package com.tx.admin.operation.organization.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class OrganTree implements Serializable {
	private static final long serialVersionUID = 6587463436380309327L;

	private String  DN_KEYNO
				  , DN_NAME
				  , DN_MAINKEY
				  , DN_HOMEDIV_C
				  ="";
				  
	private List<OrganTree> children = new ArrayList<OrganTree>();

	

	public List<OrganTree> getChildren() {
		return children;
	}

	public void setChildren(List<OrganTree> children) {
		this.children = children;
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

	public String getDN_HOMEDIV_C() {
		return DN_HOMEDIV_C;
	}

	public void setDN_HOMEDIV_C(String dN_HOMEDIV_C) {
		DN_HOMEDIV_C = dN_HOMEDIV_C;
	}
	
}
