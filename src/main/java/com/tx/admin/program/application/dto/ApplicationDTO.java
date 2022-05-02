package com.tx.admin.program.application.dto;

import com.tx.common.dto.Common;

/**
 * 프로그램 신청 DTO
 * @author admin
 *
 */
public class ApplicationDTO extends Common {
	
	private static final long serialVersionUID = -6182340712352883221L;
	private String  
		/* T_APPLICAITON_MANAGER */
		  AP_KEYNO
		, AP_NAME
		, AP_SUMMARY
		, AP_LIMIT_AGE_YN
		, AP_LIMIT_AGE_MIN
		, AP_LIMIT_AGE_MAX
		, AP_PLACE
		, AP_PRICE
		, AP_STDT
		, AP_ENDT
		, AP_DATE_COMMENT
		, AP_REGDT
		, AP_MODDT
		, AP_REGNM
		, AP_MODNM
		, AP_USE
		, AP_USE_NM
		, AP_SEAT_YN
		, AP_LIMIT_PERSON
		, AP_APPLY_ST_DATE
		, AP_APPLY_EN_DATE
		, AP_DEADLINE
		, AP_BUTTON_TEXT1
		, AP_BUTTON_TEXT2
		, AP_BUTTON_TEXT3
		, AP_TICKET_CNT
		, AP_HOILDAY
		, AP_TYPE
		, AP_WAITING_YN
		, AP_WAITING_TEXT
		, AP_EXPIRED
		
		/* T_APPLICATION_CHARGE */
		, APC_KEYNO
		, APC_AP_KEYNO
		, APC_NAME
		, APC_PRICE
		, APC_TARGET
		, APC_DELYN
		
		/* T_APPLICATION_PARTICIPATE */
		, APP_KEYNO
		, APP_AP_KEYNO
		, APP_ASM_KEYNO
		, APP_APU_KEYNO
		, APP_DELYN
		, APP_ST_DATE
		, APP_ST_TIME
		, APP_COUNT
		, APP_REGDT
		, APP_ASS_KEYNO
		, APP_SEQUENCE
		, APP_STATUS
		, APP_DIVISION
		, APP_EXPIRED
		
		, App_type
		
		/*T_APPLY_PARTICIPATE_DISCOUNT*/
		, APD_AD_KEYNO
		, APD_APP_KEYNO
		, APD_CNT
		, APD_PRICE
		
		/* T_APPLICATION_SCHEDULE_MAIN */
		, ASM_KEYNO
		, ASM_AP_KEYNO
		, ASM_NAME
		, ASM_STDT
		, ASM_ENDT
		, ASM_DELYN
		, ASM_DAY
		
		/* T_APPLICATION_SCHEDULE_SUB */
		, ASS_KEYNO
		, ASS_ASM_KEYNO
		, ASS_ST_TIME
		, ASS_EN_TIME
		, ASS_MAXIMUM
		, ASS_SUBTITLE
		
		/* T_APPLICATION_USER */
		, APU_KEYNO
		, APU_UI_KEYNO
		, APU_NAME
		, APU_RELATION
		, APU_PHONE
		, APU_BIRTH
		, APU_DELYN
		, APU_REGDT
		, APU_GENDER
		, APU_SELFYN
		
		/* T_APPLICATION_DISCOUNT */
		, AD_KEYNO
		, AD_NAME
		, AD_TYPE
		, AD_MONEY
		, AD_COMENT
		, AD_DEFAULT_YN
		, AD_USE
		;
	
	
	
	
	public String getAP_LIMIT_PERSON() {
		return AP_LIMIT_PERSON;
	}

	public void setAP_LIMIT_PERSON(String aP_LIMIT_PERSON) {
		AP_LIMIT_PERSON = aP_LIMIT_PERSON;
	}

	public String getAD_USE() {
		return AD_USE;
	}

	public void setAD_USE(String aD_USE) {
		AD_USE = aD_USE;
	}

	public String getAD_TYPE() {
		return AD_TYPE;
	}

	public void setAD_TYPE(String aD_TYPE) {
		AD_TYPE = aD_TYPE;
	}

	public String getAD_MONEY() {
		return AD_MONEY;
	}

	public void setAD_MONEY(String aD_MONEY) {
		AD_MONEY = aD_MONEY;
	}

	public String getAD_DEFAULT_YN() {
		return AD_DEFAULT_YN;
	}

