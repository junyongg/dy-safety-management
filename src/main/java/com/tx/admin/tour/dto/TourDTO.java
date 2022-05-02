package com.tx.admin.tour.dto;

import com.tx.common.dto.Common;

public class TourDTO extends Common {
	
	private static final long serialVersionUID = -8716753312865665515L;

	//관광 공통요소 테이블
	private String  TC_KEYNO            
					,TC_TITLE            
					,TC_SUBTITLE         
					,TC_TAG             
					,TC_THUMBNAIL         
					,TC_SUMMARY          
					,TC_CONTENTS          
					,TC_PLACE            
					,TC_ADDR             
					,TC_ADDR2            
					,TC_CONTACT            
					,TC_POST             
					,TC_MANAGER          
					,TC_DEPARTMENT       
					,TC_CONTACTS
					,TC_CONTACT2        
					,TC_LAT         
					,TC_LNG        
					,TC_UP_CNT           
					,TC_DICTIONARY       
					,TC_HOME_URL         
					,TC_BLOG_URL         
					,TC_SNS_URL          
					,TC_RESERVATION_URL  
					,TC_WAY_JAGA         
					,TC_WAY_PUBLIC       
					,TC_WAY_GUIDE        
					,TC_TYPE             
					,TC_USE
					,TC_SHOW_COLUMN
					,TC_REGDT
					,TC_REGNM
					,TC_MODDT
					,TC_MODNM
					,TC_REPLY_YN;
	//이용안내 테이블
	private String   TI_KEYNO               
					,TI_TIME                
					,TI_DETAIL              
					,TI_ENTRANCE_FEE        
					,TI_CLOSED_DAY          
					,TI_PARKING_YN          
					,TI_PARKING_PLACE       
					,TI_BUDAE_SISEOL   
					,TI_CONVENIENCE_SISEOL        
					,TI_ETC_SISEOL 
					,TI_ETC_DETAIL          
					,TI_LANG_SERVICE;
	
	//T_TOURISM_THEME
	private String  TT_KEYNO
					,TT_TC_KEYNO
					,TT_TI_KEYNO
					,TT_DIVISION
					,TT_APPLY
					,TT_CHE_DIVISION
					,TT_FAX
					,TT_TARGET
					,TT_BAE_NAME
					,TT_BAE_CAPTAIN
					,TT_INWON
					,TT_BAE_TON
					,TT_BAE_START_TIME
					,TT_TIME
					,TT_BAE_PLACE
					,TT_BAE_END_TIME
					,TT_COURCE
					,TT_WALK_DISTANCE
					,TT_START_PLACE
					,TT_END_PLACE
					,TT_WALK_MIDDLE_PLACE
					,TT_WALK_NANIDO
					,TT_WALK_BOLGEOLI
					,TT_TEMPLE_GUIDE
					,TT_TEMPLE_BOOKS_WAY
					,TT_TEMPLE_PROGRAM_NAME
					,TT_TEMPLE_PROGRAM_CONTANT
					,TT_TEMPLE_EFFECT
					,TT_TOWN_ORIGIN
					,TT_TOWN_GREETING
					,TT_TOWN_SPECIALTY
					,TT_TOWN_KEYNO
					,TT_TOWN_SALGEOLI
					,TT_SUP_MANAGE
					,TT_SUP_KINDS;              
	
	//T_TOURISM_CULTURAL_HERITAGE
	private String  TCH_KEYNO
					,TCH_TC_KEYNO
					,TCH_TI_KEYNO
					,TCH_DIVISION
					,TCH_TYPE
					,TCH_LOCATION
					,TCH_JIJEONG_DAY
					,TCH_JIJEONG_NUM
					,TCH_ERA
					,TCH_STRING1
					,TCH_STRING2
					,TCH_STRING3;  
	
	//T_TOURISM_FESTIVAL
	private String 	TF_KEYNO
					,TF_TC_KEYNO
					,TF_TI_KEYNO
					,TF_DIVISION
					,TF_START_TIME
					,TF_END_TIME
					,TF_JUGWAN
					,TF_PURPOSE
					,TF_PROGRAM
					,TF_TERM
					,TF_NIGHT_STARTIME
					,TF_NIGHT_ENDTIME
					,TF_CONTENTS
					,TF_PLACE;
	
	//T_TOURISM_COURSE_MAIN
	private String 	 TCM_KEYNO
					,TCM_TC_KEYNO
					,TCM_TI_KEYNO
					,TCM_SEASON
					,TCM_TYPE
					,TCM_TIME;
	
	//T_TOURISM_COURSE_SUB
	private String   TCS_LAT
					,TCS_LNG
					,TCS_LEVEL
					,TCS_COMMENT
					,TCS_TYPE
					,TCS_TYPE_KEYNO
					,TCS_TITLE
					,TCS_AUTO_DISTANCE
					,TCS_DISTANCE
					,TCS_TIME
					,TCS_POSITON_TYPE;
	
	//T_TOURISM_DESTINATION
	private String  TA_KEYNO             
					,TA_TC_KEYNO          
					,TA_TI_KEYNO          
					,TA_DIVISION          
					,TA_GIGAN             
					,TA_YAGAN             
					,TA_SEASON            
					,TA_SAN_SOGCHING      
					,TA_SAN_SCALE        
					,TA_SAN_HANJANAME     
					,TA_BEACH_AREA        
					,TA_BEACH_LONG        
					,TA_BEACH_WIDTH       
					,TA_BEACH_SHAPE       
					,TA_BEACH_SLOPE       
					,TA_BEACH_SAFE_DISTANCE
					,TA_SUM_AREA          
					,TA_SUM_GAGU_CNT    
					,TA_SUM_TYPE    
					,TA_SUM_COASTLINE
					,TA_TIME;
	
	
	//T_TOURISM_MENU
	private String  TM_KEYNO
					,TM_TR_KEYNO
					,TM_NAME
					,TM_PRICE
					,TM_IMG
					,TM_SUMMARY
					,TM_ORDER
					,TM_MAINYN;   
	
	//T_TOURISM_GUESTROOM
	private String 	TG_KEYNO
					,TG_TL_KEYNO
					,TG_NAME             
					,TG_SIZE_METER       
					,TG_PRICE_CONTENT            
					,TG_SURCHARGE        
					,TG_LOW_SEASON_FEE   
					,TG_SUMMER_SEASON_FEE
					,TG_WINTER_SEASON_FEE
					,TG_INWON_MIN_CNT    
					,TG_GIJUN_INWON      
					,TG_INWON_MAX_CNT   
					,TG_IMG              
					,TG_SUMMARY          
					,TG_SIZE_FLAT        
					,TG_ORDER;
	
	//T_TOURISM_LODGMENT
	private String   TL_KEYNO
					,TL_DIVISION
					,TL_TEL
					,TL_IBSIL_TIME
					,TL_TOESIL_TIME
					,TL_GUBI_SISEOL
					,TL_USE_JOGEON
					,TL_USE_RULE
					,TL_BREAKFAST_YN
					,TL_BEDROOM_CNT
					,TL_ONDOLROOM_CNT
					,TL_GROUPROOM_CNT
					,TL_CAMPING_SISEOL
					,TL_WIFI_YN
					,TL_TC_KEYNO
					,TL_PRICE_CONTENT
					,TL_AREA
					,TL_EUB
					,TL_OWNER;
	
