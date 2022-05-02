package com.tx.common.common;

public class Language {
	
	
	
	public static String getSuccessMsg() {
		String message;
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "Successfully transmitted.";
			break;

		default:
			message = "성공적으로 전송되었습니다.";
			break;
		}
		
		return message;
		
	}
	
	public static String getIssuePush() {
		String message;
		
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "An installation request has been received.";
			break;
			
		default:
			message = "설치 요청이 들어왔습니다.";
			break;
		}
		
		return message;
	}
	
	public static String getIssueConfirm() {
		String message;
		
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "A request for approval for installation has been received.";
			break;
			
		default:
			message = "설치 승인 요청이 들어왔습니다.";
			break;
		}
		
		return message;
	}
	
	public static String getSuccessInsertMsg() {
		String message;
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "Successfully registered.";
			break;
			
		default:
			message = "성공적으로 등록되었습니다.";
			break;
		}
		
		return message;
		
	}
	public static String getSuccessProcessMsg() {
		String message;
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "Successfully processed.";
			break;
			
		default:
			message = "성공적으로 처리되었습니다.";
			break;
		}
		
		return message;
		
	}
	
	public static String getRecordPush() {
		String message;
		
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "A repair request has been received.";
			break;

		default:
			message = "보수 요청이 들어왔습니다.";
			break;
		}
		
		return message;
	}
	public static String getRecordConfirm() {
		String message;
		
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "A request for approval for maintenance has been received.";
			break;
			
		default:
			message = "보수 승인 요청이 들어왔습니다.";
			break;
		}
		
		return message;
	}
	
	public static String getDataError() {
		String message;
		
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "The data was entered incorrectly.";
			break;
			
		default:
			message = "데이터가 잘못입력되었습니다.";
			break;
		}
		
		return message;
	}
	public static String getReportRecord() {
		String message;
		
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "A fault report has been received.";
			break;
			
		default:
			message = "고장신고가 접수되었습니다.";
			break;
		}
		
		return message;
	}
	
	public static String getReportRecordresult() {
		String message;
		
		switch (SettingData.HOMEPAGE_LANGUAGE) {
		case "en":
			message = "Report reception history has not been received. Please confirm your name and contact details.";
			break;
			
		default:
			message = "신고접수 이력이 없습니다. 성명과 연락처를 다시 확인하여주세요.";
			break;
		}
		
		return message;
	}
	
	
	public static String getErrMessage(int type){
    	String message = "";
    	switch (SettingData.HOMEPAGE_LANGUAGE) {
    	case "en":
			if(type == 0) {
				message = "The ID is locked for a period of time due to a password accumulation error.";
			}else if(type == 1){
				message = "ID does not exist or password does not match. If the password does not match more than 5 times, the ID will be locked for 30 minutes.";
			}else if(type == 2){
				message = "ID does not exist or password does not match.  If the password does not match more than 5 times, the ID will be locked for 30 minutes.";
			}else if(type == 3){
				message = "Incomplete certification";
			}else if(type == 4){
				message = "You do not have permission. Please contact your administrator.";
			}else if(type == 5){
				message = "The ID you left.";
	    	}else if(type == 6){
	    		message = "My ID will be plated for 30 minutes because I have misplaced my password five times in a row.";
	    	}
			
			break;

		default:
			if(type == 0) {
				message = "해당 아이디는 비밀번호 누적 오류로 일정시간 잠겨있습니다.";
			}else if(type == 1){
				message = "아이디가 존재하지 않거나 비밀번호가 맞지 않습니다. 5회 이상 비밀번호가 맞지 않을 시 30분 동안 아이디가 잠금됩니다.";
			}else if(type == 2){
				message = "아이디가 존재하지 않거나 비밀번호가 맞지 않습니다. 5회 이상 비밀번호가 맞지 않을 시 30분 동안 아이디가 잠금됩니다.";
			}else if(type == 3){
				message = "인증 미완료";
			}else if(type == 4){
				message = "권한이 없습니다. 관리자한테 문의하세요.";
			}else if(type == 5){
				message = "탈퇴한 아이디입니다.";
			}else if(type == 6){
	    		message = "비밀번호를 5회 연속 틀리셔서 30분동안 아이디가 잠금처리 됩니다.";
	    	}
			
			break;
		}
    	
    	
    	return message;
    }
	
}
