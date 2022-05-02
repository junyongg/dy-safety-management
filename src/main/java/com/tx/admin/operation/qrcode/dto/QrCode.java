package com.tx.admin.operation.qrcode.dto;

public class QrCode {
    
    private String CQ_KEYNO, CQ_URL, CQ_NAME, CQ_FS_KEYNO, FS_CHANGENM;
    private int CQ_WIDTH, CQ_HEIGHT;

	public String getCQ_FS_KEYNO() {
		return CQ_FS_KEYNO;
	}
	public void setCQ_FS_KEYNO(String cQ_FS_KEYNO) {
		CQ_FS_KEYNO = cQ_FS_KEYNO;
	}
	public String getCQ_KEYNO() {
		return CQ_KEYNO;
	}
	public void setCQ_KEYNO(String cQ_KEYNO) {
		CQ_KEYNO = cQ_KEYNO;
	}
	public String getCQ_URL() {
		return CQ_URL;
	}
	public void setCQ_URL(String cQ_URL) {
		CQ_URL = cQ_URL;
	}
	public String getCQ_NAME() {
		return CQ_NAME;
	}
	public void setCQ_NAME(String cQ_NAME) {
		CQ_NAME = cQ_NAME;
	}
	public int getCQ_WIDTH() {
		return CQ_WIDTH;
	}
	public void setCQ_WIDTH(Integer cQ_WIDTH) {
		if(cQ_WIDTH == null){
			cQ_WIDTH = 0;
		}else{
			CQ_WIDTH = cQ_WIDTH;
		}
	}
	public int getCQ_HEIGHT() {
		return CQ_HEIGHT;
	}
	public void setCQ_HEIGHT(Integer cQ_HEIGHT) {
		if(cQ_HEIGHT == null){
			CQ_HEIGHT = 0;
		}else{
			CQ_HEIGHT = cQ_HEIGHT;
		}
	}
	public String getFS_CHANGENM() {
		return FS_CHANGENM;
	}
	public void setFS_CHANGENM(String fS_CHANGENM) {
		FS_CHANGENM = fS_CHANGENM;
	}

}
