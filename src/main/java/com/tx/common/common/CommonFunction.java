package com.tx.common.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import org.apache.cxf.common.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 */
public class CommonFunction {
	
	//날짜비교
	public int compareDay (String baseDay, String controlDay) throws Exception{
		
		SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd" );
        Date base = format.parse( baseDay );
        Date control = format.parse( controlDay );
        
        int compare = control.compareTo( base );
//		if (compare > 0) {//결과 확인용 로직
//			System.err.println("control > base : "+controlDay+" > "+baseDay);
//		} else if (compare < 0) {
//			System.err.println("control < base : "+controlDay+" < "+baseDay);
//		} else {
//			System.err.println("control = base : "+controlDay+" = "+baseDay);
//		}
		
		
		return compare;
	}
	
	//숫자 천단위 콤마 찍기
	public static String toNumFormat(int num) {
	  DecimalFormat df = new DecimalFormat("#,###");
	  return df.format(num);
	 }
	
	//페이지 이동
	public void go_msg(String msg, String go_url, ModelAndView mv){
		
		String go_msg = "<script type='text/javascript'>";
		
		if(!StringUtils.isEmpty(msg.trim())){
			go_msg += "alert('" + msg + "');";
		}
		
		switch (go_url.trim()) {
		case "":
			go_msg += "history.back(-1);";
			break;
		case "close":
			go_msg += "self.close();";
			break;
		case "return":
			go_msg += "return;";
			break;
		case "reload":
			go_msg += "window.location.reload();";
			break;
		case "openReload":
			go_msg += "opener.window.location.reload();self.close();";
			break;
		case "none":
			break;
		default:
			go_msg += "window.location.href='" + go_url + "';";
		}
		
		go_msg += "</script>";
		
		mv.addObject("go_msg", go_msg);
	}
	
	/**
	 * @param Data
	 * @return
	 * 삼항연산자 null,empty, "" 체크
	 */
	public String checkColumnData(Object Data){
		return StringUtils.isEmpty(Data+"") ? null : (Data+"").equals("null") ? null : Data+"";
	}
	
	//랜덤숫자, 인증번호
	public static int generateRanNumber(int length) {
	 
	    String numStr = "1";
	    String plusNumStr = "1";
	 
	    for (int i = 0; i < length; i++) {
	        numStr += "0";
	 
	        if (i != length - 1) {
	            plusNumStr += "0";
	        }
	    }
	 
	    Random random = new Random();
	    int result = random.nextInt(Integer.parseInt(numStr)) + Integer.parseInt(plusNumStr);
	 
	    if (result > Integer.parseInt(numStr)) {
	        result = result - Integer.parseInt(plusNumStr);
	    }
	 
	    return result;
	}
	
	/**
	 * @param fileName
	 * @return
	 * 파일명에 존재하는 허용되지 않는 특수문자 제거
	 */
	public static String replaceAllForFileName(String fileName){ 
		return fileName.replaceAll("[:\\\\/*?|<>]", "_");
	}
	
	/**
	 * @param paramValue
	 * @param gubun
	 * @return
	 * 보안에 위배되는 특수문자열 제거
	 */
	public static String replaceAllForSecurity (String paramValue, String gubun) {
        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("\\\\", "");
        	paramValue = paramValue.replaceAll("\'", "'");
        	paramValue = paramValue.replaceAll("\\/", "'");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
        		paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
	
	/**
	 * @param str
	 * @return
	 * &amp 에서 & 형태로 변환
	 * html 형식에서 문자형으로 변환
	 */
	public static String htmlTotext(String str) {

		if(str == null) return null;
		
		String returnStr = str;

		returnStr = returnStr.replaceAll("<br>", "\n");
		returnStr = returnStr.replaceAll("<br/>", "\n");
		returnStr = returnStr.replaceAll("&gt;", ">");
		returnStr = returnStr.replaceAll("&lt;", "<");
		returnStr = returnStr.replaceAll("&quot;", "\"");
		returnStr = returnStr.replaceAll("&nbsp;", " ");
		returnStr = returnStr.replaceAll("&amp;", "&");
		returnStr = returnStr.replaceAll("&#34;", "\"");

		return returnStr;

	}
	
	
	/**
	 * @param srcString
	 * @return
	 * &에서 &amp 형태로 변환
	 */
	public static String getSpclStrCnvr(String srcString) {

		String rtnStr = null;

		try {

			StringBuffer strTxt = new StringBuffer("");
			char chrBuff;
			int len = srcString.length();
			for (int i = 0; i < len; i++) {
				chrBuff = (char) srcString.charAt(i);
				switch (chrBuff) {
				case '<':
					strTxt.append("&lt;");
					break;

				case '>':
					strTxt.append("&gt;");
					break;

				case '&':
					strTxt.append("&amp;");
					break;

				default:
					strTxt.append(chrBuff);

				}
			}
			rtnStr = strTxt.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return rtnStr;

	}




	
}
