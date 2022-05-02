package com.tx.admin.homepage.menu.dto;

import java.io.Serializable;

import com.tx.common.dto.Common;


/**
 * @menu_manager
 * 페이징 처리를 담당한다.
 * PaginationInfo 클래스에 갱신하기위해
 * 페이지 처리를 원하는 페이지의 현재 페이지 번호와 전체 데이터 개수를 조회하는 쿼리문을 파라미터 값으로 받는다.
 * @author 신희원
 * @version 1.0
 * @since 2014-11-14
 */
public class Menu extends Common implements Serializable, Cloneable{
	private static final long serialVersionUID = -5033459715510358235L;
	
	//메뉴관리 고유키
	private String  MN_KEYNO = "";
	
	//메뉴명
	private String  MN_NAME = "";
	
	//메뉴 홈페이지 구분
	private String  MN_HOMEDIV_C = "";
	
	//메뉴 홈페이지 구분 2
	private String  MN_HOMEDIV_C2 = "";
	
	//메뉴 페이지 형태
	private String  MN_PAGEDIV_C = "";
	
	//메뉴 페이지 형태
	private String  MN_PAGEDIV_NAME = "";
	
	//메뉴 URL
	private String  MN_beforeURL = "";
		
	//메뉴 URL
	private String  MN_URL = "";
	
	//메뉴 URL
	private String  MN_FORWARD_URL = "";
	
	//대메뉴 키
	private String  MN_MAINKEY = "";
	
	//상위 모든 키
	private String  MN_MAINKEYS = "";
	
	//상위 모든 키의 이름
	private String  MN_MAINNAMES = "";
		
	//대메뉴명
	private String  HIGH_MN_NAME = "";
		
	//메뉴 정렬 순서 (메뉴 구분으로 정렬순서를 갱신한다 대메뉴는 대메뉴 끼리의 순서, 소메뉴는 대메뉴 안에서의 소메뉴 끼리의 순서 적용 이는 홈페이지별 다름)
	private Integer MN_ORDER = null;
	private Integer MN_ORDER_BEFORE = null;
	//메뉴 레벨
	private Integer MN_LEV = null;
	
	//메뉴 활성화여부
	private String  MN_USE_YN = "";
	
	//메뉴 등록일
	private String  MN_REGDATE = "";
	
	//메뉴 등록일
	private String  MN_REGDT = "";
	
	//메뉴 최근수정일
	private String  MN_MODDATE = "";
	
	//메뉴 최근수정일
	private String  MN_MODDT = "";
	
	//메뉴 등록자
	private String  MN_REGNM = "";
	
	//메뉴 최근 변경자
	private String  MN_MODNM = "";
	
	//메뉴 보이기/감추기
	private String MN_SHOW_YN = "";	
	
	//메뉴 삭제 일자
	private String MN_DELDT = "";
	
	//메뉴 삭제 여부
	private String MN_DEL_YN = "";
	
	//현재 메뉴 여부
	private String checked_menu = "";
	
	//게시판타입키
	private String MN_BT_KEYNO = "";
	
	//권한 적용
	private String MN_AUTHORITY = "";

	//권한 적용 관련 key
	private String MN_AUTHORITY_KEY = "";
		
	//CSS 아이콘 정보 - font-awesome
	private String MN_ICON_CSS = "";

	//아이콘 이미지 정보 - 마우스 오버/아웃 등에 사용할 이미지
	private String MN_ICON_URL1 = "";
	private String MN_ICON_URL2 = "";
	
	private String BTCODEKEY = "";
	private String MVD_KEYNO = "";
	
	private String MVD_DEL_YN = "";
	//영어이름
	private String MN_ENG_NAME = "";
	//담당부서
	private String MN_DEP = "";
	
	//메뉴 컬러
	private String MN_COLOR = "";
	
	//메뉴 기타 컬럼 1
	private String MN_DATA1 = "";
	
	//메뉴 기타 컬럼 2
	private String MN_DATA2 = "";
	
	//메뉴 기타 컬럼 3
	private String MN_DATA3 = "";
	
	//공공누리
	private String MN_GONGNULI_TYPE = "";
	private String MN_GONGNULI_YN = "";
	
	//관광 고유키
	private String MN_TOURKEY = "";
	
