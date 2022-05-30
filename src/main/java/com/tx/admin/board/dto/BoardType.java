package com.tx.admin.board.dto;

/**
 * @BoardType
 * 게시판 타입관리를 담당한다.
 * 
 * @author 박혜성
 * @version 1.0
 * @since 2020-02-06
 */ 

public class BoardType {
    
	//고유키 
	private String BT_KEYNO;
	
	//게시판 타입 명칭
	private String BT_TYPE_NAME;
	
	//게시판 유형코드
	private String BT_CODEKEY;
	
	
	//답글 기능 사용여부
	private String BT_REPLY_YN;
	
	//댓글 기능 사용여부
	private String BT_COMMENT_YN;
	
	//비밀글 기능 사용여부
	private String BT_SECRET_YN;
	
	//업로드 기능 사용여부
	private String BT_UPLOAD_YN;
	
	//업로드 파일 수 제한
	private Integer BT_FILE_CNT_LIMIT;
	
	//업로드 파일 크기 제한(MB)
	private Integer BT_FILE_SIZE_LIMIT;
	
	//작성자
	private String BT_REGNM;

	//작성일자
	private String BT_REGDT;
	
	//최근 변경자
	private String BT_MODNM;
	
	//최근 변경일자
	private String BT_MODDT;
	
	//사용여부
	private String BT_USE_YN;
	
	//예약 프로그램 사용여부
	private String BT_EDU_PR_YN;
	
	//티켓예매 프로그램 사용여부
	private String BT_TICKET_PR_YN;
	
	//SNS공유 사용여부
	private String BT_SNS_YN;
	
	//RSS 사용여부
	private String BT_RSS_YN;
	
	//소개HTML사용여부
	private String BT_HTML_YN;
		
	//썸네일 사용여부
	private String BT_THUMBNAIL_YN;
	
	//썸네일 리사이즈 WEIGHT값
	private int BT_THUMBNAIL_WIDTH = 0;
	
	//썸네일 리사이즈 HEIGHT값
	private int BT_THUMBNAIL_HEIGHT = 0;
		
	
	//파일 이미지 WEIGHT값
	private int BT_FILE_IMAGE_WIDTH = 0;
	
	//파일 이미지 HEIGHT값
	private int BT_FILE_IMAGE_HEIGHT = 0;

	//한 페이지당 게시되는 게시물 건 수
	private int BT_PAGEUNIT = 0;
		
	//페이지 리스트에 게시되는 페이지 건수
	private int BT_PAGESIZE = 0;
	
	//삭제된 게시물 리스트에 보여질지 여부
	private String BT_DEL_LISTVIEW_YN;
	
	//삭제된 게시물 리스트에 보여질지 여부
	private String BT_EMAIL_YN;
	
	//삭제된 게시물 리스트에 보여질지 여부
	private String BT_EMAIL_ADDRESS;
	
	//xss 필터 사용여부
	private String BT_XSS_YN;
	
	//Web 에디터 추가여부
	private String BT_HTMLMAKER_PLUS_YN;
	
	//코드네임
	private String SC_CODENM ;
	
	//파일 확장자
	private String BT_FILE_EXT ;
	
	//게시판 넘버링 종류
	private String BT_NUMBERING_TYPE ;
	
	//자기가 쓴글만 보이기 여부
	private String BT_SHOW_MINE_YN ;
	
	//게시물 삭제 정책
	private String BT_DEL_POLICY ;

	
	
	public String getBT_SHOW_MINE_YN() {
		return BT_SHOW_MINE_YN;
	}

	public void setBT_SHOW_MINE_YN(String bT_SHOW_MINE_YN) {
		BT_SHOW_MINE_YN = bT_SHOW_MINE_YN;
	}

	public String getBT_DEL_POLICY() {
		return BT_DEL_POLICY;
	}

	public void setBT_DEL_POLICY(String bT_DEL_POLICY) {
		BT_DEL_POLICY = bT_DEL_POLICY;
	}

	public String getBT_NUMBERING_TYPE() {
		return BT_NUMBERING_TYPE;
	}

	public void setBT_NUMBERING_TYPE(String bT_NUMBERING_TYPE) {
		BT_NUMBERING_TYPE = bT_NUMBERING_TYPE;
	}

	public String getBT_FILE_EXT() {
		return BT_FILE_EXT;
	}

