package com.tx.common.common;

/**
 * 상수값들 정리
 * @author 신강철
 *
 */
public class SettingData {
	
	
	
	public final static String PROGRAMER_KEY = "UI_SFMHO"; //개발자 계정
	
	public final static String HOMEPAGE_LANGUAGE = "ko"; //홈페이지 언어
//	public final static String HOMEPAGE_LANGUAGE = "en"; //홈페이지 언어
	
//	public final static String MAP_TYPE = "google"; //사용 하는 맵 종류
	public final static String MAP_TYPE = "naver"; //사용 하는 맵 종류
//	public final static String MAP_TYPE = "daum"; //사용 하는 맵 종류 (구현 X) 
	
	public final static int SESSION_DURATION = 17000+30; 	//세션 유지 시간 (초단위) 오차범위 수정을 위해 30초 추가로 셋팅해둠
	
	
	public final static String HOMEDIV_TOUR = "MN_0000001255"; //홈페이지 코드  - 문화관광
	
	public final static String HOMEDIV_CF = "MN_0000000207"; //홈페이지 코드  - CF
	public final static String HOMEDIV_ADMIN = "MN_0000000999"; //홈페이지 코드  - ADMIN
	public final static String HOMEDIV_JCIA = "MN_0000001158"; //홈페이지 코드  - JCIA
	public final static String HOMEDIV_JACT = "MN_0000001486"; //홈페이지 코드  - 전남 문화관광
	public final static String HOMEDIV_CULTURE = "MN_0000001568"; //홈페이지 코드  - 전남 문화관광
	
	public final static String PROGRAM_APPLY = "SC_0000000342"; 	//신청 프로그램
	public final static String PROGRAM_LECTURE = "SC_0000000343";  //강좌 프로그램
	
	public final static String APPLY_WAITING = "SC_0000000344";  //결제대기
	public final static String APPLY_COMPLETE = "SC_0000000345";  //신청완료(결제완료)
	public final static String APPLY_CANCEL = "SC_0000000346";  //신청취소(결제취소)
	public final static String APPLY_RESERVE = "SC_0000000347";  //대기자 신청
	public final static String APPLY_EXPIRED = "SC_0000000348";  //결제만료
	public final static String APPLY_PREVIEW = "SC_0000000349";  //관람완료
	
	public final static String EMAIL_SENDER = "txcms@tronix.kr"; //이메일 보내는 사람 기본 셋팅
	public final static String EMAIL_SENDER_NAME = "(재)전라남도문화재단"; //이메일 보내는 사람 기본 셋팅
		
	public final static int BOARD_PAGE_SIZE = 5; //게시판 페이징 처리 - 페이지 사이즈
	public final static int BOARD_RECORD_COUNT_PER_PAGE = 10; //게시판 페이징처리 한페이지에 나오는 게시물 숫자
	
	public final static int BOARD_REPLY_RECORD_COUNT_PER_PAGE = 20; // 페이징처리 한페이지에 나오는 게시물 숫자 - 댓글
	
	public final static int DEFAULT_IMG_RESIZE_WIDTH = 460;
	public final static int DEFAULT_IMG_RESIZE_HEIGHT = 0;
	public final static int DEFAULT_IMG_THUMBNAIL_RESIZE_WIDTH = 200;
	public final static int DEFAULT_IMG_THUMBNAIL_RESIZE_HEIGHT = 0;
	public final static int DEFAULT_IMG_POPUP_WIDTH = 1920;
	public final static int DEFAULT_IMG_POPUP_HEIGHT = 193;
	
	
	