	public void setAD_DEFAULT_YN(String aD_DEFAULT_YN) {
		AD_DEFAULT_YN = aD_DEFAULT_YN;
	}

	public String getAD_KEYNO() {
		return AD_KEYNO;
	}

	public void setAD_KEYNO(String aD_KEYNO) {
		AD_KEYNO = aD_KEYNO;
	}

	public String getAD_NAME() {
		return AD_NAME;
	}

	public void setAD_NAME(String aD_NAME) {
		AD_NAME = aD_NAME;
	}

	public String getAD_COMENT() {
		return AD_COMENT;
	}

	public void setAD_COMENT(String aD_COMENT) {
		AD_COMENT = aD_COMENT;
	}

	public String getAP_SEAT_YN() {
		return AP_SEAT_YN;
	}

	public void setAP_SEAT_YN(String aP_SEAT_YN) {
		AP_SEAT_YN = aP_SEAT_YN;
	}

	public String getAP_USE() {
		return AP_USE;
	}

	public void setAP_USE(String aP_USE) {
		AP_USE = aP_USE;
	}

	public String getAPC_AP_KEYNO() {
		return APC_AP_KEYNO;
	}

	public void setAPC_AP_KEYNO(String aPC_AP_KEYNO) {
		APC_AP_KEYNO = aPC_AP_KEYNO;
	}

	public String getAP_KEYNO() {
		return AP_KEYNO;
	}

	public void setAP_KEYNO(String aP_KEYNO) {
		AP_KEYNO = aP_KEYNO;
	}

	public String getAP_NAME() {
		return AP_NAME;
	}

	public void setAP_NAME(String aP_NAME) {
		AP_NAME = aP_NAME;
	}

	public String getAP_SUMMARY() {
		return AP_SUMMARY;
	}

	public void setAP_SUMMARY(String aP_SUMMARY) {
		AP_SUMMARY = aP_SUMMARY;
	}

	public String getAP_LIMIT_AGE_YN() {
		return AP_LIMIT_AGE_YN;
	}

	public void setAP_LIMIT_AGE_YN(String aP_LIMIT_AGE_YN) {
		AP_LIMIT_AGE_YN = aP_LIMIT_AGE_YN;
	}

	public String getAP_LIMIT_AGE_MIN() {
		return AP_LIMIT_AGE_MIN;
	}

	public void setAP_LIMIT_AGE_MIN(String aP_LIMIT_AGE_MIN) {
		AP_LIMIT_AGE_MIN = aP_LIMIT_AGE_MIN;
	}

	public String getAP_LIMIT_AGE_MAX() {
		return AP_LIMIT_AGE_MAX;
	}

	public void setAP_LIMIT_AGE_MAX(String aP_LIMIT_AGE_MAX) {
		AP_LIMIT_AGE_MAX = aP_LIMIT_AGE_MAX;
	}

	public String getAP_PLACE() {
		return AP_PLACE;
	}

	public void setAP_PLACE(String aP_PLACE) {
		AP_PLACE = aP_PLACE;
	}

	public String getAP_PRICE() {
		return AP_PRICE;
	}

	public void setAP_PRICE(String aP_PRICE) {
		AP_PRICE = aP_PRICE;
	}

	public String getAP_STDT() {
		return AP_STDT;
	}

	public void setAP_STDT(String aP_STDT) {
		AP_STDT = aP_STDT;
	}

	public String getAP_ENDT() {
		return AP_ENDT;
	}

	public void setAP_ENDT(String aP_ENDT) {
		AP_ENDT = aP_ENDT;
	}

	public String getAP_DATE_COMMENT() {
		return AP_DATE_COMMENT;
	}

	public void setAP_DATE_COMMENT(String aP_DATE_COMMENT) {
		AP_DATE_COMMENT = aP_DATE_COMMENT;
	}

	public String getAP_REGDT() {
		return AP_REGDT;
	}

	public void setAP_REGDT(String aP_REGDT) {
		AP_REGDT = aP_REGDT;
	}

	public String getAP_MODDT() {
		return AP_MODDT;
	}

	public void setAP_MODDT(String aP_MODDT) {
		AP_MODDT = aP_MODDT;
	}

	public String getAP_REGNM() {
		return AP_REGNM;
	}

	public void setAP_REGNM(String aP_REGNM) {
		AP_REGNM = aP_REGNM;
	}

	public String getAP_MODNM() {
		return AP_MODNM;
	}

