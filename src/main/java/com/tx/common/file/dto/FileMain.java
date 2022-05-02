package com.tx.common.file.dto;

import java.io.Serializable;


/**
 * @FileMain
 * 공통기능의 상위 파일정보를 관리 하는 빈즈
 * @author 신희원
 * @version 1.0
 * @since 2014-11-12
 */
public class FileMain implements Serializable {
	
	//시리얼 넘버
	static final long serialVersionUID = 42L;
	
	//고유키
	private String FM_KEYNO = null;
	
	//업로드일자
	private String FM_REGDT = null;
	
	//업로드 사용자
	private String FM_REGNM = null;
	
	private int FS_CNT = 0;
	
	//사용 처 추적용 키 목록
	private String FM_WHERE_KEYS;
	//파일 설명
	private String FM_COMMENTS;
	
	
	public FileMain() {
		super();
	}
	public FileMain(String fM_KEYNO, String fM_REGNM) {
		super();
		FM_KEYNO = fM_KEYNO;
		FM_REGNM = fM_REGNM;
	}
	public String getFM_REGDT() {
		return FM_REGDT;
	}
	public void setFM_REGDT(String fM_REGDT) {
		FM_REGDT = fM_REGDT;
	}
	public String getFM_REGNM() {
		return FM_REGNM;
	}
	public void setFM_REGNM(String fM_REGNM) {
		FM_REGNM = fM_REGNM;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getFM_KEYNO() {
		return FM_KEYNO;
	}
	public void setFM_KEYNO(String fM_KEYNO) {
		FM_KEYNO = fM_KEYNO;
	}
	public int getFS_CNT() {
		return FS_CNT;
	}
	public void setFS_CNT(int fS_CNT) {
		FS_CNT = fS_CNT;
	}
	public String getFM_WHERE_KEYS() {
		return FM_WHERE_KEYS;
	}
	public void setFM_WHERE_KEYS(String fM_WHERE_KEYS) {
		FM_WHERE_KEYS = fM_WHERE_KEYS;
	}
	/**
	 * @return
	 * 사용 처 키의 배열을 반환
	 */
	public String[] getArrayFM_WHERE_KEYS(){
		if( FM_WHERE_KEYS == null ){
			return null;
		}else{
			return FM_WHERE_KEYS.split("\\,",-1);
		}
	}
	public String getFM_COMMENTS() {
		return FM_COMMENTS;
	}
	public void setFM_COMMENTS(String fM_COMMENTS) {
		FM_COMMENTS = fM_COMMENTS;
	}
	
}
