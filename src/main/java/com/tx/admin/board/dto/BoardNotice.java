package com.tx.admin.board.dto;

import com.tx.common.dto.Common;

/**
 * @BoardNotice
 * 게시물관리를 담당한다.
 * 
 * @author 박혜성
 * @version 1.0
 * @since 2020-02-06
 */ 

public class BoardNotice extends Common{
    
	/**
	 * 
	 */
	private static final long serialVersionUID = -8112511555121078311L;

	//고유키 
	private String BN_KEYNO;
	
	//메뉴키 
	private String BN_MN_KEYNO;
	
	//메뉴키2 
	private String BN_MN_KEYNO2;
	
	//파일키 
	private String BN_FM_KEYNO;
	
	//제목 
	private String BN_TITLE;
	
	//내용 
	private String BN_CONTENTS;
	
	//작성자 
	private String BN_REGNM;
	
	//작성일 
	private String BN_REGDT;
	
	//수정자 
	private String BN_MODNM;
	
	//수정일 
	private String BN_MODDT;
	
	//사용여부 
	private String BN_USE_YN;
	
	//비밀글여부 
	private String BN_SECRET_YN;
	
	//섬네일 
	private String BN_THUMBNAIL;
	
	//조회수 
	private int BN_HITS;
	
	//썸네일 경로
	private String THUMBNAIL_PATH;
	
	//썸네일 경로
	private String THUMBNAIL_ORINM;
	
	//공지여부
	private String BN_IMPORTANT;
	
	//공지종료일
	private String BN_IMPORTANT_DATE;
	
	private String BN_MAINKEY ="";
	private String BN_PARENTKEY ="";
	private int BN_SEQ = 0;
	private int BN_DEPTH =0;
	
	//새글 여부
	private String BN_NEW = "";
	
	//댓글 수
	private int BN_BC_COUNT = 0;
	
	//답글 여부
	private String BT_REPLY_YN = "";
	
	//삭제된 게시물 리스트에 보여질지 여부
	private String BT_DEL_LISTVIEW_YN = "";
	
	//링크 존재 여부 
	private int BN_LINK = 0;
	
	
	//공지
	private String BOARD_TYPE;
	
	//고유키
	private String BNH_KEYNO;
	
	//고유키 
	private String BNH_BN_KEYNO;
	
	//메뉴키 
	private String BNH_BN_MN_KEYNO;
	
	//파일키 
	private String BNH_BN_FM_KEYNO;
	
	//제목 
	private String BNH_BN_TITLE;
	
	//내용 
	private String BNH_BN_CONTENTS;
	
	//작성자 
	private String BNH_BN_REGNM;
	
	//작성일 
	private String BNH_BN_REGDT;
	
	//비회원 비밀번호
	private String BN_PWD;
	
	//수정자 
	private String BNH_BN_MODNM;
	
	//수정일 
	private String BNH_BN_MODDT;
	
	//사용여부 
	private String BNH_BN_USE_YN;
	
	//비밀글여부 
	private String BNH_BN_SECRET_YN;
	
	//섬네일 
	private String BNH_BN_THUMBNAIL;
	
	//조회수 
	private int BNH_BN_HITS;
	
	//공지여부
	private String BNH_BN_IMPORTANT;
	
	//공지종료일
	private String BNH_BN_IMPORTANT_DATE;
	
	private String BN_COMPARE;
	
	private String BN_UI_NAME;
	
	private String BN_MOD_UI_NAME;
	
	private int BOARD_NUMBER;
	
	//삭제여부
	//사용여부(BN_USE_YN)과는 다른개념 사용여부는 콘텐츠 요청관리에서 최종승인이 떨어지면 Y, 사용자 리스트에서 쿼리 검색시에는 사용여부Y, 삭제여부N
	private String BN_DEL_YN;
	
	private String BN_GONGNULI_TYPE;
	
	//마이그레이션 파라미터
	private String migration_bo_table ;
	private String migration_wr_num;
	
	//재단발간물 이미지 경로
	private String IMG_PATH;
	

    //답글에서 사용할 게시글 작성자
    private String WRITE_ID;

	//게시판 이동 사유
	private String BN_MOVE_MEMO;
    
	//순차
	private String upanddown;
	
	private String BN_HIRE_KEY;
	
	
    public String getBN_HIRE_KEY() {
		return BN_HIRE_KEY;
	}