	public final static String MENU_TYPE_PAGE = "SC_EANHU";  // 메뉴타입 코드 - 단일 페이지
	public final static String MENU_TYPE_BOARD = "SC_TFOVO";  // 메뉴타입 코드 - 게시판
	public final static String MENU_TYPE_LINK = "SC_HFAIU";  // 메뉴타입 코드 - 링크
	public final static String MENU_TYPE_SUBMENU = "SC_QXCFB";  // 메뉴타입 코드 - 소메뉴
	public final static String MENU_TYPE_PAGE2 = "SC_VUWAQ";  // 메뉴타입 코드 - 개발자페이지
	public final static String MENU_TYPE_TOUR = "SC_DEFGR";  // 메뉴타입 코드 - 관광 페이지
	
	
	public final static String BOARD_TYPE_LIST = "SC_0000000005";  // 게시판 코드 - 리스트형
	public final static String BOARD_TYPE_LIST_NO_DETAIL = "SC_FVMHW";  // 게시판 코드 - 리스트형(상세화면X)
	public final static String BOARD_TYPE_GALLERY = "SC_0000000006";  // 게시판 코드 - 갤러리형
	public final static String BOARD_TYPE_PUBLICATION = "SC_SHCJH";  // 게시판 코드 - 재단 발간물
	public final static String BOARD_TYPE_CALENDAR = "SC_VYIPX";  // 게시판 코드 - 캘린더형
	public final static String BOARD_TYPE_GALLERY_IMG = "SC_0000000407";  // 게시판 코드 - 갤러리-이미지형
	public final static String BOARD_TYPE_LETTER = "SC_0000000408";  // 게시판 코드 - 발행물 발간물(상세화면x)
	public final static String BOARD_TYPE_CULTURAL = "SC_0000000409";  // 게시판 코드 - 문화재연구소(상세화면o)
	public final static String BOARD_TYPE_SIGN = "SC_0000000410";  // 게시판 코드 - 문화재연구소(상세화면o)
	public final static String BOARD_TYPE_ACTIVE = "SC_0000000411";  // 게시판 코드 - 지역사회공헌활동
	
	public final static String BOARD_COLUMN_TYPE_TITLE = "SC_HBHNH";  // 게시판 컬럼 타입 코드 - 제목
	public final static String BOARD_COLUMN_TYPE_TEXT = "SC_VEBHI";  // 게시판 컬럼 타입 코드 - 텍스트
	public final static String BOARD_COLUMN_TYPE_CHECK = "SC_JJQBU";  // 게시판 컬럼 타입 코드 - 체크
	public final static String BOARD_COLUMN_TYPE_CHECK_CODE = "SC_GCONA";  // 게시판 컬럼 타입 코드 - 체크(코드)
	public final static String BOARD_COLUMN_TYPE_RADIO = "SC_ZUZQU";  // 게시판 컬럼 타입 코드 - 라디오
	public final static String BOARD_COLUMN_TYPE_RADIO_CODE = "SC_OMILB";  // 게시판 컬럼 타입 코드 - 라디오(코드)
	public final static String BOARD_COLUMN_TYPE_SELECT = "SC_SACUX";  // 게시판 컬럼 타입 코드 - 셀렉트
	public final static String BOARD_COLUMN_TYPE_SELECT_CODE = "SC_DESUO";  // 게시판 컬럼 타입 코드 - 셀렉트(코드)
	public final static String BOARD_COLUMN_TYPE_CALENDAR = "SC_NYMMH";  // 게시판 컬럼 타입 코드 - 달력
	public final static String BOARD_COLUMN_TYPE_PWD = "SC_ZERST";  // 게시판 컬럼 타입 코드 - 패스워드
	public final static String BOARD_COLUMN_TYPE_EMAIL = "SC_ZYDQB";  // 게시판 컬럼 타입 코드 - 이메일
	public final static String BOARD_COLUMN_TYPE_NUMBER = "SC_BEIDD";  // 게시판 컬럼 타입 코드 - 숫자
	public final static String BOARD_COLUMN_TYPE_LINK = "SC_PJDGH";  // 게시판 컬럼 타입 코드 - 링크
	public final static String BOARD_COLUMN_TYPE_CALENDAR_START = "SC_0000000356";  // 게시판 컬럼 타입 코드 - 달력(시작날짜)
	public final static String BOARD_COLUMN_TYPE_CALENDAR_END = "SC_0000000357";  // 게시판 컬럼 타입 코드 - 달력(종료날짜)
	
	
	public final static String AUTHORITY_ADMIN = "UIA_ASDFG";  				// 권한 유형  - 관리자(개발자 계정)
	public final static String AUTHORITY_ANONYMOUS = "UIA_EAFDS";  			// 권한 유형  - 비회원
	
	
	public final static String AUTHORITY_ROLE_ACCESS = "UIR_0000000019";  	// 권한 roll  - 접근 권한
	public final static String AUTHORITY_ROLE_READ = "UIR_0000000014";  	// 권한 roll  - 읽기 권한
	public final static String AUTHORITY_ROLE_WRITE = "UIR_0000000015";  	// 권한 roll  - 쓰기 권한
	public final static String AUTHORITY_ROLE_UPDATE = "UIR_0000000020";  	// 권한 roll  - 수정 권한
	public final static String AUTHORITY_ROLE_DELETE = "UIR_0000000021";  	// 권한 roll  - 삭제 권한
	public final static String AUTHORITY_ROLE_REPLY = "UIR_0000000016";  	// 권한 roll  - 답글 권한
	public final static String AUTHORITY_ROLE_COMMENT = "UIR_0000000017";  	// 권한 roll  - 댓글 권한
	