	public void setAP_MODNM(String aP_MODNM) {
		AP_MODNM = aP_MODNM;
	}

	public String getAPC_KEYNO() {
		return APC_KEYNO;
	}

	public void setAPC_KEYNO(String aPC_KEYNO) {
		APC_KEYNO = aPC_KEYNO;
	}

	public String getAPC_NAME() {
		return APC_NAME;
	}

	public void setAPC_NAME(String aPC_NAME) {
		APC_NAME = aPC_NAME;
	}

	public String getAPC_PRICE() {
		return APC_PRICE;
	}

	public void setAPC_PRICE(String aPC_PRICE) {
		APC_PRICE = aPC_PRICE;
	}

	public String getAPC_TARGET() {
		return APC_TARGET;
	}

	public void setAPC_TARGET(String aPC_TARGET) {
		APC_TARGET = aPC_TARGET;
	}

	public String getAPC_DELYN() {
		return APC_DELYN;
	}

	public void setAPC_DELYN(String aPC_DELYN) {
		APC_DELYN = aPC_DELYN;
	}

	public String getAPP_KEYNO() {
		return APP_KEYNO;
	}

	public void setAPP_KEYNO(String aPP_KEYNO) {
		APP_KEYNO = aPP_KEYNO;
	}

	public String getAPP_AP_KEYNO() {
		return APP_AP_KEYNO;
	}

	public void setAPP_AP_KEYNO(String aPP_AP_KEYNO) {
		APP_AP_KEYNO = aPP_AP_KEYNO;
	}

	public String getAPP_ASM_KEYNO() {
		return APP_ASM_KEYNO;
	}

	public void setAPP_ASM_KEYNO(String aPP_ASM_KEYNO) {
		APP_ASM_KEYNO = aPP_ASM_KEYNO;
	}

	public String getAPP_APU_KEYNO() {
		return APP_APU_KEYNO;
	}

	public void setAPP_APU_KEYNO(String aPP_APU_KEYNO) {
		APP_APU_KEYNO = aPP_APU_KEYNO;
	}

	public String getAPP_DELYN() {
		return APP_DELYN;
	}

	public void setAPP_DELYN(String aPP_DELYN) {
		APP_DELYN = aPP_DELYN;
	}

	public String getASM_KEYNO() {
		return ASM_KEYNO;
	}

	public void setASM_KEYNO(String aSM_KEYNO) {
		ASM_KEYNO = aSM_KEYNO;
	}

	public String getASM_AP_KEYNO() {
		return ASM_AP_KEYNO;
	}

	public void setASM_AP_KEYNO(String aSM_AP_KEYNO) {
		ASM_AP_KEYNO = aSM_AP_KEYNO;
	}

	public String getASM_NAME() {
		return ASM_NAME;
	}

	public void setASM_NAME(String aSM_NAME) {
		ASM_NAME = aSM_NAME;
	}

	public String getASM_STDT() {
		return ASM_STDT;
	}

	public void setASM_STDT(String aSM_STDT) {
		ASM_STDT = aSM_STDT;
	}

	public String getASM_ENDT() {
		return ASM_ENDT;
	}

	public void setASM_ENDT(String aSM_ENDT) {
		ASM_ENDT = aSM_ENDT;
	}

	public String getASM_DAY() {
		return ASM_DAY;
	}

	public void setASM_DAY(String aSM_DAY) {
		ASM_DAY = aSM_DAY;
	}

	public String getASM_DELYN() {
		return ASM_DELYN;
	}

	public void setASM_DELYN(String aSM_DELYN) {
		ASM_DELYN = aSM_DELYN;
	}

	public String getASS_KEYNO() {
		return ASS_KEYNO;
	}

	public void setASS_KEYNO(String aSS_KEYNO) {
		ASS_KEYNO = aSS_KEYNO;
	}

	public String getASS_ASM_KEYNO() {
		return ASS_ASM_KEYNO;
	}

	public void setASS_ASM_KEYNO(String aSS_ASM_KEYNO) {
		ASS_ASM_KEYNO = aSS_ASM_KEYNO;
	}
	
	public String getASS_MAXIMUM() {
		return ASS_MAXIMUM;
	}

	public void setASS_MAXIMUM(String aSS_MAXIMUM) {
		ASS_MAXIMUM = aSS_MAXIMUM;
	}

