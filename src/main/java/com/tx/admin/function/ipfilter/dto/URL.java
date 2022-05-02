package com.tx.admin.function.ipfilter.dto;

import com.tx.admin.function.ipfilter.service.IpTree;

public class URL {
	private String  keyno
				    , url[]
		    		, type;
	private IpTree ipTree;

	public String getKeyno() {
		return keyno;
	}

	public void setKeyno(String keyno) {
		this.keyno = keyno;
	}

	public String[] getUrl() {
		return url;
	}

	public void setUrl(String[] url) {
		this.url = url;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public IpTree getIpTree() {
		return ipTree;
	}

	public void setIpTree(IpTree ipTree) {
		this.ipTree = ipTree;
	}
	
	
	
	
	
}