	public final static String AUTHORITY_SUB_ALL = "SC_WGSYT";  			// 서브 권한 타입  - 모두
	public final static String AUTHORITY_SUB_BOARD = "SC_MYKFE";  			// 서브 권한 타입  - 게시판
	public final static String AUTHORITY_SUB_ETC = "SC_TZGGA";  			// 서브 권한 타입  - 기타
	
	public final static String TOUR_DEFAULT_LAT = "34.5982177";  			// 관광정보 기본 위도값 
	public final static String TOUR_DEFAULT_LNG = "127.2875759";  			// 관광정보 기본 경도값
	
	public final static String TOUR_HOTEL = "";  							// 숙박 타입  - 호텔
	public final static String TOUR_MOTEL = "";  							// 숙박 타입  - 모텔
	
	public final static String TOUR_RESTAURANT_MODEL = "";  				// 식당 타입  - 모범음식점
	public final static String TOUR_RESTAURANT_HYGIENIC = "";  				// 식당 타입  - 위생등급
	
	public final static String TOUR_MENU_DESTINATION = "";  				// 관광메뉴  - 관광명소
	
	
	public final static String TOUR_DESTINATION = "SC_0000000361";  		// 관광정보 타입  - 관광명소
	public final static String TOUR_THEME = "SC_0000000362";  				// 관광정보 타입  - 테마
	public final static String TOUR_COURSE = "SC_0000000363";  				// 관광정보 타입  - 코스
	public final static String TOUR_LODGMENT = "SC_0000000364";  			// 관광정보 타입  - 숙박
	public final static String TOUR_RESTAURANT = "SC_0000000365";  			// 관광정보 타입  - 식당
	public final static String TOUR_FESTIVAL = "SC_0000000366";  			// 관광정보 타입  - 축제
	public final static String TOUR_CULTURAL_HERITAGE = "SC_0000000367";  	// 관광정보 타입  - 문화재
	
	public final static String JSPDATA = "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>\n" + 
										 "<%@ include file=\"/WEB-INF/jsp/taglib/taglib.jspf\"%>\n";
	
	
	public final static String COLUMN_1 = "BL_0000000102";  	// 예정금액
	public final static String COLUMN_2 = "BL_0000000103";  	// 예정금액
	public final static String COLUMN_3 = "BL_0000000114";  	// 예정금액
	
	
	//RequestAPI Setting값
	public final static String Apikey = "qcp255q389pcsb3ddunfcb7ys93kbnli";
	public final static String Userid = "daeyang";
	public final static String Senderkey = "150329633d7b950290bfb0e577375705c0678a7f";
	
	
	
	public final static String SFA_REGISTER = "SFA_01";  	// 안전관리
	public final static String SFA_ELECTRO = "SFA_02";  	// 전기 설비 점검결과 기록표
	
}
