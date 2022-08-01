package com.tx.common.component.impl;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 * @CommonDataAccessObject
 * 공통 인터 페이스의 처리 내용을 관리한다.
 * @author 신희원
 * @version 1.0
 * @since 2014-11-14
 */
@Service("CommonService")
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;	
	
	/**
	 * 코드관리에서 고유 코드 번호를 취득한다.
	 * @return
	 * @throws Exception
	 */
	@Override
	public String getCodeNumber(String query)throws Exception{
		String Code = Component.getData(query);
		if(Code == null || Code.equals("")){
			Code = "1";
    	}else{
    		Code = ""+(Integer.parseInt(Code.substring(4))+1);
    	} 
    	while(Code.length() < 4){
    		Code = "0"+Code;
    	}
        String getCodeNumber = "Code"+ Code;
        return getCodeNumber;
	}
	
	
	
	
	/**
	 * 테이블 키 정보 조회 후 새키 번호 발급
	 */
	@Override
    public synchronized String getTableKey(String TableCode) throws DataAccessException{
		
		//테이블 명 필터 및 갱신 처리
		String tableName = getTableName(TableCode);
		//테이블 코드가 없는 경우
		if(tableName == null){
			return null; // 잘못된 파라미터를 받을 경우 null로 Return
		}
		Map<String,String> KEY = new HashMap<String, String>();
		KEY.put("TableName", tableName);
		KEY.put("TableCode", TableCode + "_KEYNO");
		
		//테이블 현재 카운팅 숫자 조회
		Integer getKeyNum = Component.getData("Common.getTableKey", tableName);
		if(getKeyNum == null){
			Component.createData("Common.createTableKey", KEY);
			getKeyNum = 0;
		}
		String CodeColumn = "";
		
		
		//랜덤
		if(getKeyNum == -1){
			do {
				CodeColumn = "";	
				for(int i=0;i<5;i++){
					/* A-Z 까지 랜덤으로 5번 뽑음*/
					CodeColumn += (char)(new Random().nextInt(26)+65);
				}
				KEY.put("CodeColumn", TableCode + "_" + CodeColumn);
				int count = Component.getCount("Common.checkTableKey", KEY);
				if(count == 0){
					break;
				}
			}while(true);
			
		}
		//일반 카운팅
		else{
			getKeyNum = getKeyNum + 1;
			
			//카운터 갱신 처리
			Component.updateData("Common.CountTableKey", tableName);
			CodeColumn = Integer.toString(getKeyNum);
			//코드 발급
			while(CodeColumn.length() < 10){
				CodeColumn = "0" +  CodeColumn;
			}
		}
		return TableCode + "_" + CodeColumn;
		
		
	}
	
	/**
	 * 테이블 코드 번호를 테이블 정보로 리턴
	 */
	@Override
	public String getTableName(String TableCode){
		String TableName = "";
		switch (TableCode) {
			 case "UI" 		: TableName = "T_USERINFO"; break;					 	// 회원 관리
			 case "UIA"		: TableName = "T_USERINFO_AUTHORITY"; break;		 	// 회원 - 권한 관리
			 case "UIR"		: TableName = "T_USERINFO_ROLL"; break;				 	// 회원 - 서브 권한 관리
			 case "USR"		: TableName = "T_USERINFO_SECURED_RESOURCE"; break;	 	// 리소스 관리
			 case "MNA"		: TableName = "T_MENU_RESOURCES"; break;			 	// 메뉴별 리소스&역할 매칭 관리
		     case "IPM" 	: TableName = "T_IPFILTER_MAIN"; break;				 	// IP 필터 관리 테이블 메인
			 case "IPS" 	: TableName = "T_IPFILTER_SUB"; break;				 	// IP 필터 관리 테이블 서브
			 case "FM" 	 	: TableName = "T_COMMON_FILE_MAIN"; break;			 	// 파일 관리 메인
			 case "FS" 	 	: TableName = "T_COMMON_FILE_SUB"; break;			 	// 파일 관리 서브
			 case "XH" 	 	: TableName = "T_XML_HISTORY"; break;			 		// xml 히스토리 테이블
			 case "MC" 	 	: TableName = "T_COMMON_CODE_MAIN"; break;			 	// 코드 관리 메인
			 case "SC" 	 	: TableName = "T_COMMON_CODE_SUB"; break;			 	// 코드 관리 서브
			 case "BT" 	 	: TableName = "T_BOARD_TYPE"; break;				 	// 게시판 타입관리
			 case "BL" 	 	: TableName = "T_BOARD_COLUMN"; break;				 	// 게시판 컬럼관리
			 case "BD" 	 	: TableName = "T_BOARD_COLUMN_DATA"; break;			 	// 게시판 컬럼데이터관리
			 case "BN" 	 	: TableName = "T_BOARD_NOTICE"; break;				 	// 게시물 관리
			 case "MN" 	 	: TableName = "T_MENU_MANAGER"; break;				 	// 메뉴 관리
			 case "HM" 	 	: TableName = "T_HOME_MANAGER"; break;				 	// 홈페이지 관리
			 case "HAM" 	: TableName = "T_HOME_AUTHORITY_MANAGER"; break;	 	// 홈페이지 권한별 설정 
			 case "PI" 	 	: TableName = "T_POPUPINFO"; break;					 	// 팝업 관리
			 case "BC" 	 	: TableName = "T_BOARD_COMMENT"; break;				 	// 게시물 댓글 관리
			 case "MVD" 	: TableName = "T_MENU_VIEW_DATA"; break;			 	// 메뉴관리 - 뷰형 데이터 저장
			 case "MVH" 	: TableName = "T_MENU_VIEW_DATA_HISTORY"; break;	 	// 메뉴관리 - 뷰형 데이터 히스토리
			 case "BIH"	 	: TableName = "T_BOARD_INTRO_HTML"; break;			 	// 게시판HTML필요페이지
			 case "THM"	 	: TableName = "T_HOLIDAY_MANAGER"; break;		 	 	// 휴일 관리 테이블
			 case "BNH" 	: TableName = "T_BOARD_NOTICE_HISTORY"; break;		 	// 게시물 관리 - 기록
			 case "CQ" 	 	: TableName = "T_COMMON_QRCODE"; break;				 	// QR 코드
			 case "AH" 	 	: TableName = "T_ACTIVITY_HISTORY"; break;			 	// 활동 기록 테이블
			 case "MM" 	 	: TableName = "T_MAIN_SLIDE_MANAGER"; break;		 	// 메인슬라이드 관리 테이블
			 case "BM" 	 	: TableName = "T_BANNER_MANAGER"; break;			 	// 배너관리 테이블
			 case "TPS"	 	: TableName = "T_PAGE_RESEARCH_MANAGER"; break;			// 페이지 평가 관리 테이블
			 case "BMM" 	: TableName = "T_BOARD_MAINMINI"; break;				// 미니게시판 테이블
			 case "TCGM" 	: TableName = "T_CATEGORY_MANAGER"; break;				// 카테고리 관리 테이블
			 case "TLM" 	: TableName = "T_LIST_MANAGER"; break;					// 리스트 관리 테이블
			 case "RM" 		: TableName = "T_RESOURCES_MANAGER"; break;				// 리소스 테이블
			 case "RMS" 	: TableName = "T_RESOURCES_MANAGER_SUB"; break;			// 리소스 서브 테이블
			 case "RMH" 	: TableName = "T_RESOURCES_MANAGER_HISTORY"; break;		// 리소스 히스토리 테이블
			 case "TSM" 	: TableName = "T_SITE_MANAGER"; break;					// 사이트 관리 테이블


		     default     : System.out.println("등록 되지 않은 테이블입니다."); return null; 	// 잘못됫 입력 정보  null 리턴
	    }
		return TableName;
	}
	
	/**
	 * 받아온 keyno값을 테이블 규칙에 맞게 변경
	 * ex) 123 -> SC_0000000123
	 */
	public String getKeyno(String keyno,String tableName){
		//숫자타입 key가 아닐 경우 그대로 반환
		if( !StringUtils.isNumeric(keyno) ){
			return keyno;
		}
		int length=keyno.length();
		for(int i=length;i<10;i++){
			keyno="0"+keyno;
		}
		return tableName+"_"+keyno;
		
	}
	
	/**
	 * 받아온 keyno값을 숫자만 추출
	 * ex) SC_0000000123 - > 123
	 */
	public String setKeyno(String keyno){
		
		return Integer.parseInt(keyno.split("\\_")[1])+"";
		
	}
	
	
	 /**
	  * 접속 IP 확인
	  * @param request
	  * @return
	  */
	 public String getClientIP(HttpServletRequest request) {

	     String ip = request.getHeader("X-FORWARDED-FOR"); 
	     if(ip == null || ip.length() == 0) {
	         ip = request.getHeader("Proxy-Client-IP");
	     }
	     if(ip == null || ip.length() == 0) {
	         ip = request.getHeader("WL-Proxy-Client-IP");  // 웹로직
	     }
	     if(ip == null || ip.length() == 0) {
	         ip = request.getRemoteAddr() ;
	     }
	     return ip;
	 }
	
	 /**
	  * 홈페이지 코드 return
	  * 최상위 Menu Key들의 List를 반환한다.
	 */
	 public List<HomeManager> getHomeDivCode(boolean includeAdmin){
		//홈페이지 구분 리스트
		 Menu MenuForHomeDivList = new Menu();
			MenuForHomeDivList.setMN_DEL_YN("N");
			MenuForHomeDivList.setMN_HOMEDIV_C(null);
			MenuForHomeDivList.setMN_MAINKEY("");
			MenuForHomeDivList.setMN_KEYNO(SettingData.HOMEDIV_ADMIN);
			if(!includeAdmin){
				MenuForHomeDivList.setMN_KEYNO(SettingData.HOMEDIV_ADMIN);
				MenuForHomeDivList.setSearchKeyword("incldueAdmin");
			}
			return Component.getList("Menu.AMN_getMenuList",MenuForHomeDivList);
	 }
	 
	 /**
		 * request를 통한 URL값 얻기 
		 * @throws Exception 
		 *   */
	public String checkUrl(HttpServletRequest req) throws Exception{
		String URL = "";
		/*
		URL : req.getRequestURL();
		URI :req.getRequestURI()
		Path :req.getServletPath()
		Scheme :req.getScheme()
		ServerName :req.getServerName()
		ServerPort :req.getServerPort()
		Context :req.getContextPath()
		*/
		String port = req.getServerPort()+"";
		if(port.equals("80")){ // 서비스시 80포트는 숨김
			port = "";
		}else{
			port = ":"+port;
		}
		URL = req.getScheme() + "://" + req.getServerName() + port + req.getContextPath();
		return URL;
	}
	
	/**
	 * 타일즈에 따른 JSP 경로 리턴
	 * @param tiles
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public String getJspName(String tiles, String path) throws Exception{
		
		String HM_TILES = Component.getData("HomeManager.HM_getTiles", tiles);
		
		if(StringUtils.isEmpty(HM_TILES)){
			return null;
		}
		
		HM_TILES = "/" + HM_TILES + path;
		
		return HM_TILES;
		
		
	}

	@Override
	public String getSessionUserKey(HttpServletRequest req) throws Exception {
		@SuppressWarnings("unchecked")
		HashMap<String, Object> userInfo = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		if( userInfo == null || userInfo.get("UI_KEYNO") == null ){
			return "";
		}
		return userInfo.get("UI_KEYNO").toString();
	}



	/**
	 * 관광 카테고리 이름 가져오기
	 * @param category
	 * @return
	 * @throws Exception
	 */
	@Override
	public String getTourCategoryName(String category) throws Exception {
		// TODO Auto-generated method stub
		String categoryName = "";
		switch (category) {
		case SettingData.TOUR_COURSE:
			categoryName = "course";
			break;
		case SettingData.TOUR_CULTURAL_HERITAGE:
			categoryName = "culturalheritage";
			break;
		case SettingData.TOUR_DESTINATION:
			categoryName = "destination";
			break;
		case SettingData.TOUR_FESTIVAL:
			categoryName = "festival";
			break;
		case SettingData.TOUR_RESTAURANT:
			categoryName = "restaurnat";
			break;
		case SettingData.TOUR_LODGMENT:
			categoryName = "lodgment";
			break;
		case SettingData.TOUR_THEME:
			categoryName = "theme";
			break;
		default:
			break;
		}
		
		return categoryName;
	}
	
	/**
	 * 관광 카테고리 키 가져오기
	 * @param category
	 * @return
	 * @throws Exception
	 */
	@Override
	public String getTourCategoryKey(String categoryName) throws Exception {
		// TODO Auto-generated method stub
		String category = "";
		switch (categoryName) {
		case "course":
			category = SettingData.TOUR_COURSE;
			break;
		case "culturalheritage":
			category = SettingData.TOUR_CULTURAL_HERITAGE;
			break;
		case "destination":
			category = SettingData.TOUR_DESTINATION;
			break;
		case "festival":
			category = SettingData.TOUR_FESTIVAL;
			break;
		case "restaurnat":
			category = SettingData.TOUR_RESTAURANT;
			break;
		case "lodgment":
			category = SettingData.TOUR_LODGMENT;
			break;
		case "theme":
			category = SettingData.TOUR_THEME;
			break;
		default:
			break;
		}
		
		return category;
	}
	
	/**
	 * 넘어온 배열들의 길이가 같은지 확인한다.
	 * @param array
	 * @return
	 */
	@Override
	public boolean checkArrayLength(String[]... arrays) throws Exception {
		// TODO Auto-generated method stub
		
		
		for(String[] array : arrays){
			if(array == null) return false;
		}
		
		Integer length = null;
		
		for(String[] array : arrays){
			if(length == null){
				length = array.length;
			}else{
				if(length != array.length){
					throw new RuntimeException("넘어온 배열들의 길이가 다름.");
				}
			}
		}
		return true;
	}
	
	/**
	 * Object to Map
	 * @param obj
	 * @return
	 * @throws IllegalAccessException 
	 * @throws Exception 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map<String, Object> ConverObjectToMap(Object obj) throws Exception{
			// Field[] fields = obj.getClass().getFields(); //private field는 나오지
			// 않음.
			Field[] fields = obj.getClass().getDeclaredFields();
			Map resultMap = new HashMap();
			for (int i = 0; i <= fields.length - 1; i++) {
				fields[i].setAccessible(true);
				resultMap.put(fields[i].getName(), fields[i].get(obj));
			}
			return resultMap;
	}

	@Override
	public List<Map<String, Object>> ConverObjectListToMapList(List<?> objList) throws Exception {
		// TODO Auto-generated method stub
		List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
		
		for(Object obj : objList) mapList.add(ConverObjectToMap(obj));
			
		return mapList;
	}
	
	/**
	 * 테이블 데이터 삭제
	 * @param tableName
	 * @param column
	 */
	@Override
	public void deleteData(String tableName, List<HashMap<String,Object>> columns) throws Exception {
		HashMap<String,Object> deleteMap = new HashMap<String,Object>();
		deleteMap.put("tableName",tableName);
		deleteMap.put("columns", columns);
		Component.deleteData("Common.deleteTableData",deleteMap);
	}
	
	/**
	 * 해쉬맵 만들어서 리턴 
	 * @param string
	 * @param object
	 * @return
	 * @throws Exception
	 */
	@Override
	public HashMap<String,Object> createMap(String name, Object object) throws Exception {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put(name, object);
		return map;
	}
}
