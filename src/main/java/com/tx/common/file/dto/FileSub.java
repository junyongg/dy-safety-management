package com.tx.common.file.dto;

import java.io.Serializable;
import java.util.List;

/**
 * @FileSub 공통기능의 하위 파일정보내용을 관리 하는 빈즈
 * @author 신희원
 * @version 1.0
 * @since 2014-11-12
 */
public class FileSub extends FileMain implements Serializable {

	private static final long serialVersionUID = -1493426419078958857L;

	// 고유키
	private String FS_KEYNO = null;

	// 상위 그룹키
	private String FS_FM_KEYNO = null;

	// 파일크기
	private String FS_FILE_SIZE = null;

	// 원본파일명칭
	private String FS_ORINM = null;

	// 코드화 완료된 파일명칭
	private String FS_CHANGENM = null;

	// 확장자
	private String FS_EXT = null;

	// 저장위치 절대경로
	private String FS_FOLDER = null;

	// 다운로드 횟수
	private Integer FS_DOWNCNT = null;

	// 파일키 배열 정보
	private List<String> GroupFS_KeyArray = null;

	// 모바일 리사이즈 이미지 키
	private String FS_M_KEYNO = null;

	// 등록일
	private String FS_REGDT = null;

	// 등록자
	private String FS_REGNM = null;

	// 경로
	private String FS_PATH = null;

	// 썸네일 이름
	private String FS_THUMBNAIL = null;

	// 파일 주석
	private String FS_ALT = null;

	// 파일 설명
	private String FS_COMMENTS = null;
	
	// 정렬순서
	private Integer FS_ORDER = null;

	// 원본이미지 가로픽셀
	private int FS_ORIWIDTH = 0;

	// 원본이미지 세로픽셀
	private int FS_ORIHEIGHT = 0;

	/* Image 파일 하위 속성 */
	// 업로드 이미지 리사이즈 속성
	private boolean IS_RESIZE = false;
	private int RESIZE_WIDTH = 0;
	private int RESIZE_HEIGHT = 0;

	// 업로드 이미지의 썸네일 속성 - 썸네일 생성 이미지가 FileSub로 관리되어 지지 않기에 사용함.
	private boolean IS_MAKE_THUMBNAIL = false;
	private int THUMB_WIDTH = 0;
	private int THUMB_HEIGHT = 0;

	public FileSub() {
		super();
	}

	/**
	 * @param fS_KEYNO
	 * @param fS_FM_KEYNO
	 *          PK 주입용 생성자
	 */
	public FileSub(String fS_FM_KEYNO, String fS_KEYNO) {
		super();
		FS_FM_KEYNO = fS_FM_KEYNO;
		FS_KEYNO = fS_KEYNO;
	}

	public String getFS_THUMBNAIL() {
		return FS_THUMBNAIL;
	}

	public void setFS_THUMBNAIL(String fS_THUMBNAIL) {
		FS_THUMBNAIL = fS_THUMBNAIL;
	}

	public String getFS_PATH() {
		return FS_PATH;
	}

	public void setFS_PATH(String fS_PATH) {
		FS_PATH = fS_PATH;
	}

	public String getFS_REGDT() {
		return FS_REGDT;
	}

	public void setFS_REGDT(String fS_REGDT) {
		FS_REGDT = fS_REGDT;
	}

	public String getFS_REGNM() {
		return FS_REGNM;
	}

	public void setFS_REGNM(String fS_REGNM) {
		FS_REGNM = fS_REGNM;
	}

	public String getFS_M_KEYNO() {
		return FS_M_KEYNO;
	}

	public void setFS_M_KEYNO(String fS_M_KEYNO) {
		FS_M_KEYNO = fS_M_KEYNO;
	}

	public String getFS_KEYNO() {
		return FS_KEYNO;
	}

	public void setFS_KEYNO(String fS_KEYNO) {
		FS_KEYNO = fS_KEYNO;
	}

	public String getFS_FM_KEYNO() {
		return FS_FM_KEYNO;
	}

	public void setFS_FM_KEYNO(String fS_FM_KEYNO) {
		FS_FM_KEYNO = fS_FM_KEYNO;
	}

	public String getFS_FILE_SIZE() {
		return FS_FILE_SIZE;
	}

	public void setFS_FILE_SIZE(String fS_FILE_SIZE) {
		FS_FILE_SIZE = fS_FILE_SIZE;
	}

	public String getFS_ORINM() {
		return FS_ORINM;
	}

	public void setFS_ORINM(String fS_ORINM) {
		FS_ORINM = fS_ORINM;
	}