	//T_TOURISM_RESTAURANT
	private String  TR_KEYNO
					,TR_DIVISION
					,TR_TC_KEYNO
					,TR_START_TIME
					,TR_END_TIME
					,TR_GUBI_SISEOL
					,TR_FOOD_TYPE
					,TR_PACKING_YN
					,TR_HOLIDAY
					,TR_PETS_YN
					,TR_WIFI_YN
					,TR_STROLLER_YN
					,TR_ROOM_CNT
					,TR_SMOKING_CNT
					,TR_PARKING
					,TR_SEAT_CNT
					,TR_BOOKING
					,TR_MAIN_MENU
					,TR_OWNER;
	
	//T_TOURISM_IMAGE
	private String 	TIM_TC_KEYNO
					, TIM_TM_KEYNO
					, TIM_TG_KEYNO
					, TIM_FS_KEYNO
					, TIM_ORDER;
	
	
	//메뉴 등록되어있는지 체크
	private String MENUYN;
	private boolean MENUCK = true;
	
	
	
	public String getTR_OWNER() {
		return TR_OWNER;
	}
	public void setTR_OWNER(String tR_OWNER) {
		TR_OWNER = tR_OWNER;
	}
	public String getTR_MAIN_MENU() {
		return TR_MAIN_MENU;
	}
	public void setTR_MAIN_MENU(String tR_MAIN_MENU) {
		TR_MAIN_MENU = tR_MAIN_MENU;
	}
	public String getTF_CONTENTS() {
		return TF_CONTENTS;
	}
	public void setTF_CONTENTS(String tF_CONTENTS) {
		TF_CONTENTS = tF_CONTENTS;
	}
	public String getTF_PLACE() {
		return TF_PLACE;
	}
	public void setTF_PLACE(String tF_PLACE) {
		TF_PLACE = tF_PLACE;
	}
	public String getTCH_STRING1() {
		return TCH_STRING1;
	}
	public void setTCH_STRING1(String tCH_STRING1) {
		TCH_STRING1 = tCH_STRING1;
	}
	public String getTCH_STRING2() {
		return TCH_STRING2;
	}
	public void setTCH_STRING2(String tCH_STRING2) {
		TCH_STRING2 = tCH_STRING2;
	}
	public String getTCH_STRING3() {
		return TCH_STRING3;
	}
	public void setTCH_STRING3(String tCH_STRING3) {
		TCH_STRING3 = tCH_STRING3;
	}
	public String getTL_AREA() {
		return TL_AREA;
	}
	public void setTL_AREA(String tL_AREA) {
		TL_AREA = tL_AREA;
	}
	public boolean isMENUCK() {
		return MENUCK;
	}
	public void setMENUCK(boolean mENUCK) {
		MENUCK = mENUCK;
	}
	public String getMENUYN() {
		return MENUYN;
	}
	public void setMENUYN(String mENUYN) {
		MENUYN = mENUYN;
	}
	public String getTM_MAINYN() {
		return TM_MAINYN;
	}
	public void setTM_MAINYN(String tM_MAINYN) {
		TM_MAINYN = tM_MAINYN;
	}
	public String getTF_DIVISION() {
		return TF_DIVISION;
	}
	public void setTF_DIVISION(String tF_DIVISION) {
		TF_DIVISION = tF_DIVISION;
	}
	public String getTM_KEYNO() {
		return TM_KEYNO;
	}
	public String setTM_KEYNO(String tM_KEYNO) {
		return TM_KEYNO = tM_KEYNO;
	}
	public String getTG_KEYNO() {
		return TG_KEYNO;
	}
	public void setTG_KEYNO(String tG_KEYNO) {
		TG_KEYNO = tG_KEYNO;
	}
	
	public String getTIM_TM_KEYNO() {
		return TIM_TM_KEYNO;
	}
	public void setTIM_TM_KEYNO(String tIM_TM_KEYNO) {
		TIM_TM_KEYNO = tIM_TM_KEYNO;
	}
	public String getTIM_TG_KEYNO() {
		return TIM_TG_KEYNO;
	}
	public void setTIM_TG_KEYNO(String tIM_TG_KEYNO) {
		TIM_TG_KEYNO = tIM_TG_KEYNO;
	}
	public String getTR_BOOKING() {
		return TR_BOOKING;
	}
	public void setTR_BOOKING(String tR_BOOKING) {
		TR_BOOKING = tR_BOOKING;
	}
	public String getTR_PARKING() {
		return TR_PARKING;
	}
	public void setTR_PARKING(String tR_PARKING) {
		TR_PARKING = tR_PARKING;
	}
	public String getTC_REGDT() {
		return TC_REGDT;
	}
	public void setTC_REGDT(String tC_REGDT) {
		TC_REGDT = tC_REGDT;
	}
	public String getTC_REGNM() {
		return TC_REGNM;
	}
	public void setTC_REGNM(String tC_REGNM) {
		TC_REGNM = tC_REGNM;
	}
	public String getTC_MODDT() {
		return TC_MODDT;
	}
	public void setTC_MODDT(String tC_MODDT) {
		TC_MODDT = tC_MODDT;
	}
	public String getTC_MODNM() {
		return TC_MODNM;
	}
	public void setTC_MODNM(String tC_MODNM) {
		TC_MODNM = tC_MODNM;
	}
	public String getTC_SHOW_COLUMN() {
		return TC_SHOW_COLUMN;
	}
	public void setTC_SHOW_COLUMN(String tC_SHOW_COLUMN) {
		TC_SHOW_COLUMN = tC_SHOW_COLUMN;
	}
	public String getTIM_TC_KEYNO() {
		return TIM_TC_KEYNO;
	}
	public void setTIM_TC_KEYNO(String tIM_TC_KEYNO) {
		TIM_TC_KEYNO = tIM_TC_KEYNO;
	}
	public String getTIM_FS_KEYNO() {
		return TIM_FS_KEYNO;
	}
	public void setTIM_FS_KEYNO(String tIM_FS_KEYNO) {
		TIM_FS_KEYNO = tIM_FS_KEYNO;
	}
	public String getTIM_ORDER() {
		return TIM_ORDER;
	}
	public void setTIM_ORDER(String tIM_ORDER) {
		TIM_ORDER = tIM_ORDER;
	}
	
	public String getTT_KEYNO() {
		return TT_KEYNO;
	}
	public void setTT_KEYNO(String tT_KEYNO) {
		TT_KEYNO = tT_KEYNO;
	}
	public String getTT_TC_KEYNO() {
		return TT_TC_KEYNO;
	}
	public void setTT_TC_KEYNO(String tT_TC_KEYNO) {
		TT_TC_KEYNO = tT_TC_KEYNO;
	}
	public String getTT_TI_KEYNO() {
		return TT_TI_KEYNO;
	}
	public void setTT_TI_KEYNO(String tT_TI_KEYNO) {
		TT_TI_KEYNO = tT_TI_KEYNO;
	}
	public String getTT_DIVISION() {
		return TT_DIVISION;
	}
	public void setTT_DIVISION(String tT_DIVISION) {
		TT_DIVISION = tT_DIVISION;
	}
	public String getTT_APPLY() {
		return TT_APPLY;
	}
	public void setTT_APPLY(String tT_APPLY) {
		TT_APPLY = tT_APPLY;
	}
	public String getTT_CHE_DIVISION() {
		return TT_CHE_DIVISION;
	}
	public void setTT_CHE_DIVISION(String tT_CHE_DIVISION) {
		TT_CHE_DIVISION = tT_CHE_DIVISION;
	}
	