	public String getASS_SUBTITLE() {
		return ASS_SUBTITLE;
	}

	public void setASS_SUBTITLE(String aSS_SUBTITLE) {
		ASS_SUBTITLE = aSS_SUBTITLE;
	}

	public String getASS_ST_TIME() {
		return ASS_ST_TIME;
	}

	public void setASS_ST_TIME(String aSS_ST_TIME) {
		ASS_ST_TIME = aSS_ST_TIME;
	}

	public String getASS_EN_TIME() {
		return ASS_EN_TIME;
	}

	public void setASS_EN_TIME(String aSS_EN_TIME) {
		ASS_EN_TIME = aSS_EN_TIME;
	}

	public String getAPU_KEYNO() {
		return APU_KEYNO;
	}

	public void setAPU_KEYNO(String aPU_KEYNO) {
		APU_KEYNO = aPU_KEYNO;
	}

	public String getAPU_UI_KEYNO() {
		return APU_UI_KEYNO;
	}

	public void setAPU_UI_KEYNO(String aPU_UI_KEYNO) {
		APU_UI_KEYNO = aPU_UI_KEYNO;
	}

	public String getAPU_NAME() {
		return APU_NAME;
	}

	public void setAPU_NAME(String aPU_NAME) {
		APU_NAME = aPU_NAME;
	}

	public String getAPU_RELATION() {
		return APU_RELATION;
	}

	public void setAPU_RELATION(String aPU_RELATION) {
		APU_RELATION = aPU_RELATION;
	}

	public String getAPU_PHONE() {
		return APU_PHONE;
	}

	public void setAPU_PHONE(String aPU_PHONE) {
		APU_PHONE = aPU_PHONE;
	}

	public String getAPU_BIRTH() {
		return APU_BIRTH;
	}

	public void setAPU_BIRTH(String aPU_BIRTH) {
		APU_BIRTH = aPU_BIRTH;
	}

	public String getAPU_DELYN() {
		return APU_DELYN;
	}

	public void setAPU_DELYN(String aPU_DELYN) {
		APU_DELYN = aPU_DELYN;
	}

	public String getAPU_REGDT() {
		return APU_REGDT;
	}

	public void setAPU_REGDT(String aPU_REGDT) {
		APU_REGDT = aPU_REGDT;
	}

	public String getAPP_ST_DATE() {
		return APP_ST_DATE;
	}

	public void setAPP_ST_DATE(String aPP_ST_DATE) {
		APP_ST_DATE = aPP_ST_DATE;
	}

	public String getAPP_ST_TIME() {
		return APP_ST_TIME;
	}

	public void setAPP_ST_TIME(String aPP_ST_TIME) {
		APP_ST_TIME = aPP_ST_TIME;
	}

	public String getAPP_COUNT() {
		return APP_COUNT;
	}

	public void setAPP_COUNT(String aPP_COUNT) {
		APP_COUNT = aPP_COUNT;
	}

	public String getAPP_REGDT() {
		return APP_REGDT;
	}

	public void setAPP_REGDT(String aPP_REGDT) {
		APP_REGDT = aPP_REGDT;
	}

	public String getAPP_ASS_KEYNO() {
		return APP_ASS_KEYNO;
	}

	public void setAPP_ASS_KEYNO(String aPP_ASS_KEYNO) {
		APP_ASS_KEYNO = aPP_ASS_KEYNO;
	}

	public String getAPP_SEQUENCE() {
		return APP_SEQUENCE;
	}

	public void setAPP_SEQUENCE(String aPP_SEQUENCE) {
		APP_SEQUENCE = aPP_SEQUENCE;
	}

	public String getAPD_AD_KEYNO() {
		return APD_AD_KEYNO;
	}

	public void setAPD_AD_KEYNO(String aPD_AD_KEYNO) {
		APD_AD_KEYNO = aPD_AD_KEYNO;
	}

	public String getAPD_APP_KEYNO() {
		return APD_APP_KEYNO;
	}

	public void setAPD_APP_KEYNO(String aPD_APP_KEYNO) {
		APD_APP_KEYNO = aPD_APP_KEYNO;
	}

	public String getAPD_CNT() {
		return APD_CNT;
	}

	public void setAPD_CNT(String aPD_CNT) {
		APD_CNT = aPD_CNT;
	}

	public String getAPD_PRICE() {
		return APD_PRICE;
	}

	public void setAPD_PRICE(String aPD_PRICE) {
		APD_PRICE = aPD_PRICE;
	}

