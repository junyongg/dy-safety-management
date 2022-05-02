package com.tx.admin.program.group.dto;

import com.tx.common.dto.Common;

/**
 * 단체예약 신청 DTO
 * @author admin
 *
 */
public class GroupDTO extends Common {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1045520538316635667L;
	
	private String  
		/* T_GROUP_MANAGER */
		  GM_KEYNO
		, GM_NAME
		, GM_SUMMARY
		, GM_PLACE
		, GM_DATE
		, GM_DELYN
		, GM_REGDT
		, GM_MODDT
		, GM_REGNM
		, GM_MODNM
		, GM_DIVISION
		, GM_MINIMUM
		, GM_MAXIMUM
		, GM_INTRODUCE
		, GM_HOLIDAY
		, GM_USE
		
		/* T_GROUP_PARTICIPATE */
		, GP_YUMOCAR
		, GP_WHEELCHAIR
		, GP_GROUPNAME
		, GP_GSM_KEYNO
		, GP_DATE
		, GP_TIME
		, GP_TRAFFIC_EXP
		, GP_KEYNO
		, GP_GM_KEYNO
		, GP_GSS_KEYNO
		, GP_UI_KEYNO
		, GP_NAME
		, GP_PHONE
		, GP_HEADCOUNT
		, GP_TRAFFIC
		, GP_DELYN
		, GP_REGDT
		
		/* T_GROUP_SCHEDULE_MAIN */
		, GSM_KEYNO
		, GSM_GM_KEYNO
		, GSM_STDT
		, GSM_DELYN
		, GSM_ENDT
		 
		
		/* T_GROUP_SCHEDULE_SUB */
		, GSS_KEYNO
		, GSS_GSM_KEYNO
		, GSS_ST_TIME
		, GSS_EN_TIME
		, GSS_MAXIMUM
		, GSS_SUBTITLE
		;

	String GSM_DAY;

	

	public String getGM_KEYNO() {
		return GM_KEYNO;
	}

	public String setGM_KEYNO(String gM_KEYNO) {
		return GM_KEYNO = gM_KEYNO;
	}

	public String getGM_NAME() {
		return GM_NAME;
	}

	public void setGM_NAME(String gM_NAME) {
		GM_NAME = gM_NAME;
	}

	public String getGM_SUMMARY() {
		return GM_SUMMARY;
	}

	public void setGM_SUMMARY(String gM_SUMMARY) {
		GM_SUMMARY = gM_SUMMARY;
	}

	public String getGM_PLACE() {
		return GM_PLACE;
	}

	public void setGM_PLACE(String gM_PLACE) {
		GM_PLACE = gM_PLACE;
	}

	public String getGM_DATE() {
		return GM_DATE;
	}

	public void setGM_DATE(String gM_DATE) {
		GM_DATE = gM_DATE;
	}

	public String getGM_DELYN() {
		return GM_DELYN;
	}

	public void setGM_DELYN(String gM_DELYN) {
		GM_DELYN = gM_DELYN;
	}

	public String getGM_REGDT() {
		return GM_REGDT;
	}

	public void setGM_REGDT(String gM_REGDT) {
		GM_REGDT = gM_REGDT;
	}

	public String getGM_MODDT() {
		return GM_MODDT;
	}

	public void setGM_MODDT(String gM_MODDT) {
		GM_MODDT = gM_MODDT;
	}

	public String getGM_REGNM() {
		return GM_REGNM;
	}

	public void setGM_REGNM(String gM_REGNM) {
		GM_REGNM = gM_REGNM;
	}

	public String getGM_MODNM() {
		return GM_MODNM;
	}

	public void setGM_MODNM(String gM_MODNM) {
		GM_MODNM = gM_MODNM;
	}

	public String getGM_DIVISION() {
		return GM_DIVISION;
	}

	public void setGM_DIVISION(String gM_DIVISION) {
		GM_DIVISION = gM_DIVISION;
	}

	public String getGM_MINIMUM() {
		return GM_MINIMUM;
	}

	public void setGM_MINIMUM(String gM_MINIMUM) {
		GM_MINIMUM = gM_MINIMUM;
	}

	public String getGM_MAXIMUM() {
		return GM_MAXIMUM;
	}

	public void setGM_MAXIMUM(String gM_MAXIMUM) {
		GM_MAXIMUM = gM_MAXIMUM;
	}

	public String getGP_KEYNO() {
		return GP_KEYNO;
	}

	public void setGP_KEYNO(String gP_KEYNO) {
		GP_KEYNO = gP_KEYNO;
	}

	public String getGP_GM_KEYNO() {
		return GP_GM_KEYNO;
	}

	public void setGP_GM_KEYNO(String gP_GM_KEYNO) {
		GP_GM_KEYNO = gP_GM_KEYNO;
	}

	public String getGP_GSM_KEYNO() {
		return GP_GSM_KEYNO;
	}

	public void setGP_GSM_KEYNO(String gP_GSM_KEYNO) {
		GP_GSM_KEYNO = gP_GSM_KEYNO;
	}

	public String getGP_UI_KEYNO() {
		return GP_UI_KEYNO;
	}

	public void setGP_UI_KEYNO(String gP_UI_KEYNO) {
		GP_UI_KEYNO = gP_UI_KEYNO;
	}

	public String getGP_NAME() {
		return GP_NAME;
	}

	public void setGP_NAME(String gP_NAME) {
		GP_NAME = gP_NAME;
	}

	public String getGP_PHONE() {
		return GP_PHONE;
	}

	public void setGP_PHONE(String gP_PHONE) {
		GP_PHONE = gP_PHONE;
	}