	public String getTT_FAX() {
		return TT_FAX;
	}
	public void setTT_FAX(String tT_FAX) {
		TT_FAX = tT_FAX;
	}
	public String getTT_TARGET() {
		return TT_TARGET;
	}
	public void setTT_TARGET(String tT_TARGET) {
		TT_TARGET = tT_TARGET;
	}
	public String getTT_BAE_NAME() {
		return TT_BAE_NAME;
	}
	public void setTT_BAE_NAME(String tT_BAE_NAME) {
		TT_BAE_NAME = tT_BAE_NAME;
	}
	public String getTT_BAE_CAPTAIN() {
		return TT_BAE_CAPTAIN;
	}
	public void setTT_BAE_CAPTAIN(String tT_BAE_CAPTAIN) {
		TT_BAE_CAPTAIN = tT_BAE_CAPTAIN;
	}
	public String getTT_INWON() {
		return TT_INWON;
	}
	public void setTT_INWON(String tT_INWON) {
		TT_INWON = tT_INWON;
	}
	public String getTT_BAE_TON() {
		return TT_BAE_TON;
	}
	public void setTT_BAE_TON(String tT_BAE_TON) {
		TT_BAE_TON = tT_BAE_TON;
	}
	public String getTT_BAE_START_TIME() {
		return TT_BAE_START_TIME;
	}
	public void setTT_BAE_START_TIME(String tT_BAE_START_TIME) {
		TT_BAE_START_TIME = tT_BAE_START_TIME;
	}
	public String getTT_TIME() {
		return TT_TIME;
	}
	public void setTT_TIME(String tT_TIME) {
		TT_TIME = tT_TIME;
	}
	public String getTT_BAE_PLACE() {
		return TT_BAE_PLACE;
	}
	public void setTT_BAE_PLACE(String tT_BAE_PLACE) {
		TT_BAE_PLACE = tT_BAE_PLACE;
	}
	public String getTT_BAE_END_TIME() {
		return TT_BAE_END_TIME;
	}
	public void setTT_BAE_END_TIME(String tT_BAE_END_TIME) {
		TT_BAE_END_TIME = tT_BAE_END_TIME;
	}
	
	public String getTT_COURCE() {
		return TT_COURCE;
	}
	public void setTT_COURCE(String tT_COURCE) {
		TT_COURCE = tT_COURCE;
	}
	public String getTT_WALK_DISTANCE() {
		return TT_WALK_DISTANCE;
	}
	public void setTT_WALK_DISTANCE(String tT_WALK_DISTANCE) {
		TT_WALK_DISTANCE = tT_WALK_DISTANCE;
	}
	