	//관광 고유키
	private String MN_TOUR_CATEGORY = "";
	
	private String MN_ROLES = "";
	
	private String MN_ROLES_MAIN = "";
	
	
	public String getMN_ROLES_MAIN() {
		return MN_ROLES_MAIN;
	}

	public void setMN_ROLES_MAIN(String mN_ROLES_MAIN) {
		MN_ROLES_MAIN = mN_ROLES_MAIN;
	}

	public String getMN_ROLES() {
		return MN_ROLES;
	}

	public void setMN_ROLES(String mN_ROLES) {
		MN_ROLES = mN_ROLES;
	}

	public String getMVD_DEL_YN() {
		return MVD_DEL_YN;
	}

	public void setMVD_DEL_YN(String mVD_DEL_YN) {
		MVD_DEL_YN = mVD_DEL_YN;
	}

	//페이지 평가 사용여부
	private String MN_RESEARCH = "";
	
	//페이지평가 - 큐알코드 사용여부
	private String MN_QRCODE = "";
	
	//페이지 평가 - 콘텐츠 담당자
	private String MN_MANAGER = "";
	
	private String MN_MANAGER_DEP = "";
	
	private String MN_MANAGER_TEL = "";
	
	//페이지 평가 - 큐알코드 이미지
	private String MN_QR_KEYNO = "";
	
	//페이지 평가 - 큐알코드 이미지 경로
	private String IMG_PATH = "";
	
	private String MN_MAIN_DATA1 = "";
	
	private Integer MN_SIBLING_CNT = 0;
	
	private Integer MN_CHILD_CNT = 0;
	
	private String POPUP_DIV = "";
	
	private String MN_DU_KEYNO = "";
	
	private String PAGE_HOMEDIV_C, PAGE_KEYNO, PAGE_NAME, PAGE_TEL, PAGE_DEPARTMENT;
	//xml 히스톨
	private String 	 XH_KEYNO
					,XH_MN_KEYNO
					,XH_FS_KEYNO
					,XH_REGDT
					,XH_DELYN = "";
	
	private String upanddown;
	

	public String getMN_HOMEDIV_C2() {
		return MN_HOMEDIV_C2;
	}

	public void setMN_HOMEDIV_C2(String mN_HOMEDIV_C2) {
		MN_HOMEDIV_C2 = mN_HOMEDIV_C2;
	}

	public String getUpanddown() {
		return upanddown;
	}

	public void setUpanddown(String upanddown) {
		this.upanddown = upanddown;
	}

	public Integer getMN_SIBLING_CNT() {
		return MN_SIBLING_CNT;
	}

	public void setMN_SIBLING_CNT(Integer mN_SIBLING_CNT) {
		MN_SIBLING_CNT = mN_SIBLING_CNT;
	}

	public String getMN_GONGNULI_TYPE() {
		return MN_GONGNULI_TYPE;
	}

	public void setMN_GONGNULI_TYPE(String mN_GONGNULI_TYPE) {
		MN_GONGNULI_TYPE = mN_GONGNULI_TYPE;
	}

	public String getMN_GONGNULI_YN() {
		return MN_GONGNULI_YN;
	}

	public void setMN_GONGNULI_YN(String mN_GONGNULI_YN) {
		MN_GONGNULI_YN = mN_GONGNULI_YN;
	}

	public String getPAGE_DEPARTMENT() {
		return PAGE_DEPARTMENT;
	}

	public void setPAGE_DEPARTMENT(String pAGE_DEPARTMENT) {
		PAGE_DEPARTMENT = pAGE_DEPARTMENT;
	}

	public String getPAGE_HOMEDIV_C() {
		return PAGE_HOMEDIV_C;
	}

	public void setPAGE_HOMEDIV_C(String pAGE_HOMEDIV_C) {
		PAGE_HOMEDIV_C = pAGE_HOMEDIV_C;
	}

	public String getPAGE_KEYNO() {
		return PAGE_KEYNO;
	}

	public void setPAGE_KEYNO(String pAGE_KEYNO) {
		PAGE_KEYNO = pAGE_KEYNO;
	}

	public String getPAGE_NAME() {
		return PAGE_NAME;
	}

	public void setPAGE_NAME(String pAGE_NAME) {
		PAGE_NAME = pAGE_NAME;
	}