	public void setBN_HIRE_KEY(String bN_HIRE_KEY) {
		BN_HIRE_KEY = bN_HIRE_KEY;
	}

	public String getUpanddown() {
		return upanddown;
	}

	public void setUpanddown(String upanddown) {
		this.upanddown = upanddown;
	}

	public String getWRITE_ID() {
        return WRITE_ID;
    }

    public void setWRITE_ID(String wRITE_ID) {
        WRITE_ID = wRITE_ID;
    }
	
	public String getBN_GONGNULI_TYPE() {
		return BN_GONGNULI_TYPE;
	}

	public void setBN_GONGNULI_TYPE(String bN_GONGNULI_TYPE) {
		BN_GONGNULI_TYPE = bN_GONGNULI_TYPE;
	}
	
	public String getIMG_PATH() {
		return IMG_PATH;
	}

	public void setIMG_PATH(String iMG_PATH) {
		IMG_PATH = iMG_PATH;
	}

	public String getBT_DEL_LISTVIEW_YN() {
		return BT_DEL_LISTVIEW_YN;
	}

	public void setBT_DEL_LISTVIEW_YN(String bT_DEL_LISTVIEW_YN) {
		BT_DEL_LISTVIEW_YN = bT_DEL_LISTVIEW_YN;
	}

	public String getMigration_bo_table() {
		return migration_bo_table;
	}

	public void setMigration_bo_table(String migration_bo_table) {
		this.migration_bo_table = migration_bo_table;
	}

	public String getMigration_wr_num() {
		return migration_wr_num;
	}

	public void setMigration_wr_num(String migration_wr_num) {
		this.migration_wr_num = migration_wr_num;
	}

	public String getBN_PARENTKEY() {
		return BN_PARENTKEY;
	}

	public void setBN_PARENTKEY(String bN_PARENTKEY) {
		BN_PARENTKEY = bN_PARENTKEY;
	}

	public String getBT_REPLY_YN() {
		return BT_REPLY_YN;
	}

	public void setBT_REPLY_YN(String bT_REPLY_YN) {
		BT_REPLY_YN = bT_REPLY_YN;
	}

	public int getBN_BC_COUNT() {
		return BN_BC_COUNT;
	}

	public void setBN_BC_COUNT(int bN_BC_COUNT) {
		BN_BC_COUNT = bN_BC_COUNT;
	}

	public String getBN_NEW() {
		return BN_NEW;
	}

	public void setBN_NEW(String bN_NEW) {
		BN_NEW = bN_NEW;
	}

	public String getBN_MAINKEY() {
		return BN_MAINKEY;
	}

	public void setBN_MAINKEY(String bN_MAINKEY) {
		BN_MAINKEY = bN_MAINKEY;
	}

	public int getBN_SEQ() {
		return BN_SEQ;
	}

	public void setBN_SEQ(int bN_SEQ) {
		BN_SEQ = bN_SEQ;
	}

	public int getBN_DEPTH() {
		return BN_DEPTH;
	}

	public void setBN_DEPTH(int bN_DEPTH) {
		BN_DEPTH = bN_DEPTH;
	}

	public String getBOARD_TYPE() {
		return BOARD_TYPE;
	}

	public void setBOARD_TYPE(String bOARD_TYPE) {
		BOARD_TYPE = bOARD_TYPE;
	}

	public String getBN_PWD() {
		return BN_PWD;
	}

	public void setBN_PWD(String bN_PWD) {
		BN_PWD = bN_PWD;
	}

	public int getBOARD_NUMBER() {
		return BOARD_NUMBER;
	}

	public void setBOARD_NUMBER(int bOARD_NUMBER) {
		BOARD_NUMBER = bOARD_NUMBER;
	}

	public String getBN_MOD_UI_NAME() {
		return BN_MOD_UI_NAME;
	}

	public void setBN_MOD_UI_NAME(String bN_MOD_UI_NAME) {
		BN_MOD_UI_NAME = bN_MOD_UI_NAME;
	}

	public String getBN_UI_NAME() {
		return BN_UI_NAME;
	}

	public void setBN_UI_NAME(String bN_UI_NAME) {
		BN_UI_NAME = bN_UI_NAME;
	}

	public String getTHUMBNAIL_ORINM() {
		return THUMBNAIL_ORINM;
	}

	public void setTHUMBNAIL_ORINM(String tHUMBNAIL_ORINM) {
		THUMBNAIL_ORINM = tHUMBNAIL_ORINM;
	}