	public String getTT_START_PLACE() {
		return TT_START_PLACE;
	}
	public void setTT_START_PLACE(String tT_START_PLACE) {
		TT_START_PLACE = tT_START_PLACE;
	}
	public String getTT_END_PLACE() {
		return TT_END_PLACE;
	}
	public void setTT_END_PLACE(String tT_END_PLACE) {
		TT_END_PLACE = tT_END_PLACE;
	}
	public String getTT_WALK_MIDDLE_PLACE() {
		return TT_WALK_MIDDLE_PLACE;
	}
	public void setTT_WALK_MIDDLE_PLACE(String tT_WALK_MIDDLE_PLACE) {
		TT_WALK_MIDDLE_PLACE = tT_WALK_MIDDLE_PLACE;
	}
	public String getTT_WALK_NANIDO() {
		return TT_WALK_NANIDO;
	}
	public void setTT_WALK_NANIDO(String tT_WALK_NANIDO) {
		TT_WALK_NANIDO = tT_WALK_NANIDO;
	}
	public String getTT_WALK_BOLGEOLI() {
		return TT_WALK_BOLGEOLI;
	}
	public void setTT_WALK_BOLGEOLI(String tT_WALK_BOLGEOLI) {
		TT_WALK_BOLGEOLI = tT_WALK_BOLGEOLI;
	}
	public String getTT_TEMPLE_GUIDE() {
		return TT_TEMPLE_GUIDE;
	}
	public void setTT_TEMPLE_GUIDE(String tT_TEMPLE_GUIDE) {
		TT_TEMPLE_GUIDE = tT_TEMPLE_GUIDE;
	}
	public String getTT_TEMPLE_BOOKS_WAY() {
		return TT_TEMPLE_BOOKS_WAY;
	}
	public void setTT_TEMPLE_BOOKS_WAY(String tT_TEMPLE_BOOKS_WAY) {
		TT_TEMPLE_BOOKS_WAY = tT_TEMPLE_BOOKS_WAY;
	}
	public String getTT_TEMPLE_PROGRAM_NAME() {
		return TT_TEMPLE_PROGRAM_NAME;
	}
	public void setTT_TEMPLE_PROGRAM_NAME(String tT_TEMPLE_PROGRAM_NAME) {
		TT_TEMPLE_PROGRAM_NAME = tT_TEMPLE_PROGRAM_NAME;
	}
	public String getTT_TEMPLE_PROGRAM_CONTANT() {
		return TT_TEMPLE_PROGRAM_CONTANT;
	}
	public void setTT_TEMPLE_PROGRAM_CONTANT(String tT_TEMPLE_PROGRAM_CONTANT) {
		TT_TEMPLE_PROGRAM_CONTANT = tT_TEMPLE_PROGRAM_CONTANT;
	}
	public String getTT_TEMPLE_EFFECT() {
		return TT_TEMPLE_EFFECT;
	}
	public void setTT_TEMPLE_EFFECT(String tT_TEMPLE_EFFECT) {
		TT_TEMPLE_EFFECT = tT_TEMPLE_EFFECT;
	}
	public String getTT_TOWN_ORIGIN() {
		return TT_TOWN_ORIGIN;
	}
	public void setTT_TOWN_ORIGIN(String tT_TOWN_ORIGIN) {
		TT_TOWN_ORIGIN = tT_TOWN_ORIGIN;
	}
	public String getTT_TOWN_GREETING() {
		return TT_TOWN_GREETING;
	}
	public void setTT_TOWN_GREETING(String tT_TOWN_GREETING) {
		TT_TOWN_GREETING = tT_TOWN_GREETING;
	}
	public String getTT_TOWN_SPECIALTY() {
		return TT_TOWN_SPECIALTY;
	}
	public void setTT_TOWN_SPECIALTY(String tT_TOWN_SPECIALTY) {
		TT_TOWN_SPECIALTY = tT_TOWN_SPECIALTY;
	}
	public String getTT_TOWN_KEYNO() {
		return TT_TOWN_KEYNO;
	}
	public void setTT_TOWN_KEYNO(String tT_TOWN_KEYNO) {
		TT_TOWN_KEYNO = tT_TOWN_KEYNO;
	}
	public String getTT_TOWN_SALGEOLI() {
		return TT_TOWN_SALGEOLI;
	}
	public void setTT_TOWN_SALGEOLI(String tT_TOWN_SALGEOLI) {
		TT_TOWN_SALGEOLI = tT_TOWN_SALGEOLI;
	}
	public String getTT_SUP_MANAGE() {
		return TT_SUP_MANAGE;
	}
	public void setTT_SUP_MANAGE(String tT_SUP_MANAGE) {
		TT_SUP_MANAGE = tT_SUP_MANAGE;
	}
	public String getTT_SUP_KINDS() {
		return TT_SUP_KINDS;
	}
	public void setTT_SUP_KINDS(String tT_SUP_KINDS) {
		TT_SUP_KINDS = tT_SUP_KINDS;
	}
	public String getTCH_KEYNO() {
		return TCH_KEYNO;
	}
	public void setTCH_KEYNO(String tCH_KEYNO) {
		TCH_KEYNO = tCH_KEYNO;
	}
	public String getTCH_TC_KEYNO() {
		return TCH_TC_KEYNO;
	}
	public void setTCH_TC_KEYNO(String tCH_TC_KEYNO) {
		TCH_TC_KEYNO = tCH_TC_KEYNO;
	}
	public String getTCH_TI_KEYNO() {
		return TCH_TI_KEYNO;
	}
	public void setTCH_TI_KEYNO(String tCH_TI_KEYNO) {
		TCH_TI_KEYNO = tCH_TI_KEYNO;
	}
	public String getTCH_DIVISION() {
		return TCH_DIVISION;
	}
	public void setTCH_DIVISION(String tCH_DIVISION) {
		TCH_DIVISION = tCH_DIVISION;
	}
	public String getTCH_TYPE() {
		return TCH_TYPE;
	}
	public void setTCH_TYPE(String tCH_TYPE) {
		TCH_TYPE = tCH_TYPE;
	}
	public String getTCH_LOCATION() {
		return TCH_LOCATION;
	}
	public void setTCH_LOCATION(String tCH_LOCATION) {
		TCH_LOCATION = tCH_LOCATION;
	}
	public String getTCH_JIJEONG_DAY() {
		return TCH_JIJEONG_DAY;
	}
	public void setTCH_JIJEONG_DAY(String tCH_JIJEONG_DAY) {
		TCH_JIJEONG_DAY = tCH_JIJEONG_DAY;
	}
	public String getTCH_JIJEONG_NUM() {
		return TCH_JIJEONG_NUM;
	}
	public void setTCH_JIJEONG_NUM(String tCH_JIJEONG_NUM) {
		TCH_JIJEONG_NUM = tCH_JIJEONG_NUM;
	}
	public String getTCH_ERA() {
		return TCH_ERA;
	}
	public void setTCH_ERA(String tCH_ERA) {
		TCH_ERA = tCH_ERA;
	}
	public String getTF_KEYNO() {
		return TF_KEYNO;
	}
	public void setTF_KEYNO(String tF_KEYNO) {
		TF_KEYNO = tF_KEYNO;
	}
	public String getTF_TC_KEYNO() {
		return TF_TC_KEYNO;
	}
	public void setTF_TC_KEYNO(String tF_TC_KEYNO) {
		TF_TC_KEYNO = tF_TC_KEYNO;
	}
	public String getTF_TI_KEYNO() {
		return TF_TI_KEYNO;
	}
	public void setTF_TI_KEYNO(String tF_TI_KEYNO) {
		TF_TI_KEYNO = tF_TI_KEYNO;
	}
	public String getTF_START_TIME() {
		return TF_START_TIME;
	}
	public void setTF_START_TIME(String tF_START_TIME) {
		TF_START_TIME = tF_START_TIME;
	}
	public String getTF_END_TIME() {
		return TF_END_TIME;
	}
	public void setTF_END_TIME(String tF_END_TIME) {
		TF_END_TIME = tF_END_TIME;
	}
	public String getTF_JUGWAN() {
		return TF_JUGWAN;
	}
	public void setTF_JUGWAN(String tF_JUGWAN) {
		TF_JUGWAN = tF_JUGWAN;
	}
	public String getTF_PURPOSE() {
		return TF_PURPOSE;
	}
	public void setTF_PURPOSE(String tF_PURPOSE) {
		TF_PURPOSE = tF_PURPOSE;
	}
	public String getTF_PROGRAM() {
		return TF_PROGRAM;
	}
	public void setTF_PROGRAM(String tF_PROGRAM) {
		TF_PROGRAM = tF_PROGRAM;
	}
	public String getTF_TERM() {
		return TF_TERM;
	}
	public void setTF_TERM(String tF_TERM) {
		TF_TERM = tF_TERM;
	}
	public String getTF_NIGHT_STARTIME() {
		return TF_NIGHT_STARTIME;
	}
	public void setTF_NIGHT_STARTIME(String tF_NIGHT_STARTIME) {
		TF_NIGHT_STARTIME = tF_NIGHT_STARTIME;
	}
	public String getTF_NIGHT_ENDTIME() {
		return TF_NIGHT_ENDTIME;
	}
	public void setTF_NIGHT_ENDTIME(String tF_NIGHT_ENDTIME) {
		TF_NIGHT_ENDTIME = tF_NIGHT_ENDTIME;
	}
	public String getTCM_KEYNO() {
		return TCM_KEYNO;
	}
	public void setTCM_KEYNO(String tCM_KEYNO) {
		TCM_KEYNO = tCM_KEYNO;
	}
	public String getTCM_TC_KEYNO() {
		return TCM_TC_KEYNO;
	}
	public void setTCM_TC_KEYNO(String tCM_TC_KEYNO) {
		TCM_TC_KEYNO = tCM_TC_KEYNO;
	}
	public String getTCM_TI_KEYNO() {
		return TCM_TI_KEYNO;
	}
	public void setTCM_TI_KEYNO(String tCM_TI_KEYNO) {
		TCM_TI_KEYNO = tCM_TI_KEYNO;
	}
	public String getTCM_SEASON() {
		return TCM_SEASON;
	}
	public void setTCM_SEASON(String tCM_SEASON) {
		TCM_SEASON = tCM_SEASON;
	}
	public String getTCM_TIME() {
		return TCM_TIME;
	}
	public void setTCM_TIME(String tCM_TIME) {
		TCM_TIME = tCM_TIME;
	}
	public String getTCS_TITLE() {
		return TCS_TITLE;
	}
	public void setTCS_TITLE(String tCS_TITLE) {
		TCS_TITLE = tCS_TITLE;
	}
	public String getTCS_LAT() {
		return TCS_LAT;
	}
	public void setTCS_LAT(String tCS_LAT) {
		TCS_LAT = tCS_LAT;
	}
	public String getTCS_LNG() {
		return TCS_LNG;
	}
	public void setTCS_LNG(String tCS_LNG) {
		TCS_LNG = tCS_LNG;
	}
	public String getTCS_LEVEL() {
		return TCS_LEVEL;
	}
	public void setTCS_LEVEL(String tCS_LEVEL) {
		TCS_LEVEL = tCS_LEVEL;
	}
	public String getTCS_COMMENT() {
		return TCS_COMMENT;
	}
	public void setTCS_COMMENT(String tCS_COMMENT) {
		TCS_COMMENT = tCS_COMMENT;
	}
	public String getTCS_TYPE() {
		return TCS_TYPE;
	}
	public void setTCS_TYPE(String tCS_TYPE) {
		TCS_TYPE = tCS_TYPE;
	}
	public String getTCS_TYPE_KEYNO() {
		return TCS_TYPE_KEYNO;
	}
	public void setTCS_TYPE_KEYNO(String tCS_TYPE_KEYNO) {
		TCS_TYPE_KEYNO = tCS_TYPE_KEYNO;
	}
	public String getTA_KEYNO() {
		return TA_KEYNO;
	}
	public void setTA_KEYNO(String tA_KEYNO) {
		TA_KEYNO = tA_KEYNO;
	}
	public String getTA_TC_KEYNO() {
		return TA_TC_KEYNO;
	}
	public void setTA_TC_KEYNO(String tA_TC_KEYNO) {
		TA_TC_KEYNO = tA_TC_KEYNO;
	}
	public String getTA_TI_KEYNO() {
		return TA_TI_KEYNO;
	}
	public void setTA_TI_KEYNO(String tA_TI_KEYNO) {
		TA_TI_KEYNO = tA_TI_KEYNO;
	}
	public String getTA_DIVISION() {
		return TA_DIVISION;
	}
	public void setTA_DIVISION(String tA_DIVISION) {
		TA_DIVISION = tA_DIVISION;
	}
	public String getTA_GIGAN() {
		return TA_GIGAN;
	}
	public void setTA_GIGAN(String tA_GIGAN) {
		TA_GIGAN = tA_GIGAN;
	}
	public String getTA_YAGAN() {
		return TA_YAGAN;
	}
	public void setTA_YAGAN(String tA_YAGAN) {
		TA_YAGAN = tA_YAGAN;
	}
	public String getTA_SEASON() {
		return TA_SEASON;
	}
	public void setTA_SEASON(String tA_SEASON) {
		TA_SEASON = tA_SEASON;
	}
	public String getTA_SAN_SOGCHING() {
		return TA_SAN_SOGCHING;
	}
	public void setTA_SAN_SOGCHING(String tA_SAN_SOGCHING) {
		TA_SAN_SOGCHING = tA_SAN_SOGCHING;
	}
	public String getTA_SAN_SCALE() {
		return TA_SAN_SCALE;
	}
	public void setTA_SAN_SCALE(String tA_SAN_SCALE) {
		TA_SAN_SCALE = tA_SAN_SCALE;
	}
	public String getTA_SAN_HANJANAME() {
		return TA_SAN_HANJANAME;
	}
	public void setTA_SAN_HANJANAME(String tA_SAN_HANJANAME) {
		TA_SAN_HANJANAME = tA_SAN_HANJANAME;
	}
	public String getTA_BEACH_AREA() {
		return TA_BEACH_AREA;
	}
	public void setTA_BEACH_AREA(String tA_BEACH_AREA) {
		TA_BEACH_AREA = tA_BEACH_AREA;
	}
	public String getTA_BEACH_LONG() {
		return TA_BEACH_LONG;
	}
	public void setTA_BEACH_LONG(String tA_BEACH_LONG) {
		TA_BEACH_LONG = tA_BEACH_LONG;
	}
	public String getTA_BEACH_WIDTH() {
		return TA_BEACH_WIDTH;
	}
	public void setTA_BEACH_WIDTH(String tA_BEACH_WIDTH) {
		TA_BEACH_WIDTH = tA_BEACH_WIDTH;
	}
	public String getTA_BEACH_SHAPE() {
		return TA_BEACH_SHAPE;
	}
	public void setTA_BEACH_SHAPE(String tA_BEACH_SHAPE) {
		TA_BEACH_SHAPE = tA_BEACH_SHAPE;
	}
	public String getTA_BEACH_SLOPE() {
		return TA_BEACH_SLOPE;
	}
	public void setTA_BEACH_SLOPE(String tA_BEACH_SLOPE) {
		TA_BEACH_SLOPE = tA_BEACH_SLOPE;
	}
	public String getTA_BEACH_SAFE_DISTANCE() {
		return TA_BEACH_SAFE_DISTANCE;
	}
	public void setTA_BEACH_SAFE_DISTANCE(String tA_BEACH_SAFE_DISTANCE) {
		TA_BEACH_SAFE_DISTANCE = tA_BEACH_SAFE_DISTANCE;
	}
	public String getTA_SUM_AREA() {
		return TA_SUM_AREA;
	}
	public void setTA_SUM_AREA(String tA_SUM_AREA) {
		TA_SUM_AREA = tA_SUM_AREA;
	}
	public String getTA_SUM_GAGU_CNT() {
		return TA_SUM_GAGU_CNT;
	}
	public void setTA_SUM_GAGU_CNT(String tA_SUM_GAGU_CNT) {
		TA_SUM_GAGU_CNT = tA_SUM_GAGU_CNT;
	}
	public String getTG_NAME() {
		return TG_NAME;
	}
	public void setTG_NAME(String tG_NAME) {
		TG_NAME = tG_NAME;
	}
	public String getTG_SIZE_METER() {
		return TG_SIZE_METER;
	}
	public void setTG_SIZE_METER(String tG_SIZE_METER) {
		TG_SIZE_METER = tG_SIZE_METER;
	}
	