	public String getFS_CHANGENM() {
		return FS_CHANGENM;
	}

	public void setFS_CHANGENM(String fS_CHANGENM) {
		FS_CHANGENM = fS_CHANGENM;
	}

	public String getFS_EXT() {
		return FS_EXT;
	}

	public void setFS_EXT(String fS_EXT) {
		FS_EXT = fS_EXT;
	}

	public String getFS_FOLDER() {
		return FS_FOLDER;
	}

	public void setFS_FOLDER(String fS_FOLDER) {
		FS_FOLDER = fS_FOLDER;
	}

	public Integer getFS_DOWNCNT() {
		return FS_DOWNCNT;
	}

	public void setFS_DOWNCNT(Integer fS_DOWNCNT) {
		FS_DOWNCNT = fS_DOWNCNT;
	}

	public List<String> getGroupFS_KeyArray() {
		return GroupFS_KeyArray;
	}

	public void setGroupFS_KeyArray(List<String> groupFS_KeyArray) {
		GroupFS_KeyArray = groupFS_KeyArray;
	}

	public String getFS_ALT() {
		return FS_ALT;
	}

	public void setFS_ALT(String fS_ALT) {
		FS_ALT = fS_ALT;
	}

	public String getFS_COMMENTS() {
		return FS_COMMENTS;
	}

	public void setFS_COMMENTS(String fS_COMMENTS) {
		FS_COMMENTS = fS_COMMENTS;
	}

	public int getFS_ORIWIDTH() {
		return FS_ORIWIDTH;
	}

	public void setFS_ORIWIDTH(int fS_ORIWIDTH) {
		FS_ORIWIDTH = fS_ORIWIDTH;
	}

	public int getFS_ORIHEIGHT() {
		return FS_ORIHEIGHT;
	}

	public void setFS_ORIHEIGHT(int fS_ORIHEIGHT) {
		FS_ORIHEIGHT = fS_ORIHEIGHT;
	}

	public FileSub IS_RESIZE() {
		this.IS_RESIZE = true;
		return this;
	}

	public FileSub RESIZE_WIDTH(int RESIZE_WIDTH) {
		this.RESIZE_WIDTH = RESIZE_WIDTH;
		return this;
	}

	public FileSub RESIZE_HEIGHT(int RESIZE_HEIGHT) {
		this.RESIZE_HEIGHT = RESIZE_HEIGHT;
		return this;
	}

	public FileSub IS_MAKE_THUMBNAIL() {
		this.IS_MAKE_THUMBNAIL = true;
		return this;
	}

	public FileSub THUMB_WIDTH(int THUMB_WIDTH) {
		this.THUMB_WIDTH = THUMB_WIDTH;
		return this;
	}

	public FileSub THUMB_HEIGHT(int THUMB_HEIGHT) {
		this.THUMB_HEIGHT = THUMB_HEIGHT;
		return this;
	}

	public void setIS_RESIZE(boolean iS_RESIZE) {
		IS_RESIZE = iS_RESIZE;
	}

	public void setIS_MAKE_THUMBNAIL(boolean iS_MAKE_THUMBNAIL) {
		IS_MAKE_THUMBNAIL = iS_MAKE_THUMBNAIL;
	}

	public boolean getIS_RESIZE() {
		return IS_RESIZE;
	}

	public int getRESIZE_WIDTH() {
		return RESIZE_WIDTH;
	}

	public int getRESIZE_HEIGHT() {
		return RESIZE_HEIGHT;
	}

	public boolean getIS_MAKE_THUMBNAIL() {
		return IS_MAKE_THUMBNAIL;
	}

	public int getTHUMB_WIDTH() {
		return THUMB_WIDTH;
	}

	public int getTHUMB_HEIGHT() {
		return THUMB_HEIGHT;
	}

	public void setRESIZE_WIDTH(int rESIZE_WIDTH) {
		RESIZE_WIDTH = rESIZE_WIDTH;
	}

	public void setRESIZE_HEIGHT(int rESIZE_HEIGHT) {
		RESIZE_HEIGHT = rESIZE_HEIGHT;
	}

	public void setTHUMB_WIDTH(int tHUMB_WIDTH) {
		THUMB_WIDTH = tHUMB_WIDTH;
	}

	public void setTHUMB_HEIGHT(int tHUMB_HEIGHT) {
		THUMB_HEIGHT = tHUMB_HEIGHT;
	}

	public Integer getFS_ORDER() {
		return FS_ORDER;
	}

	public void setFS_ORDER(Integer fS_ORDER) {
		FS_ORDER = fS_ORDER;
	}
	
	
	

}
