package com.tx.admin.operation.holiday.dto;

public class HolidayDTO {
	
	private String  THM_KEYNO,
					THM_NAME,
					THM_LUNAR,
					THM_DATE,
					THM_DEL_YN,
					THM_NATIONAL,
					THM_TYPE,
					holidayType= "";
					
	
	
	public String getTHM_NATIONAL() {
		return THM_NATIONAL;
	}

	public void setTHM_NATIONAL(String tHM_NATIONAL) {
		THM_NATIONAL = tHM_NATIONAL;
	}

	public String getTHM_KEYNO() {
		return THM_KEYNO;
	}

	public void setTHM_KEYNO(String tHM_KEYNO) {
		THM_KEYNO = tHM_KEYNO;
	}

	public String getTHM_NAME() {
		return THM_NAME;
	}

	public void setTHM_NAME(String tHM_NAME) {
		THM_NAME = tHM_NAME;
	}

	public String getTHM_LUNAR() {
		return THM_LUNAR;
	}

	public void setTHM_LUNAR(String tHM_LUNAR) {
		THM_LUNAR = tHM_LUNAR;
	}

	public String getTHM_DATE() {
		return THM_DATE;
	}

	public void setTHM_DATE(String tHM_DATE) {
		THM_DATE = tHM_DATE;
	}

	public String getTHM_DEL_YN() {
		return THM_DEL_YN;
	}

	public void setTHM_DEL_YN(String tHM_DEL_YN) {
		THM_DEL_YN = tHM_DEL_YN;
	}

	public String getTHM_TYPE() {
		return THM_TYPE;
	}

	public void setTHM_TYPE(String tHM_TYPE) {
		THM_TYPE = tHM_TYPE;
	}

	public String getHolidayType() {
		return holidayType;
	}

	public void setHolidayType(String holidayType) {
		this.holidayType = holidayType;
	}
	
}
