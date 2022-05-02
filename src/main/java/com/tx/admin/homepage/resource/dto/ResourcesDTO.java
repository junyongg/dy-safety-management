package com.tx.admin.homepage.resource.dto;

public class ResourcesDTO {
	
	/* T_RESOURCES_MANAGER */
	private String  RM_KEYNO
					,RM_MN_HOMEDIV_C
					,RM_SCOPE
					,RM_TITLE
					,RM_DATA
					,RM_REGDT
					,RM_REGNM
					,RM_MODNM
					,RM_MODDT
					,RM_DEL_YN
					,RM_FILE_NAME
					,RM_TYPE;
	
	/*T_RESOURCES_MANAGER_SUB*/
	private String   RMS_RM_KEYNO
					,RMS_MN_KEYNO;
	
	/* T_RESOURCES_MANAGER_HISTORY */
	private String RMH_KEYNO
					,RMH_RM_KEYNO
					,RMH_DATA
					,RMH_STDT
					,RMH_ENDT
					,RMH_MODNM
					,RMH_DEL_YN
					,RMH_COMMENT;
	
	private Double RMH_VERSION;

	public String getRM_KEYNO() {
		return RM_KEYNO;
	}

	public void setRM_KEYNO(String rM_KEYNO) {
		RM_KEYNO = rM_KEYNO;
	}

	public String getRM_MN_HOMEDIV_C() {
		return RM_MN_HOMEDIV_C;
	}

	public void setRM_MN_HOMEDIV_C(String rM_MN_HOMEDIV_C) {
		RM_MN_HOMEDIV_C = rM_MN_HOMEDIV_C;
	}

	public String getRM_SCOPE() {
		return RM_SCOPE;
	}

	public void setRM_SCOPE(String rM_SCOPE) {
		RM_SCOPE = rM_SCOPE;
	}

	public String getRM_TITLE() {
		return RM_TITLE;
	}

	public void setRM_TITLE(String rM_TITLE) {
		RM_TITLE = rM_TITLE;
	}

	public String getRM_DATA() {
		return RM_DATA;
	}

	public void setRM_DATA(String rM_DATA) {
		RM_DATA = rM_DATA;
	}

	public String getRM_REGDT() {
		return RM_REGDT;
	}

	public void setRM_REGDT(String rM_REGDT) {
		RM_REGDT = rM_REGDT;
	}

	public String getRM_REGNM() {
		return RM_REGNM;
	}

	public void setRM_REGNM(String rM_REGNM) {
		RM_REGNM = rM_REGNM;
	}

	public String getRM_MODNM() {
		return RM_MODNM;
	}

	public void setRM_MODNM(String rM_MODNM) {
		RM_MODNM = rM_MODNM;
	}

	public String getRM_MODDT() {
		return RM_MODDT;
	}

	public void setRM_MODDT(String rM_MODDT) {
		RM_MODDT = rM_MODDT;
	}

	public String getRM_DEL_YN() {
		return RM_DEL_YN;
	}

	public void setRM_DEL_YN(String rM_DEL_YN) {
		RM_DEL_YN = rM_DEL_YN;
	}

	public String getRM_FILE_NAME() {
		return RM_FILE_NAME;
	}

	public void setRM_FILE_NAME(String rM_FILE_NAME) {
		RM_FILE_NAME = rM_FILE_NAME;
	}

	public String getRM_TYPE() {
		return RM_TYPE;
	}

	public void setRM_TYPE(String rM_TYPE) {
		RM_TYPE = rM_TYPE;
	}

	public String getRMS_RM_KEYNO() {
		return RMS_RM_KEYNO;
	}

	public void setRMS_RM_KEYNO(String rMS_RM_KEYNO) {
		RMS_RM_KEYNO = rMS_RM_KEYNO;
	}

	public String getRMS_MN_KEYNO() {
		return RMS_MN_KEYNO;
	}

	public void setRMS_MN_KEYNO(String rMS_MN_KEYNO) {
		RMS_MN_KEYNO = rMS_MN_KEYNO;
	}

	public String getRMH_KEYNO() {
		return RMH_KEYNO;
	}

	public void setRMH_KEYNO(String rMH_KEYNO) {
		RMH_KEYNO = rMH_KEYNO;
	}

	public String getRMH_RM_KEYNO() {
		return RMH_RM_KEYNO;
	}

	public void setRMH_RM_KEYNO(String rMH_RM_KEYNO) {
		RMH_RM_KEYNO = rMH_RM_KEYNO;
	}

	public String getRMH_DATA() {
		return RMH_DATA;
	}

	public void setRMH_DATA(String rMH_DATA) {
		RMH_DATA = rMH_DATA;
	}

	public String getRMH_STDT() {
		return RMH_STDT;
	}

	public void setRMH_STDT(String rMH_STDT) {
		RMH_STDT = rMH_STDT;
	}

	public String getRMH_ENDT() {
		return RMH_ENDT;
	}

	public void setRMH_ENDT(String rMH_ENDT) {
		RMH_ENDT = rMH_ENDT;
	}

	public String getRMH_MODNM() {
		return RMH_MODNM;
	}

	public void setRMH_MODNM(String rMH_MODNM) {
		RMH_MODNM = rMH_MODNM;
	}

	public String getRMH_DEL_YN() {
		return RMH_DEL_YN;
	}

	public void setRMH_DEL_YN(String rMH_DEL_YN) {
		RMH_DEL_YN = rMH_DEL_YN;
	}

	public String getRMH_COMMENT() {
		return RMH_COMMENT;
	}

	public void setRMH_COMMENT(String rMH_COMMENT) {
		RMH_COMMENT = rMH_COMMENT;
	}

	public double getRMH_VERSION() {
		return RMH_VERSION;
	}

	public void setRMH_VERSION(double rMH_VERSION) {
		RMH_VERSION = rMH_VERSION;
	}
	
	
	
}