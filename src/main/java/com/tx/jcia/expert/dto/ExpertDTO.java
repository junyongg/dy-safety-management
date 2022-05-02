package com.tx.jcia.expert.dto;

import com.tx.common.dto.Common;

/**
 * 신청 팝업 DTO
 *
 */
public class ExpertDTO extends Common {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8339935996095521391L;
	private String  
					/*전문가DB*/
					/*T_EXPERT_INFORMATION*/
					  EI_KEYNO
					, EI_NAME
					, EI_BIRTH
					, EI_BIRTH_TYPE
					, EI_EMAIL
					, EI_ADDRESS1
					, EI_ADDRESS2
					, EI_POST
					, EI_PHONE
					, EI_PHONE2
					, EI_BELONG
					, EI_POSITION
					, EI_IP
					, EI_REGDT
					, EI_DELYN
					
					/*T_EXPERT_DEGREE_REQUIREMENTS*/
					, EDR_KEYNO
					, EDR_EI_KEYNO
					, EDR_SCHOOL
					, EDR_MAJOR
					, EDR_DEGREE
					, EDR_DETAILE
					, EDR_DELYN
					
					/*T_EXPERT_RESEARCH*/
					, ER_KEYNO
					, ER_EI_KEYNO
					, ER_FIELD
					, ER_DELYN
			
					;

	public String getEI_KEYNO() {
		return EI_KEYNO;
	}

	public String setEI_KEYNO(String eI_KEYNO) {
		return EI_KEYNO = eI_KEYNO;
	}

	public String getEI_NAME() {
		return EI_NAME;
	}

	public void setEI_NAME(String eI_NAME) {
		EI_NAME = eI_NAME;
	}

	public String getEI_BIRTH() {
		return EI_BIRTH;
	}

	public void setEI_BIRTH(String eI_BIRTH) {
		EI_BIRTH = eI_BIRTH;
	}

	public String getEI_BIRTH_TYPE() {
		return EI_BIRTH_TYPE;
	}

	public void setEI_BIRTH_TYPE(String eI_BIRTH_TYPE) {
		EI_BIRTH_TYPE = eI_BIRTH_TYPE;
	}

	public String getEI_EMAIL() {
		return EI_EMAIL;
	}

	public void setEI_EMAIL(String eI_EMAIL) {
		EI_EMAIL = eI_EMAIL;
	}

	public String getEI_ADDRESS1() {
		return EI_ADDRESS1;
	}

	public void setEI_ADDRESS1(String eI_ADDRESS1) {
		EI_ADDRESS1 = eI_ADDRESS1;
	}

	public String getEI_ADDRESS2() {
		return EI_ADDRESS2;
	}

	public void setEI_ADDRESS2(String eI_ADDRESS2) {
		EI_ADDRESS2 = eI_ADDRESS2;
	}

	public String getEI_POST() {
		return EI_POST;
	}

	public void setEI_POST(String eI_POST) {
		EI_POST = eI_POST;
	}

	public String getEI_PHONE() {
		return EI_PHONE;
	}

	public void setEI_PHONE(String eI_PHONE) {
		EI_PHONE = eI_PHONE;
	}

	public String getEI_PHONE2() {
		return EI_PHONE2;
	}

	public void setEI_PHONE2(String eI_PHONE2) {
		EI_PHONE2 = eI_PHONE2;
	}

	public String getEI_BELONG() {
		return EI_BELONG;
	}

	public void setEI_BELONG(String eI_BELONG) {
		EI_BELONG = eI_BELONG;
	}

	public String getEI_POSITION() {
		return EI_POSITION;
	}

	public void setEI_POSITION(String eI_POSITION) {
		EI_POSITION = eI_POSITION;
	}

	public String getEI_IP() {
		return EI_IP;
	}

	public void setEI_IP(String eI_IP) {
		EI_IP = eI_IP;
	}

	public String getEI_REGDT() {
		return EI_REGDT;
	}

	public void setEI_REGDT(String eI_REGDT) {
		EI_REGDT = eI_REGDT;
	}

	public String getEDR_KEYNO() {
		return EDR_KEYNO;
	}

	public void setEDR_KEYNO(String eDR_KEYNO) {
		EDR_KEYNO = eDR_KEYNO;
	}

	public String getEDR_EI_KEYNO() {
		return EDR_EI_KEYNO;
	}

	public void setEDR_EI_KEYNO(String eDR_EI_KEYNO) {
		EDR_EI_KEYNO = eDR_EI_KEYNO;
	}

	public String getEDR_SCHOOL() {
		return EDR_SCHOOL;
	}

	public void setEDR_SCHOOL(String eDR_SCHOOL) {
		EDR_SCHOOL = eDR_SCHOOL;
	}

	public String getEDR_MAJOR() {
		return EDR_MAJOR;
	}

	public void setEDR_MAJOR(String eDR_MAJOR) {
		EDR_MAJOR = eDR_MAJOR;
	}

	public String getEDR_DEGREE() {
		return EDR_DEGREE;
	}

	public void setEDR_DEGREE(String eDR_DEGREE) {
		EDR_DEGREE = eDR_DEGREE;
	}

	public String getEDR_DETAILE() {
		return EDR_DETAILE;
	}

	public void setEDR_DETAILE(String eDR_DETAILE) {
		EDR_DETAILE = eDR_DETAILE;
	}

	public String getER_KEYNO() {
		return ER_KEYNO;
	}

	public void setER_KEYNO(String eR_KEYNO) {
		ER_KEYNO = eR_KEYNO;
	}

	public String getER_EI_KEYNO() {
		return ER_EI_KEYNO;
	}

	public void setER_EI_KEYNO(String eR_EI_KEYNO) {
		ER_EI_KEYNO = eR_EI_KEYNO;
	}

	public String getER_FIELD() {
		return ER_FIELD;
	}

	public void setER_FIELD(String eR_FIELD) {
		ER_FIELD = eR_FIELD;
	}

	public String getEI_DELYN() {
		return EI_DELYN;
	}

	public void setEI_DELYN(String eI_DELYN) {
		EI_DELYN = eI_DELYN;
	}

	public String getEDR_DELYN() {
		return EDR_DELYN;
	}

	public void setEDR_DELYN(String eDR_DELYN) {
		EDR_DELYN = eDR_DELYN;
	}

	public String getER_DELYN() {
		return ER_DELYN;
	}

	public void setER_DELYN(String eR_DELYN) {
		ER_DELYN = eR_DELYN;
	}

}