	public String getGP_HEADCOUNT() {
		return GP_HEADCOUNT;
	}

	public void setGP_HEADCOUNT(String gP_HEADCOUNT) {
		GP_HEADCOUNT = gP_HEADCOUNT;
	}

	public String getGP_TRAFFIC() {
		return GP_TRAFFIC;
	}

	public void setGP_TRAFFIC(String gP_TRAFFIC) {
		GP_TRAFFIC = gP_TRAFFIC;
	}

	public String getGP_DELYN() {
		return GP_DELYN;
	}

	public void setGP_DELYN(String gP_DELYN) {
		GP_DELYN = gP_DELYN;
	}

	public String getGSM_KEYNO() {
		return GSM_KEYNO;
	}

	public String setGSM_KEYNO(String gSM_KEYNO) {
		return GSM_KEYNO = gSM_KEYNO;
	}

	public String getGSM_GM_KEYNO() {
		return GSM_GM_KEYNO;
	}

	public void setGSM_GM_KEYNO(String gSM_GM_KEYNO) {
		GSM_GM_KEYNO = gSM_GM_KEYNO;
	}

	public String getGSM_STDT() {
		return GSM_STDT;
	}

	public void setGSM_STDT(String gSM_STDT) {
		GSM_STDT = gSM_STDT;
	}

	public String getGSM_DELYN() {
		return GSM_DELYN;
	}

	public void setGSM_DELYN(String gSM_DELYN) {
		GSM_DELYN = gSM_DELYN;
	}

	public String getGSM_ENDT() {
		return GSM_ENDT;
	}

	public void setGSM_ENDT(String gSM_ENDT) {
		GSM_ENDT = gSM_ENDT;
	}

	public String getGSM_DAY() {
		return GSM_DAY;
	}

	public void setGSM_DAY(String gSM_DAY2) {
		GSM_DAY = gSM_DAY2;
	}

	public String getGSS_KEYNO() {
		return GSS_KEYNO;
	}

	public void setGSS_KEYNO(String gSS_KEYNO) {
		GSS_KEYNO = gSS_KEYNO;
	}

	public String getGSS_GSM_KEYNO() {
		return GSS_GSM_KEYNO;
	}

	public void setGSS_GSM_KEYNO(String gSS_GSM_KEYNO) {
		GSS_GSM_KEYNO = gSS_GSM_KEYNO;
	}

	public String getGSS_ST_TIME() {
		return GSS_ST_TIME;
	}

	public void setGSS_ST_TIME(String gSS_ST_TIME) {
		GSS_ST_TIME = gSS_ST_TIME;
	}

	public String getGSS_EN_TIME() {
		return GSS_EN_TIME;
	}

	public void setGSS_EN_TIME(String gSS_EN_TIME) {
		GSS_EN_TIME = gSS_EN_TIME;
	}

	public String getGSS_MAXIMUM() {
		return GSS_MAXIMUM;
	}

	public void setGSS_MAXIMUM(String gSS_MAXIMUM) {
		GSS_MAXIMUM = gSS_MAXIMUM;
	}

	public String getGSS_SUBTITLE() {
		return GSS_SUBTITLE;
	}

	public void setGSS_SUBTITLE(String gSS_SUBTITLE) {
		GSS_SUBTITLE = gSS_SUBTITLE;
	}

	public String getGM_INTRODUCE() {
		return GM_INTRODUCE;
	}

	public void setGM_INTRODUCE(String gM_INTRODUCE) {
		GM_INTRODUCE = gM_INTRODUCE;
	}

	public String getGP_YUMOCAR() {
		return GP_YUMOCAR;
	}

	public void setGP_YUMOCAR(String gP_YUMOCAR) {
		GP_YUMOCAR = gP_YUMOCAR;
	}

	public String getGP_WHEELCHAIR() {
		return GP_WHEELCHAIR;
	}

	public void setGP_WHEELCHAIR(String gP_WHEELCHAIR) {
		GP_WHEELCHAIR = gP_WHEELCHAIR;
	}

	public String getGP_GROUPNAME() {
		return GP_GROUPNAME;
	}

	public void setGP_GROUPNAME(String gP_GROUPNAME) {
		GP_GROUPNAME = gP_GROUPNAME;
	}

	public String getGP_GSS_KEYNO() {
		return GP_GSS_KEYNO;
	}

	public void setGP_GSS_KEYNO(String gP_GSS_KEYNO) {
		GP_GSS_KEYNO = gP_GSS_KEYNO;
	}

	public String getGP_DATE() {
		return GP_DATE;
	}

	public void setGP_DATE(String gP_DATE) {
		GP_DATE = gP_DATE;
	}

	public String getGP_TIME() {
		return GP_TIME;
	}

	public void setGP_TIME(String gP_TIME) {
		GP_TIME = gP_TIME;
	}

	public String getGP_TRAFFIC_EXP() {
		return GP_TRAFFIC_EXP;
	}

	public void setGP_TRAFFIC_EXP(String gP_TRAFFIC_EXP) {
		GP_TRAFFIC_EXP = gP_TRAFFIC_EXP;
	}

	public String getGP_REGDT() {
		return GP_REGDT;
	}

	public void setGP_REGDT(String gP_REGDT) {
		GP_REGDT = gP_REGDT;
	}

	public String getGM_HOLIDAY() {
		return GM_HOLIDAY;
	}

	public void setGM_HOLIDAY(String gM_HOLIDAY) {
		GM_HOLIDAY = gM_HOLIDAY;
	}

	public String getGM_USE() {
		return GM_USE;
	}

	public void setGM_USE(String gM_USE) {
		GM_USE = gM_USE;
	}
	
	
}