	public String getPAGE_TEL() {
		return PAGE_TEL;
	}

	public void setPAGE_TEL(String pAGE_TEL) {
		PAGE_TEL = pAGE_TEL;
	}

	public String getMN_DU_KEYNO() {
		return MN_DU_KEYNO;
	}

	public void setMN_DU_KEYNO(String mN_DU_KEYNO) {
		MN_DU_KEYNO = mN_DU_KEYNO;
	}

	public String getMN_REGDT() {
		return MN_REGDT;
	}

	public void setMN_REGDT(String mN_REGDT) {
		MN_REGDT = mN_REGDT;
	}

	public String getMN_MODDT() {
		return MN_MODDT;
	}

	public void setMN_MODDT(String mN_MODDT) {
		MN_MODDT = mN_MODDT;
	}

	public String getMN_MANAGER_DEP() {
		return MN_MANAGER_DEP;
	}

	public void setMN_MANAGER_DEP(String mN_MANAGER_DEP) {
		MN_MANAGER_DEP = mN_MANAGER_DEP;
	}

	public String getMN_MANAGER_TEL() {
		return MN_MANAGER_TEL;
	}

	public void setMN_MANAGER_TEL(String mN_MANAGER_TEL) {
		MN_MANAGER_TEL = mN_MANAGER_TEL;
	}

	public String getXH_DELYN() {
		return XH_DELYN;
	}

	public void setXH_DELYN(String xH_DELYN) {
		XH_DELYN = xH_DELYN;
	}

	public String getXH_KEYNO() {
		return XH_KEYNO;
	}

	public void setXH_KEYNO(String xH_KEYNO) {
		XH_KEYNO = xH_KEYNO;
	}

	public String getXH_MN_KEYNO() {
		return XH_MN_KEYNO;
	}

	public void setXH_MN_KEYNO(String xH_MN_KEYNO) {
		XH_MN_KEYNO = xH_MN_KEYNO;
	}

	public String getXH_FS_KEYNO() {
		return XH_FS_KEYNO;
	}

	public void setXH_FS_KEYNO(String xH_FS_KEYNO) {
		XH_FS_KEYNO = xH_FS_KEYNO;
	}

	public String getXH_REGDT() {
		return XH_REGDT;
	}

	public void setXH_REGDT(String xH_REGDT) {
		XH_REGDT = xH_REGDT;
	}

	public String getPOPUP_DIV() {
		return POPUP_DIV;
	}

	public void setPOPUP_DIV(String pOPUP_DIV) {
		POPUP_DIV = pOPUP_DIV;
	}

	public String getMN_TOUR_CATEGORY() {
		return MN_TOUR_CATEGORY;
	}

	public void setMN_TOUR_CATEGORY(String mN_TOUR_CATEGORY) {
		MN_TOUR_CATEGORY = mN_TOUR_CATEGORY;
	}

	public String getMN_TOURKEY() {
		return MN_TOURKEY;
	}

	public void setMN_TOURKEY(String mN_TOURKEY) {
		MN_TOURKEY = mN_TOURKEY;
	}
	
	public Integer getMN_CHILD_CNT() {
		return MN_CHILD_CNT;
	}

	public void setMN_CHILD_CNT(Integer mN_CHILD_CNT) {
		MN_CHILD_CNT = mN_CHILD_CNT;
	}

	public String getMN_MAIN_DATA1() {
		return MN_MAIN_DATA1;
	}

	public void setMN_MAIN_DATA1(String mN_MAIN_DATA1) {
		MN_MAIN_DATA1 = mN_MAIN_DATA1;
	}

	public Integer getMN_ORDER_BEFORE() {
		return MN_ORDER_BEFORE;
	}

	public void setMN_ORDER_BEFORE(Integer mN_ORDER_BEFORE) {
		MN_ORDER_BEFORE = mN_ORDER_BEFORE;
	}

	public String getMN_RESEARCH() {
		return MN_RESEARCH;
	}

	public void setMN_RESEARCH(String mN_RESEARCH) {
		MN_RESEARCH = mN_RESEARCH;
	}

	public String getMN_QRCODE() {
		return MN_QRCODE;
	}

	public void setMN_QRCODE(String mN_QRCODE) {
		MN_QRCODE = mN_QRCODE;
	}