	public String getTHUMBNAIL_PATH() {
		return THUMBNAIL_PATH;
	}

	public void setTHUMBNAIL_PATH(String tHUMBNAIL_PATH) {
		THUMBNAIL_PATH = tHUMBNAIL_PATH;
	}

	public String getBN_KEYNO() {
		return BN_KEYNO;
	}

	public void setBN_KEYNO(String bN_KEYNO) {
		BN_KEYNO = bN_KEYNO;
	}

	public String getBN_MN_KEYNO() {
		return BN_MN_KEYNO;
	}

	public void setBN_MN_KEYNO(String bN_MN_KEYNO) {
		BN_MN_KEYNO = bN_MN_KEYNO;
	}

	public String getBN_FM_KEYNO() {
		return BN_FM_KEYNO;
	}

	public void setBN_FM_KEYNO(String bN_FM_KEYNO) {
		BN_FM_KEYNO = bN_FM_KEYNO;
	}

	public String getBN_TITLE() {
		return BN_TITLE;
	}

	public void setBN_TITLE(String bN_TITLE) {
		BN_TITLE = bN_TITLE;
	}

	public String getBN_CONTENTS() {
		return BN_CONTENTS;
	}

	public void setBN_CONTENTS(String bN_CONTENTS) {
		BN_CONTENTS = bN_CONTENTS;
	}

	public String getBN_REGNM() {
		return BN_REGNM;
	}

	public void setBN_REGNM(String bN_REGNM) {
		BN_REGNM = bN_REGNM;
	}

	public String getBN_REGDT() {
		return BN_REGDT;
	}

	public void setBN_REGDT(String bN_REGDT) {
		BN_REGDT = bN_REGDT;
	}

	public String getBN_MODNM() {
		return BN_MODNM;
	}

	public void setBN_MODNM(String bN_MODNM) {
		BN_MODNM = bN_MODNM;
	}

	public String getBN_MODDT() {
		return BN_MODDT;
	}

	public void setBN_MODDT(String bN_MODDT) {
		BN_MODDT = bN_MODDT;
	}

	public String getBN_USE_YN() {
		return BN_USE_YN;
	}

	public void setBN_USE_YN(String bN_USE_YN) {
		BN_USE_YN = bN_USE_YN;
	}

	public String getBN_SECRET_YN() {
		return BN_SECRET_YN;
	}

	public void setBN_SECRET_YN(String bN_SECRET_YN) {
		BN_SECRET_YN = bN_SECRET_YN;
	}

	public String getBN_THUMBNAIL() {
		return BN_THUMBNAIL;
	}

	public void setBN_THUMBNAIL(String bN_THUMBNAIL) {
		BN_THUMBNAIL = bN_THUMBNAIL;
	}

	public int getBN_HITS() {
		return BN_HITS;
	}

	public void setBN_HITS(int bN_HITS) {
		BN_HITS = bN_HITS;
	}

	public String getBN_IMPORTANT() {
		return BN_IMPORTANT;
	}

	public void setBN_IMPORTANT(String bN_IMPORTANT) {
		BN_IMPORTANT = bN_IMPORTANT;
	}

	public String getBN_IMPORTANT_DATE() {
		return BN_IMPORTANT_DATE;
	}

	public void setBN_IMPORTANT_DATE(String bN_IMPORTANT_DATE) {
		BN_IMPORTANT_DATE = bN_IMPORTANT_DATE;
	}

	public String getBNH_KEYNO() {
		return BNH_KEYNO;
	}

	public void setBNH_KEYNO(String bNH_KEYNO) {
		BNH_KEYNO = bNH_KEYNO;
	}

	public String getBNH_BN_KEYNO() {
		return BNH_BN_KEYNO;
	}

	public void setBNH_BN_KEYNO(String bNH_BN_KEYNO) {
		BNH_BN_KEYNO = bNH_BN_KEYNO;
	}

	public String getBNH_BN_MN_KEYNO() {
		return BNH_BN_MN_KEYNO;
	}

	public void setBNH_BN_MN_KEYNO(String bNH_BN_MN_KEYNO) {
		BNH_BN_MN_KEYNO = bNH_BN_MN_KEYNO;
	}

	public String getBNH_BN_FM_KEYNO() {
		return BNH_BN_FM_KEYNO;
	}