	public void setBT_FILE_EXT(String bT_FILE_EXT) {
		BT_FILE_EXT = bT_FILE_EXT;
	}

	public int getBT_FILE_IMAGE_WIDTH() {
		return BT_FILE_IMAGE_WIDTH;
	}

	public void setBT_FILE_IMAGE_WIDTH(int bT_FILE_IMAGE_WIDTH) {
		BT_FILE_IMAGE_WIDTH = bT_FILE_IMAGE_WIDTH;
	}

	public int getBT_FILE_IMAGE_HEIGHT() {
		return BT_FILE_IMAGE_HEIGHT;
	}

	public void setBT_FILE_IMAGE_HEIGHT(int bT_FILE_IMAGE_HEIGHT) {
		BT_FILE_IMAGE_HEIGHT = bT_FILE_IMAGE_HEIGHT;
	}
	
	public String getBT_HTMLMAKER_PLUS_YN() {
		return BT_HTMLMAKER_PLUS_YN;
	}

	public void setBT_HTMLMAKER_PLUS_YN(String bT_HTMLMAKER_PLUS_YN) {
		BT_HTMLMAKER_PLUS_YN = bT_HTMLMAKER_PLUS_YN;
	}
	
	//삭제된 댓글 보여질지 여부
	private String BT_DEL_COMMENT_YN ;
	
	
	public String getBT_DEL_COMMENT_YN() {
		return BT_DEL_COMMENT_YN;
	}

	public void setBT_DEL_COMMENT_YN(String bT_DEL_COMMENT_YN) {
		BT_DEL_COMMENT_YN = bT_DEL_COMMENT_YN;
	}

	public String getBT_XSS_YN() {
		return BT_XSS_YN;
	}

	public void setBT_XSS_YN(String bT_XSS_YN) {
		BT_XSS_YN = bT_XSS_YN;
	}

	public String getBT_DEL_LISTVIEW_YN() {
		return BT_DEL_LISTVIEW_YN;
	}

	public void setBT_DEL_LISTVIEW_YN(String bT_DEL_LISTVIEW_YN) {
		BT_DEL_LISTVIEW_YN = bT_DEL_LISTVIEW_YN;
	}

	public int getBT_THUMBNAIL_WIDTH() {
		return BT_THUMBNAIL_WIDTH;
	}

	public void setBT_THUMBNAIL_WIDTH(int bT_THUMBNAIL_WIDTH) {
		BT_THUMBNAIL_WIDTH = bT_THUMBNAIL_WIDTH;
	}

	public int getBT_THUMBNAIL_HEIGHT() {
		return BT_THUMBNAIL_HEIGHT;
	}

	public void setBT_THUMBNAIL_HEIGHT(int bT_THUMBNAIL_HEIGHT) {
		BT_THUMBNAIL_HEIGHT = bT_THUMBNAIL_HEIGHT;
	}

	public String getSC_CODENM() {
		return SC_CODENM;
	}

	public void setSC_CODENM(String sC_CODENM) {
		SC_CODENM = sC_CODENM;
	}

	public String getBT_EDU_PR_YN() {
		return BT_EDU_PR_YN;
	}

	public void setBT_EDU_PR_YN(String bT_EDU_PR_YN) {
		BT_EDU_PR_YN = bT_EDU_PR_YN;
	}

	public String getBT_TICKET_PR_YN() {
		return BT_TICKET_PR_YN;
	}

	public void setBT_TICKET_PR_YN(String bT_TICKET_PR_YN) {
		BT_TICKET_PR_YN = bT_TICKET_PR_YN;
	}

	public String getBT_SNS_YN() {
		return BT_SNS_YN;
	}

	public void setBT_SNS_YN(String bT_SNS_YN) {
		BT_SNS_YN = bT_SNS_YN;
	}

	public String getBT_RSS_YN() {
		return BT_RSS_YN;
	}

	public void setBT_RSS_YN(String bT_RSS_YN) {
		BT_RSS_YN = bT_RSS_YN;
	}

	public String getBT_REPLY_YN() {
		return BT_REPLY_YN;
	}

	public void setBT_REPLY_YN(String bT_REPLY_YN) {
		BT_REPLY_YN = bT_REPLY_YN;
	}

	public String getBT_REGNM() {
		return BT_REGNM;
	}

	public void setBT_REGNM(String bT_REGNM) {
		BT_REGNM = bT_REGNM;
	}