	public String getMN_MANAGER() {
		return MN_MANAGER;
	}

	public void setMN_MANAGER(String mN_MANAGER) {
		MN_MANAGER = mN_MANAGER;
	}

	public String getMN_COLOR() {
		return MN_COLOR;
	}

	public void setMN_COLOR(String mN_COLOR) {
		MN_COLOR = mN_COLOR;
	}

	public String getMN_DATA1() {
		return MN_DATA1;
	}

	public void setMN_DATA1(String mN_DATA1) {
		MN_DATA1 = mN_DATA1;
	}

	public String getMN_DATA2() {
		return MN_DATA2;
	}

	public void setMN_DATA2(String mN_DATA2) {
		MN_DATA2 = mN_DATA2;
	}

	public String getMN_DATA3() {
		return MN_DATA3;
	}

	public void setMN_DATA3(String mN_DATA3) {
		MN_DATA3 = mN_DATA3;
	}

	public String getMN_ENG_NAME() {
		return MN_ENG_NAME;
	}

	public void setMN_ENG_NAME(String mN_ENG_NAME) {
		MN_ENG_NAME = mN_ENG_NAME;
	}

	public String getMN_DEP() {
		return MN_DEP;
	}

	public void setMN_DEP(String mN_DEP) {
		MN_DEP = mN_DEP;
	}

	public String getMVD_KEYNO() {
		return MVD_KEYNO;
	}

	public void setMVD_KEYNO(String mVD_KEYNO) {
		MVD_KEYNO = mVD_KEYNO;
	}

	public Menu() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Menu(String mN_HOMEDIV_C) {
		super();
		MN_HOMEDIV_C = mN_HOMEDIV_C;
	}
	
	
	public String getMN_MAINKEYS() {
		return MN_MAINKEYS;
	}

	public void setMN_MAINKEYS(String mN_MAINKEYS) {
		MN_MAINKEYS = mN_MAINKEYS;
	}

	public String getMN_AUTHORITY_KEY() {
		return MN_AUTHORITY_KEY;
	}

	public void setMN_AUTHORITY_KEY(String mN_AUTHORITY_KEY) {
		MN_AUTHORITY_KEY = mN_AUTHORITY_KEY;
	}

	public String getMN_AUTHORITY() {
		return MN_AUTHORITY;
	}

	public void setMN_AUTHORITY(String mN_AUTHORITY) {
		MN_AUTHORITY = mN_AUTHORITY;
	}

	public String getMN_beforeURL() {
		return MN_beforeURL;
	}

	public void setMN_beforeURL(String mN_beforeURL) {
		MN_beforeURL = mN_beforeURL;
	}

	public String getMN_ICON_CSS() {
		return MN_ICON_CSS;
	}

	public void setMN_ICON_CSS(String mN_ICON_CSS) {
		MN_ICON_CSS = mN_ICON_CSS;
	}

	public String getMN_ICON_URL1() {
		return MN_ICON_URL1;
	}

	public void setMN_ICON_URL1(String mN_ICON_URL1) {
		MN_ICON_URL1 = mN_ICON_URL1;
	}

	public String getMN_ICON_URL2() {
		return MN_ICON_URL2;
	}

	public void setMN_ICON_URL2(String mN_ICON_URL2) {
		MN_ICON_URL2 = mN_ICON_URL2;
	}

	public String getMN_BT_KEYNO() {
		return MN_BT_KEYNO;
	}

	public void setMN_BT_KEYNO(String mN_BT_KEYNO) {
		MN_BT_KEYNO = mN_BT_KEYNO;
	}

	public String getMN_SHOW_YN() {
		return MN_SHOW_YN;
	}

	public void setMN_SHOW_YN(String mN_SHOW_YN) {
		MN_SHOW_YN = mN_SHOW_YN;
	}

	public String getChecked_menu() {
		return checked_menu;
	}

	public void setChecked_menu(String checked_menu) {
		this.checked_menu = checked_menu;
	}

	public String getHIGH_MN_NAME() {
		return HIGH_MN_NAME;
	}

	public void setHIGH_MN_NAME(String hIGH_MN_NAME) {
		HIGH_MN_NAME = hIGH_MN_NAME;
	}

	public Integer getMN_LEV() {
		return MN_LEV;
	}