	public void setBNH_BN_FM_KEYNO(String bNH_BN_FM_KEYNO) {
		BNH_BN_FM_KEYNO = bNH_BN_FM_KEYNO;
	}

	public String getBNH_BN_TITLE() {
		return BNH_BN_TITLE;
	}

	public void setBNH_BN_TITLE(String bNH_BN_TITLE) {
		BNH_BN_TITLE = bNH_BN_TITLE;
	}

	public String getBNH_BN_CONTENTS() {
		return BNH_BN_CONTENTS;
	}

	public void setBNH_BN_CONTENTS(String bNH_BN_CONTENTS) {
		BNH_BN_CONTENTS = bNH_BN_CONTENTS;
	}

	public String getBNH_BN_REGNM() {
		return BNH_BN_REGNM;
	}

	public void setBNH_BN_REGNM(String bNH_BN_REGNM) {
		BNH_BN_REGNM = bNH_BN_REGNM;
	}

	public String getBNH_BN_REGDT() {
		return BNH_BN_REGDT;
	}

	public void setBNH_BN_REGDT(String bNH_BN_REGDT) {
		BNH_BN_REGDT = bNH_BN_REGDT;
	}

	public String getBNH_BN_MODNM() {
		return BNH_BN_MODNM;
	}

	public void setBNH_BN_MODNM(String bNH_BN_MODNM) {
		BNH_BN_MODNM = bNH_BN_MODNM;
	}

	public String getBNH_BN_MODDT() {
		return BNH_BN_MODDT;
	}

	public void setBNH_BN_MODDT(String bNH_BN_MODDT) {
		BNH_BN_MODDT = bNH_BN_MODDT;
	}

	public String getBNH_BN_USE_YN() {
		return BNH_BN_USE_YN;
	}

	public void setBNH_BN_USE_YN(String bNH_BN_USE_YN) {
		BNH_BN_USE_YN = bNH_BN_USE_YN;
	}

	public String getBNH_BN_SECRET_YN() {
		return BNH_BN_SECRET_YN;
	}

	public void setBNH_BN_SECRET_YN(String bNH_BN_SECRET_YN) {
		BNH_BN_SECRET_YN = bNH_BN_SECRET_YN;
	}

	public String getBNH_BN_THUMBNAIL() {
		return BNH_BN_THUMBNAIL;
	}

	public void setBNH_BN_THUMBNAIL(String bNH_BN_THUMBNAIL) {
		BNH_BN_THUMBNAIL = bNH_BN_THUMBNAIL;
	}

	public int getBNH_BN_HITS() {
		return BNH_BN_HITS;
	}

	public void setBNH_BN_HITS(int bNH_BN_HITS) {
		BNH_BN_HITS = bNH_BN_HITS;
	}

	public String getBNH_BN_IMPORTANT() {
		return BNH_BN_IMPORTANT;
	}

	public void setBNH_BN_IMPORTANT(String bNH_BN_IMPORTANT) {
		BNH_BN_IMPORTANT = bNH_BN_IMPORTANT;
	}

	public String getBNH_BN_IMPORTANT_DATE() {
		return BNH_BN_IMPORTANT_DATE;
	}

	public void setBNH_BN_IMPORTANT_DATE(String bNH_BN_IMPORTANT_DATE) {
		BNH_BN_IMPORTANT_DATE = bNH_BN_IMPORTANT_DATE;
	}

	public String getBN_COMPARE() {
		return BN_COMPARE;
	}

	public void setBN_COMPARE(String bN_COMPARE) {
		BN_COMPARE = bN_COMPARE;
	}

	public String getBN_DEL_YN() {
		return BN_DEL_YN;
	}

	public void setBN_DEL_YN(String bN_DEL_YN) {
		BN_DEL_YN = bN_DEL_YN;
	}

	public int getBN_LINK() {
		return BN_LINK;
	}

	public void setBN_LINK(int bN_LINK) {
		BN_LINK = bN_LINK;
	}

	public String getBN_MOVE_MEMO() {
		return BN_MOVE_MEMO;
	}

	public void setBN_MOVE_MEMO(String bN_MOVE_MEMO) {
		BN_MOVE_MEMO = bN_MOVE_MEMO;
	}

	public String getBN_MN_KEYNO2() {
		return BN_MN_KEYNO2;
	}

	public void setBN_MN_KEYNO2(String bN_MN_KEYNO2) {
		BN_MN_KEYNO2 = bN_MN_KEYNO2;
	}

	

	
	
	
}