	public String getApp_type() {
		return App_type;
	}

	public void setApp_type(String app_type) {
		App_type = app_type;
	}

	public String getAP_APPLY_ST_DATE() {
		return AP_APPLY_ST_DATE;
	}

	public void setAP_APPLY_ST_DATE(String aP_APPLY_ST_DATE) {
		AP_APPLY_ST_DATE = aP_APPLY_ST_DATE;
	}

	public String getAP_APPLY_EN_DATE() {
		return AP_APPLY_EN_DATE;
	}

	public void setAP_APPLY_EN_DATE(String aP_APPLY_EN_DATE) {
		AP_APPLY_EN_DATE = aP_APPLY_EN_DATE;
	}

	public String getAP_DEADLINE() {
		return AP_DEADLINE;
	}

	public void setAP_DEADLINE(String aP_DEADLINE) {
		AP_DEADLINE = aP_DEADLINE;
	}

	public String getAP_BUTTON_TEXT1() {
		return AP_BUTTON_TEXT1;
	}

	public void setAP_BUTTON_TEXT1(String aP_BUTTON_TEXT1) {
		AP_BUTTON_TEXT1 = aP_BUTTON_TEXT1;
	}

	public String getAP_BUTTON_TEXT2() {
		return AP_BUTTON_TEXT2;
	}

	public void setAP_BUTTON_TEXT2(String aP_BUTTON_TEXT2) {
		AP_BUTTON_TEXT2 = aP_BUTTON_TEXT2;
	}

	public String getAP_BUTTON_TEXT3() {
		return AP_BUTTON_TEXT3;
	}

	public void setAP_BUTTON_TEXT3(String aP_BUTTON_TEXT3) {
		AP_BUTTON_TEXT3 = aP_BUTTON_TEXT3;
	}

	public String getAP_TICKET_CNT() {
		return AP_TICKET_CNT;
	}

	public void setAP_TICKET_CNT(String aP_TICKET_CNT) {
		AP_TICKET_CNT = aP_TICKET_CNT;
	}

	public String getAP_HOILDAY() {
		return AP_HOILDAY;
	}

	public void setAP_HOILDAY(String aP_HOILDAY) {
		AP_HOILDAY = aP_HOILDAY;
	}

	public String getAP_TYPE() {
		return AP_TYPE;
	}

	public void setAP_TYPE(String aP_TYPE) {
		AP_TYPE = aP_TYPE;
	}

	public String getAPU_GENDER() {
		return APU_GENDER;
	}

	public void setAPU_GENDER(String aPU_GENDER) {
		APU_GENDER = aPU_GENDER;
	}

	public String getAPU_SELFYN() {
		return APU_SELFYN;
	}

	public void setAPU_SELFYN(String aPU_SELFYN) {
		APU_SELFYN = aPU_SELFYN;
	}

	public String getAPP_STATUS() {
		return APP_STATUS;
	}

	public void setAPP_STATUS(String aPP_STATUS) {
		APP_STATUS = aPP_STATUS;
	}

	public String getAPP_DIVISION() {
		return APP_DIVISION;
	}

	public void setAPP_DIVISION(String aPP_DIVISION) {
		APP_DIVISION = aPP_DIVISION;
	}

	public String getAP_WAITING_YN() {
		return AP_WAITING_YN;
	}

	public void setAP_WAITING_YN(String aP_WAITING_YN) {
		AP_WAITING_YN = aP_WAITING_YN;
	}

	public String getAP_WAITING_TEXT() {
		return AP_WAITING_TEXT;
	}

	public void setAP_WAITING_TEXT(String aP_WAITING_TEXT) {
		AP_WAITING_TEXT = aP_WAITING_TEXT;
	}

	public String getAP_EXPIRED() {
		return AP_EXPIRED;
	}

	public void setAP_EXPIRED(String aP_EXPIRED) {
		AP_EXPIRED = aP_EXPIRED;
	}

	public String getAPP_EXPIRED() {
		return APP_EXPIRED;
	}

	public void setAPP_EXPIRED(String aPP_EXPIRED) {
		APP_EXPIRED = aPP_EXPIRED;
	}

	public String getAP_USE_NM() {
		return AP_USE_NM;
	}

	public void setAP_USE_NM(String aP_USE_NM) {
		AP_USE_NM = aP_USE_NM;
	}
	
}