	public String getBT_REGDT() {
		return BT_REGDT;
	}

	public void setBT_REGDT(String bT_REGDT) {
		BT_REGDT = bT_REGDT;
	}

	public String getBT_MODNM() {
		return BT_MODNM;
	}

	public void setBT_MODNM(String bT_MODNM) {
		BT_MODNM = bT_MODNM;
	}

	public String getBT_MODDT() {
		return BT_MODDT;
	}

	public void setBT_MODDT(String bT_MODDT) {
		BT_MODDT = bT_MODDT;
	}

	public String getBT_USE_YN() {
		return BT_USE_YN;
	}

	public void setBT_USE_YN(String bT_USE_YN) {
		BT_USE_YN = bT_USE_YN;
	}

	public String getBT_KEYNO() {
		return BT_KEYNO;
	}

	public void setBT_KEYNO(String bT_KEYNO) {
		BT_KEYNO = bT_KEYNO;
	}

	public String getBT_TYPE_NAME() {
		return BT_TYPE_NAME;
	}

	public void setBT_TYPE_NAME(String bT_TYPE_NAME) {
		BT_TYPE_NAME = bT_TYPE_NAME;
	}


	public String getBT_CODEKEY() {
		return BT_CODEKEY;
	}

	public void setBT_CODEKEY(String bT_CODEKEY) {
		BT_CODEKEY = bT_CODEKEY;
	}


	public String getBT_COMMENT_YN() {
		return BT_COMMENT_YN;
	}

	public void setBT_COMMENT_YN(String bT_COMMENT_YN) {
		BT_COMMENT_YN = bT_COMMENT_YN;
	}

	public String getBT_SECRET_YN() {
		return BT_SECRET_YN;
	}

	public void setBT_SECRET_YN(String bT_SECRET_YN) {
		BT_SECRET_YN = bT_SECRET_YN;
	}

	public String getBT_UPLOAD_YN() {
		return BT_UPLOAD_YN;
	}

	public void setBT_UPLOAD_YN(String bT_UPLOAD_YN) {
		BT_UPLOAD_YN = bT_UPLOAD_YN;
	}

	public Integer getBT_FILE_CNT_LIMIT() {
		return BT_FILE_CNT_LIMIT;
	}

	public void setBT_FILE_CNT_LIMIT(Integer bT_FILE_CNT_LIMIT) {
		BT_FILE_CNT_LIMIT = bT_FILE_CNT_LIMIT;
	}

	public Integer getBT_FILE_SIZE_LIMIT() {
		return BT_FILE_SIZE_LIMIT;
	}

	public void setBT_FILE_SIZE_LIMIT(Integer bT_FILE_SIZE_LIMIT) {
		BT_FILE_SIZE_LIMIT = bT_FILE_SIZE_LIMIT;
	}

	public String getBT_HTML_YN() {
		return BT_HTML_YN;
	}

	public void setBT_HTML_YN(String bT_HTML_YN) {
		BT_HTML_YN = bT_HTML_YN;
	}

	public String getBT_THUMBNAIL_YN() {
		return BT_THUMBNAIL_YN;
	}

	public void setBT_THUMBNAIL_YN(String bT_THUMBNAIL_YN) {
		BT_THUMBNAIL_YN = bT_THUMBNAIL_YN;
	}

	public int getBT_PAGEUNIT() {
		return BT_PAGEUNIT;
	}

	public void setBT_PAGEUNIT(int bT_PAGEUNIT) {
		BT_PAGEUNIT = bT_PAGEUNIT;
	}

	public int getBT_PAGESIZE() {
		return BT_PAGESIZE;
	}

	public void setBT_PAGESIZE(int bT_PAGESIZE) {
		BT_PAGESIZE = bT_PAGESIZE;
	}

	public String getBT_EMAIL_YN() {
		return BT_EMAIL_YN;
	}

	public void setBT_EMAIL_YN(String bT_EMAIL_YN) {
		BT_EMAIL_YN = bT_EMAIL_YN;
	}

	public String getBT_EMAIL_ADDRESS() {
		return BT_EMAIL_ADDRESS;
	}

	public void setBT_EMAIL_ADDRESS(String bT_EMAIL_ADDRESS) {
		BT_EMAIL_ADDRESS = bT_EMAIL_ADDRESS;
	}

	
	
	
	
}