	public String getTG_PRICE_CONTENT() {
		return TG_PRICE_CONTENT;
	}
	public void setTG_PRICE_CONTENT(String tG_PRICE_CONTENT) {
		TG_PRICE_CONTENT = tG_PRICE_CONTENT;
	}
	public String getTG_SURCHARGE() {
		return TG_SURCHARGE;
	}
	public void setTG_SURCHARGE(String tG_SURCHARGE) {
		TG_SURCHARGE = tG_SURCHARGE;
	}
	public String getTG_LOW_SEASON_FEE() {
		return TG_LOW_SEASON_FEE;
	}
	public void setTG_LOW_SEASON_FEE(String tG_LOW_SEASON_FEE) {
		TG_LOW_SEASON_FEE = tG_LOW_SEASON_FEE;
	}
	public String getTG_SUMMER_SEASON_FEE() {
		return TG_SUMMER_SEASON_FEE;
	}
	public void setTG_SUMMER_SEASON_FEE(String tG_SUMMER_SEASON_FEE) {
		TG_SUMMER_SEASON_FEE = tG_SUMMER_SEASON_FEE;
	}
	public String getTG_WINTER_SEASON_FEE() {
		return TG_WINTER_SEASON_FEE;
	}
	public void setTG_WINTER_SEASON_FEE(String tG_WINTER_SEASON_FEE) {
		TG_WINTER_SEASON_FEE = tG_WINTER_SEASON_FEE;
	}
	public String getTG_INWON_MIN_CNT() {
		return TG_INWON_MIN_CNT;
	}
	public void setTG_INWON_MIN_CNT(String tG_INWON_MIN_CNT) {
		TG_INWON_MIN_CNT = tG_INWON_MIN_CNT;
	}
	public String getTG_GIJUN_INWON() {
		return TG_GIJUN_INWON;
	}
	public void setTG_GIJUN_INWON(String tG_GIJUN_INWON) {
		TG_GIJUN_INWON = tG_GIJUN_INWON;
	}
	public String getTG_INWON_MAX_CNT() {
		return TG_INWON_MAX_CNT;
	}
	public void setTG_INWON_MAX_CNT(String tG_INWON_MAX_CNT) {
		TG_INWON_MAX_CNT = tG_INWON_MAX_CNT;
	}

