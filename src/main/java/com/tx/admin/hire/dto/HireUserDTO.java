package com.tx.admin.hire.dto;

import java.util.ArrayList;

import org.apache.commons.lang3.StringUtils;

import com.tx.common.security.aes.AES256Cipher;


public class HireUserDTO {
    private String TH_KEYNO; 
    private String TH_USER; 
    private String TH_PHONE; 
    private String TH_EMAIL; 
    private String TH_PASSWORD; 
    private String TH_TYPE;
    private String TH_BNKEYNO;
    private String TH_CLASSTYPE;
    private String TH_BNKEYNO2;
    private String TH_PASS_YN;
    
    private String TH_FILE;
    private String TH_FILE1;
    private String TH_FILE2;
    private String TH_FILE3;
    private String TH_FILE4;
    private String TH_FILE5;
    private String TH_FILE6;
    private String TH_FILE7;
    private String TH_FILE8;

    private String TH_NUMBER;

    private String TH_ZIP_KEYNO;
	
    private String TH_PDF_KEYNO;
    
    private String THC_NUMBER; 
    
    
    
    public String getTHC_NUMBER() {
		return THC_NUMBER;
	}
	public void setTHC_NUMBER(String tHC_NUMBER) {
		THC_NUMBER = tHC_NUMBER;
	}
	public String getTH_FILE1() {
		return TH_FILE1;
	}
	public void setTH_FILE1(String tH_FILE1) {
		TH_FILE1 = tH_FILE1;
	}
	public String getTH_FILE2() {
		return TH_FILE2;
	}
	public void setTH_FILE2(String tH_FILE2) {
		TH_FILE2 = tH_FILE2;
	}
	public String getTH_FILE3() {
		return TH_FILE3;
	}
	public void setTH_FILE3(String tH_FILE3) {
		TH_FILE3 = tH_FILE3;
	}
	public String getTH_FILE4() {
		return TH_FILE4;
	}
	public void setTH_FILE4(String tH_FILE4) {
		TH_FILE4 = tH_FILE4;
	}
	public String getTH_FILE5() {
		return TH_FILE5;
	}
	public void setTH_FILE5(String tH_FILE5) {
		TH_FILE5 = tH_FILE5;
	}
	public String getTH_FILE6() {
		return TH_FILE6;
	}
	public void setTH_FILE6(String tH_FILE6) {
		TH_FILE6 = tH_FILE6;
	}
	public String getTH_FILE7() {
		return TH_FILE7;
	}
	public void setTH_FILE7(String tH_FILE7) {
		TH_FILE7 = tH_FILE7;
	}
	public String getTH_FILE8() {
		return TH_FILE8;
	}
	public void setTH_FILE8(String tH_FILE8) {
		TH_FILE8 = tH_FILE8;
	}
	public String getTH_PDF_KEYNO() {
		return TH_PDF_KEYNO;
	}
	public void setTH_PDF_KEYNO(String tH_PDF_KEYNO) {
		TH_PDF_KEYNO = tH_PDF_KEYNO;
	}
	public String getTH_FILE() {
		return TH_FILE;
	}
	public void setTH_FILE(String tH_FILE) {
		TH_FILE = tH_FILE;
	}
	public String getTH_ZIP_KEYNO() {
		return TH_ZIP_KEYNO;
	}
	public void setTH_ZIP_KEYNO(String tH_ZIP_KEYNO) {
		TH_ZIP_KEYNO = tH_ZIP_KEYNO;
	}
	public String getTH_NUMBER() {
		return TH_NUMBER;
	}
	public void setTH_NUMBER(String tH_NUMBER) {
		TH_NUMBER = tH_NUMBER;
	}
	public String getTH_PASS_YN() {
		return TH_PASS_YN;
	}
	public void setTH_PASS_YN(String tH_PASS_YN) {
		TH_PASS_YN = tH_PASS_YN;
	}
	public String getTH_BNKEYNO2() {
		return TH_BNKEYNO2;
	}
	public void setTH_BNKEYNO2(String tH_BNKEYNO2) {
		TH_BNKEYNO2 = tH_BNKEYNO2;
	}
	public String getTH_BNKEYNO() {
		return TH_BNKEYNO;
	}
	public void setTH_BNKEYNO(String tH_BNKEYNO) {
		TH_BNKEYNO = tH_BNKEYNO;
	}
	public String getTH_CLASSTYPE() {
		return TH_CLASSTYPE;
	}
	public void setTH_CLASSTYPE(String tH_CLASSTYPE) {
		TH_CLASSTYPE = tH_CLASSTYPE;
	}
	public String getTH_KEYNO() {
		return TH_KEYNO;
	}
	public void setTH_KEYNO(String tH_KEYNO) {
		TH_KEYNO = tH_KEYNO;
	}
	public String getTH_USER() {
		return TH_USER;
	}
	public void setTH_USER(String tH_USER) {
		TH_USER = tH_USER;
	}
	public String getTH_PHONE() {
		return TH_PHONE;
	}
	public void setTH_PHONE(String tH_PHONE) {
		TH_PHONE = tH_PHONE;
	}
	public String getTH_EMAIL() {
		return TH_EMAIL;
	}
	public void setTH_EMAIL(String tH_EMAIL) {
		TH_EMAIL = tH_EMAIL;
	}
	public String getTH_PASSWORD() {
		return TH_PASSWORD;
	}
	public void setTH_PASSWORD(String tH_PASSWORD) {
		TH_PASSWORD = tH_PASSWORD;
	}
	public String getTH_TYPE() {
		return TH_TYPE;
	}
	public void setTH_TYPE(String tH_TYPE) {
		TH_TYPE = tH_TYPE;
	} 
	
public void decode(){
		
		try{
			if(StringUtils.isNotBlank(this.TH_EMAIL)){
				this.TH_EMAIL = AES256Cipher.decode(this.TH_EMAIL);
			}
			if(StringUtils.isNotBlank(this.TH_PHONE)){
				this.TH_PHONE = AES256Cipher.decode(this.TH_PHONE);
			}
			if(StringUtils.isNotBlank(this.TH_PASSWORD)){
				this.TH_PASSWORD = AES256Cipher.decode(this.TH_PASSWORD);
			}
			
		}catch(Exception e){
			System.out.println("HireUserDTO 복호화중 에러 :: " + e.getMessage());
		}
		
	}
	
	public void encode(){
		try{
			if(StringUtils.isNotBlank(this.TH_EMAIL)){
				this.TH_EMAIL = AES256Cipher.encode(this.TH_EMAIL);
			}
			if(StringUtils.isNotBlank(this.TH_PHONE)){
				this.TH_PHONE = AES256Cipher.encode(this.TH_PHONE);
			}
			if(StringUtils.isNotBlank(this.TH_PASSWORD)){
				this.TH_PASSWORD = AES256Cipher.encode(this.TH_PASSWORD);
			}
			
		}catch(Exception e){
			System.out.println("UserDTO 암호화중 에러 :: " + e.getMessage());
		}
	}
}