	public void setMN_LEV(Integer mN_LEV) {
		MN_LEV = mN_LEV;
	}

	public String getMN_KEYNO() {
		return MN_KEYNO;
	}

	public void setMN_KEYNO(String mN_KEYNO) {
		MN_KEYNO = mN_KEYNO;
	}

	public String getMN_NAME() {
		return MN_NAME;
	}

	public void setMN_NAME(String mN_NAME) {
		MN_NAME = mN_NAME;
	}

	public String getMN_HOMEDIV_C() {
		return MN_HOMEDIV_C;
	}

	public void setMN_HOMEDIV_C(String mN_HOMEDIV_C) {
		MN_HOMEDIV_C = mN_HOMEDIV_C;
	}

	public String getMN_PAGEDIV_C() {
		return MN_PAGEDIV_C;
	}

	public void setMN_PAGEDIV_C(String mN_PAGEDIV_C) {
		MN_PAGEDIV_C = mN_PAGEDIV_C;
	}

	public String getMN_URL() {
		return MN_URL;
	}

	public void setMN_URL(String mN_URL) {
		MN_URL = mN_URL;
	}

	public String getMN_MAINKEY() {
		return MN_MAINKEY;
	}

	public void setMN_MAINKEY(String mN_MAINKEY) {
		MN_MAINKEY = mN_MAINKEY;
	}

	public Integer getMN_ORDER() {
		return MN_ORDER;
	}

	public void setMN_ORDER(Integer mN_ORDER) {
		MN_ORDER = mN_ORDER;
	}

	public String getMN_USE_YN() {
		return MN_USE_YN;
	}

	public void setMN_USE_YN(String mN_USE_YN) {
		MN_USE_YN = mN_USE_YN;
	}

	public String getMN_REGDATE() {
		return MN_REGDATE;
	}

	public void setMN_REGDATE(String mN_REGDATE) {
		MN_REGDATE = mN_REGDATE;
	}

	public String getMN_MODDATE() {
		return MN_MODDATE;
	}

	public void setMN_MODDATE(String mN_MODDATE) {
		MN_MODDATE = mN_MODDATE;
	}

	public String getMN_REGNM() {
		return MN_REGNM;
	}

	public void setMN_REGNM(String mN_REGNM) {
		MN_REGNM = mN_REGNM;
	}

	public String getMN_MODNM() {
		return MN_MODNM;
	}

	public void setMN_MODNM(String mN_MODNM) {
		MN_MODNM = mN_MODNM;
	}

	public String getMN_DELDT() {
		return MN_DELDT;
	}

	public void setMN_DELDT(String mN_DELDT) {
		MN_DELDT = mN_DELDT;
	}

	public String getMN_DEL_YN() {
		return MN_DEL_YN;
	}

	public void setMN_DEL_YN(String mN_DEL_YN) {
		MN_DEL_YN = mN_DEL_YN;
	}

	public String getMN_FORWARD_URL() {
		return MN_FORWARD_URL;
	}

	public void setMN_FORWARD_URL(String mN_FORWARD_URL) {
		MN_FORWARD_URL = mN_FORWARD_URL;
	}

	public String getBTCODEKEY() {
		return BTCODEKEY;
	}

	public void setBTCODEKEY(String bTCODEKEY) {
		BTCODEKEY = bTCODEKEY;
	}

	public String getMN_MAINNAMES() {
		return MN_MAINNAMES;
	}

	public void setMN_MAINNAMES(String mN_MAINNAMES) {
		MN_MAINNAMES = mN_MAINNAMES;
	}

	public String getMN_QR_KEYNO() {
		return MN_QR_KEYNO;
	}

	public void setMN_QR_KEYNO(String mN_QR_KEYNO) {
		MN_QR_KEYNO = mN_QR_KEYNO;
	}

	public String getIMG_PATH() {
		return IMG_PATH;
	}

	public void setIMG_PATH(String iMG_PATH) {
		IMG_PATH = iMG_PATH;
	}
	
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	public String getMN_PAGEDIV_NAME() {
		return MN_PAGEDIV_NAME;
	}

	public void setMN_PAGEDIV_NAME(String mN_PAGEDIV_NAME) {
		MN_PAGEDIV_NAME = mN_PAGEDIV_NAME;
	}

	
}