	public String getTG_IMG() {
		return TG_IMG;
	}
	public void setTG_IMG(String tG_IMG) {
		TG_IMG = tG_IMG;
	}
	public String getTG_SUMMARY() {
		return TG_SUMMARY;
	}
	public void setTG_SUMMARY(String tG_SUMMARY) {
		TG_SUMMARY = tG_SUMMARY;
	}
	public String getTG_SIZE_FLAT() {
		return TG_SIZE_FLAT;
	}
	public void setTG_SIZE_FLAT(String tG_SIZE_FLAT) {
		TG_SIZE_FLAT = tG_SIZE_FLAT;
	}
	public String getTC_KEYNO() {
		return TC_KEYNO;
	}
	public void setTC_KEYNO(String tC_KEYNO) {
		TC_KEYNO = tC_KEYNO;
	}
	public String getTC_TITLE() {
		return TC_TITLE;
	}
	public void setTC_TITLE(String tC_TITLE) {
		TC_TITLE = tC_TITLE;
	}
	public String getTC_SUBTITLE() {
		return TC_SUBTITLE;
	}
	public void setTC_SUBTITLE(String tC_SUBTITLE) {
		TC_SUBTITLE = tC_SUBTITLE;
	}
	public String getTC_TAG() {
		return TC_TAG;
	}
	public void setTC_TAG(String tC_TAG) {
		TC_TAG = tC_TAG;
	}
	public String getTC_THUMBNAIL() {
		return TC_THUMBNAIL;
	}
	public void setTC_THUMBNAIL(String tC_THUMBNAIL) {
		TC_THUMBNAIL = tC_THUMBNAIL;
	}
	public String getTC_SUMMARY() {
		return TC_SUMMARY;
	}
	public void setTC_SUMMARY(String tC_SUMMARY) {
		TC_SUMMARY = tC_SUMMARY;
	}
	public String getTC_CONTENTS() {
		return TC_CONTENTS;
	}
	public void setTC_CONTENTS(String tC_CONTENTS) {
		TC_CONTENTS = tC_CONTENTS;
	}
	public String getTC_PLACE() {
		return TC_PLACE;
	}
	public void setTC_PLACE(String tC_PLACE) {
		TC_PLACE = tC_PLACE;
	}
	public String getTC_ADDR() {
		return TC_ADDR;
	}
	public void setTC_ADDR(String tC_ADDR) {
		TC_ADDR = tC_ADDR;
	}
	public String getTC_ADDR2() {
		return TC_ADDR2;
	}
	public void setTC_ADDR2(String tC_ADDR2) {
		TC_ADDR2 = tC_ADDR2;
	}
	public String getTC_POST() {
		return TC_POST;
	}
	public void setTC_POST(String tC_POST) {
		TC_POST = tC_POST;
	}
	public String getTC_MANAGER() {
		return TC_MANAGER;
	}
	public void setTC_MANAGER(String tC_MANAGER) {
		TC_MANAGER = tC_MANAGER;
	}
	public String getTC_DEPARTMENT() {
		return TC_DEPARTMENT;
	}
	public void setTC_DEPARTMENT(String tC_DEPARTMENT) {
		TC_DEPARTMENT = tC_DEPARTMENT;
	}
	public String getTC_CONTACTS() {
		return TC_CONTACTS;
	}
	public void setTC_CONTACTS(String tC_CONTACTS) {
		TC_CONTACTS = tC_CONTACTS;
	}
	public String getTC_LAT() {
		return TC_LAT;
	}
	public void setTC_LAT(String tC_LAT) {
		TC_LAT = tC_LAT;
	}
	public String getTC_LNG() {
		return TC_LNG;
	}
	public void setTC_LNG(String tC_LNG) {
		TC_LNG = tC_LNG;
	}
	public String getTC_UP_CNT() {
		return TC_UP_CNT;
	}
	public void setTC_UP_CNT(String tC_UP_CNT) {
		TC_UP_CNT = tC_UP_CNT;
	}
	public String getTC_DICTIONARY() {
		return TC_DICTIONARY;
	}
	public void setTC_DICTIONARY(String tC_DICTIONARY) {
		TC_DICTIONARY = tC_DICTIONARY;
	}
	public String getTC_HOME_URL() {
		return TC_HOME_URL;
	}
	public void setTC_HOME_URL(String tC_HOME_URL) {
		TC_HOME_URL = tC_HOME_URL;
	}
	public String getTC_BLOG_URL() {
		return TC_BLOG_URL;
	}
	public void setTC_BLOG_URL(String tC_BLOG_URL) {
		TC_BLOG_URL = tC_BLOG_URL;
	}
	public String getTC_SNS_URL() {
		return TC_SNS_URL;
	}
	public void setTC_SNS_URL(String tC_SNS_URL) {
		TC_SNS_URL = tC_SNS_URL;
	}
	public String getTC_RESERVATION_URL() {
		return TC_RESERVATION_URL;
	}
	public void setTC_RESERVATION_URL(String tC_RESERVATION_URL) {
		TC_RESERVATION_URL = tC_RESERVATION_URL;
	}
	public String getTC_WAY_JAGA() {
		return TC_WAY_JAGA;
	}
	public void setTC_WAY_JAGA(String tC_WAY_JAGA) {
		TC_WAY_JAGA = tC_WAY_JAGA;
	}
	public String getTC_WAY_PUBLIC() {
		return TC_WAY_PUBLIC;
	}
	public void setTC_WAY_PUBLIC(String tC_WAY_PUBLIC) {
		TC_WAY_PUBLIC = tC_WAY_PUBLIC;
	}
	public String getTC_WAY_GUIDE() {
		return TC_WAY_GUIDE;
	}
	public void setTC_WAY_GUIDE(String tC_WAY_GUIDE) {
		TC_WAY_GUIDE = tC_WAY_GUIDE;
	}
	public String getTC_TYPE() {
		return TC_TYPE;
	}
	public void setTC_TYPE(String tC_TYPE) {
		TC_TYPE = tC_TYPE;
	}
	public String getTC_USE() {
		return TC_USE;
	}
	public void setTC_USE(String tC_USE) {
		TC_USE = tC_USE;
	}
	public String getTI_KEYNO() {
		return TI_KEYNO;
	}
	public void setTI_KEYNO(String tI_KEYNO) {
		TI_KEYNO = tI_KEYNO;
	}
	public String getTI_TIME() {
		return TI_TIME;
	}
	public void setTI_TIME(String tI_TIME) {
		TI_TIME = tI_TIME;
	}
	public String getTI_DETAIL() {
		return TI_DETAIL;
	}
	public void setTI_DETAIL(String tI_DETAIL) {
		TI_DETAIL = tI_DETAIL;
	}
	public String getTI_ENTRANCE_FEE() {
		return TI_ENTRANCE_FEE;
	}
	public void setTI_ENTRANCE_FEE(String tI_ENTRANCE_FEE) {
		TI_ENTRANCE_FEE = tI_ENTRANCE_FEE;
	}
	public String getTI_CLOSED_DAY() {
		return TI_CLOSED_DAY;
	}
	public void setTI_CLOSED_DAY(String tI_CLOSED_DAY) {
		TI_CLOSED_DAY = tI_CLOSED_DAY;
	}
	public String getTI_PARKING_YN() {
		return TI_PARKING_YN;
	}
	public void setTI_PARKING_YN(String tI_PARKING_YN) {
		TI_PARKING_YN = tI_PARKING_YN;
	}
	public String getTI_PARKING_PLACE() {
		return TI_PARKING_PLACE;
	}
	public void setTI_PARKING_PLACE(String tI_PARKING_PLACE) {
		TI_PARKING_PLACE = tI_PARKING_PLACE;
	}
	public String getTI_BUDAE_SISEOL() {
		return TI_BUDAE_SISEOL;
	}
	public void setTI_BUDAE_SISEOL(String tI_BUDAE_SISEOL) {
		TI_BUDAE_SISEOL = tI_BUDAE_SISEOL;
	}
	public String getTI_CONVENIENCE_SISEOL() {
		return TI_CONVENIENCE_SISEOL;
	}
	public void setTI_CONVENIENCE_SISEOL(String tI_CONVENIENCE_SISEOL) {
		TI_CONVENIENCE_SISEOL = tI_CONVENIENCE_SISEOL;
	}
	public String getTI_ETC_SISEOL() {
		return TI_ETC_SISEOL;
	}
	public void setTI_ETC_SISEOL(String tI_ETC_SISEOL) {
		TI_ETC_SISEOL = tI_ETC_SISEOL;
	}
	public String getTI_ETC_DETAIL() {
		return TI_ETC_DETAIL;
	}
	public void setTI_ETC_DETAIL(String tI_ETC_DETAIL) {
		TI_ETC_DETAIL = tI_ETC_DETAIL;
	}
	public String getTI_LANG_SERVICE() {
		return TI_LANG_SERVICE;
	}
	public void setTI_LANG_SERVICE(String tI_LANG_SERVICE) {
		TI_LANG_SERVICE = tI_LANG_SERVICE;
	}
	public String getTA_SUM_TYPE() {
		return TA_SUM_TYPE;
	}
	public void setTA_SUM_TYPE(String tA_SUM_TYPE) {
		TA_SUM_TYPE = tA_SUM_TYPE;
	}
	public String getTA_SUM_COASTLINE() {
		return TA_SUM_COASTLINE;
	}
	public void setTA_SUM_COASTLINE(String tA_SUM_COASTLINE) {
		TA_SUM_COASTLINE = tA_SUM_COASTLINE;
	}
	public String getTG_ORDER() {
		return TG_ORDER;
	}
	public void setTG_ORDER(String tG_ORDER) {
		TG_ORDER = tG_ORDER;
	}
	public String getTM_TR_KEYNO() {
		return TM_TR_KEYNO;
	}
	public void setTM_TR_KEYNO(String tM_TR_KEYNO) {
		TM_TR_KEYNO = tM_TR_KEYNO;
	}
	public String getTG_TL_KEYNO() {
		return TG_TL_KEYNO;
	}
	public String getTA_TIME() {
		return TA_TIME;
	}
	public void setTA_TIME(String tA_TIME) {
		TA_TIME = tA_TIME;
	}
	public void setTG_TL_KEYNO(String tG_TL_KEYNO) {
		TG_TL_KEYNO = tG_TL_KEYNO;
	}
	public String getTM_NAME() {
		return TM_NAME;
	}
	public void setTM_NAME(String tM_NAME) {
		TM_NAME = tM_NAME;
	}
	public String getTM_PRICE() {
		return TM_PRICE;
	}
	public void setTM_PRICE(String tM_PRICE) {
		TM_PRICE = tM_PRICE;
	}
	public String getTM_IMG() {
		return TM_IMG;
	}
	public void setTM_IMG(String tM_IMG) {
		TM_IMG = tM_IMG;
	}
	public String getTM_SUMMARY() {
		return TM_SUMMARY;
	}
	public void setTM_SUMMARY(String tM_SUMMARY) {
		TM_SUMMARY = tM_SUMMARY;
	}
	public String getTM_ORDER() {
		return TM_ORDER;
	}
	public void setTM_ORDER(String tM_ORDER) {
		TM_ORDER = tM_ORDER;
	}
	public String getTL_KEYNO() {
		return TL_KEYNO;
	}
	public void setTL_KEYNO(String tL_KEYNO) {
		TL_KEYNO = tL_KEYNO;
	}
	public String getTL_DIVISION() {
		return TL_DIVISION;
	}
	public void setTL_DIVISION(String tL_DIVISION) {
		TL_DIVISION = tL_DIVISION;
	}
	public String getTL_TEL() {
		return TL_TEL;
	}
	public void setTL_TEL(String tL_TEL) {
		TL_TEL = tL_TEL;
	}
	public String getTL_IBSIL_TIME() {
		return TL_IBSIL_TIME;
	}
	public void setTL_IBSIL_TIME(String tL_IBSIL_TIME) {
		TL_IBSIL_TIME = tL_IBSIL_TIME;
	}
	public String getTL_TOESIL_TIME() {
		return TL_TOESIL_TIME;
	}
	public void setTL_TOESIL_TIME(String tL_TOESIL_TIME) {
		TL_TOESIL_TIME = tL_TOESIL_TIME;
	}
	public String getTL_GUBI_SISEOL() {
		return TL_GUBI_SISEOL;
	}
	public void setTL_GUBI_SISEOL(String tL_GUBI_SISEOL) {
		TL_GUBI_SISEOL = tL_GUBI_SISEOL;
	}
	public String getTL_USE_JOGEON() {
		return TL_USE_JOGEON;
	}
	public void setTL_USE_JOGEON(String tL_USE_JOGEON) {
		TL_USE_JOGEON = tL_USE_JOGEON;
	}
	public String getTL_USE_RULE() {
		return TL_USE_RULE;
	}
	public void setTL_USE_RULE(String tL_USE_RULE) {
		TL_USE_RULE = tL_USE_RULE;
	}
	public String getTL_BREAKFAST_YN() {
		return TL_BREAKFAST_YN;
	}
	public void setTL_BREAKFAST_YN(String tL_BREAKFAST_YN) {
		TL_BREAKFAST_YN = tL_BREAKFAST_YN;
	}
	public String getTL_BEDROOM_CNT() {
		return TL_BEDROOM_CNT;
	}
	public void setTL_BEDROOM_CNT(String tL_BEDROOM_CNT) {
		TL_BEDROOM_CNT = tL_BEDROOM_CNT;
	}
	public String getTL_ONDOLROOM_CNT() {
		return TL_ONDOLROOM_CNT;
	}
	public void setTL_ONDOLROOM_CNT(String tL_ONDOLROOM_CNT) {
		TL_ONDOLROOM_CNT = tL_ONDOLROOM_CNT;
	}
	public String getTL_GROUPROOM_CNT() {
		return TL_GROUPROOM_CNT;
	}
	public void setTL_GROUPROOM_CNT(String tL_GROUPROOM_CNT) {
		TL_GROUPROOM_CNT = tL_GROUPROOM_CNT;
	}
	public String getTL_CAMPING_SISEOL() {
		return TL_CAMPING_SISEOL;
	}
	public void setTL_CAMPING_SISEOL(String tL_CAMPING_SISEOL) {
		TL_CAMPING_SISEOL = tL_CAMPING_SISEOL;
	}
	public String getTL_WIFI_YN() {
		return TL_WIFI_YN;
	}
	public void setTL_WIFI_YN(String tL_WIFI_YN) {
		TL_WIFI_YN = tL_WIFI_YN;
	}
	public String getTL_TC_KEYNO() {
		return TL_TC_KEYNO;
	}
	public void setTL_TC_KEYNO(String tL_TC_KEYNO) {
		TL_TC_KEYNO = tL_TC_KEYNO;
	}
	public String getTR_KEYNO() {
		return TR_KEYNO;
	}
	public void setTR_KEYNO(String tR_KEYNO) {
		TR_KEYNO = tR_KEYNO;
	}
	public String getTR_DIVISION() {
		return TR_DIVISION;
	}
	public void setTR_DIVISION(String tR_DIVISION) {
		TR_DIVISION = tR_DIVISION;
	}
	public String getTR_TC_KEYNO() {
		return TR_TC_KEYNO;
	}
	public void setTR_TC_KEYNO(String tR_TC_KEYNO) {
		TR_TC_KEYNO = tR_TC_KEYNO;
	}
	public String getTR_GUBI_SISEOL() {
		return TR_GUBI_SISEOL;
	}
	public void setTR_GUBI_SISEOL(String tR_GUBI_SISEOL) {
		TR_GUBI_SISEOL = tR_GUBI_SISEOL;
	}
	public String getTR_FOOD_TYPE() {
		return TR_FOOD_TYPE;
	}
	public void setTR_FOOD_TYPE(String tR_FOOD_TYPE) {
		TR_FOOD_TYPE = tR_FOOD_TYPE;
	}
	
	public String getTR_START_TIME() {
		return TR_START_TIME;
	}
	public void setTR_START_TIME(String tR_START_TIME) {
		TR_START_TIME = tR_START_TIME;
	}
	public String getTR_END_TIME() {
		return TR_END_TIME;
	}
	public void setTR_END_TIME(String tR_END_TIME) {
		TR_END_TIME = tR_END_TIME;
	}
	public String getTR_PACKING_YN() {
		return TR_PACKING_YN;
	}
	public void setTR_PACKING_YN(String tR_PACKING_YN) {
		TR_PACKING_YN = tR_PACKING_YN;
	}
	public String getTR_HOLIDAY() {
		return TR_HOLIDAY;
	}
	public void setTR_HOLIDAY(String tR_HOLIDAY) {
		TR_HOLIDAY = tR_HOLIDAY;
	}
	public String getTR_PETS_YN() {
		return TR_PETS_YN;
	}
	public void setTR_PETS_YN(String tR_PETS_YN) {
		TR_PETS_YN = tR_PETS_YN;
	}
	public String getTR_WIFI_YN() {
		return TR_WIFI_YN;
	}
	public void setTR_WIFI_YN(String tR_WIFI_YN) {
		TR_WIFI_YN = tR_WIFI_YN;
	}
	public String getTR_STROLLER_YN() {
		return TR_STROLLER_YN;
	}
	public void setTR_STROLLER_YN(String tR_STROLLER_YN) {
		TR_STROLLER_YN = tR_STROLLER_YN;
	}
	public String getTR_ROOM_CNT() {
		return TR_ROOM_CNT;
	}
	public void setTR_ROOM_CNT(String tR_ROOM_CNT) {
		TR_ROOM_CNT = tR_ROOM_CNT;
	}
	public String getTR_SMOKING_CNT() {
		return TR_SMOKING_CNT;
	}
	public void setTR_SMOKING_CNT(String tR_SMOKING_CNT) {
		TR_SMOKING_CNT = tR_SMOKING_CNT;
	}
	public String getTR_SEAT_CNT() {
		return TR_SEAT_CNT;
	}
	public void setTR_SEAT_CNT(String tR_SEAT_CNT) {
		TR_SEAT_CNT = tR_SEAT_CNT;
	}
	public String getTL_PRICE_CONTENT() {
		return TL_PRICE_CONTENT;
	}
	public void setTL_PRICE_CONTENT(String tL_PRICE_CONTENT) {
		TL_PRICE_CONTENT = tL_PRICE_CONTENT;
	}
	public String getTCM_TYPE() {
		return TCM_TYPE;
	}
	public void setTCM_TYPE(String tCM_TYPE) {
		TCM_TYPE = tCM_TYPE;
	}
	public String getTC_CONTACT() {
		return TC_CONTACT;
	}
	public void setTC_CONTACT(String tC_CONTACT) {
		TC_CONTACT = tC_CONTACT;
	}
	public String getTC_CONTACT2() {
		return TC_CONTACT2;
	}
	public void setTC_CONTACT2(String tC_CONTACT2) {
		TC_CONTACT2 = tC_CONTACT2;
	}
	public String getTL_EUB() {
		return TL_EUB;
	}
	public void setTL_EUB(String tL_EUB) {
		TL_EUB = tL_EUB;
	}
	public String getTL_OWNER() {
		return TL_OWNER;
	}
	public void setTL_OWNER(String tL_OWNER) {
		TL_OWNER = tL_OWNER;
	}
	public String getTC_REPLY_YN() {
		return TC_REPLY_YN;
	}
	public void setTC_REPLY_YN(String tC_REPLY_YN) {
		TC_REPLY_YN = tC_REPLY_YN;
	}
	public String getTCS_AUTO_DISTANCE() {
		return TCS_AUTO_DISTANCE;
	}
	public void setTCS_AUTO_DISTANCE(String tCS_AUTO_DISTANCE) {
		TCS_AUTO_DISTANCE = tCS_AUTO_DISTANCE;
	}
	public String getTCS_DISTANCE() {
		return TCS_DISTANCE;
	}
	public void setTCS_DISTANCE(String tCS_DISTANCE) {
		TCS_DISTANCE = tCS_DISTANCE;
	}
	public String getTCS_TIME() {
		return TCS_TIME;
	}
	public void setTCS_TIME(String tCS_TIME) {
		TCS_TIME = tCS_TIME;
	}
	public String getTCS_POSITON_TYPE() {
		return TCS_POSITON_TYPE;
	}
	public void setTCS_POSITON_TYPE(String tCS_POSITON_TYPE) {
		TCS_POSITON_TYPE = tCS_POSITON_TYPE;
	}
	
	
}
