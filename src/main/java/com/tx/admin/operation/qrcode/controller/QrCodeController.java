package com.tx.admin.operation.qrcode.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.operation.qrcode.dto.QrCode;
import com.tx.admin.operation.qrcode.service.QrCodeService;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.ComponentService;


/**
 * 
 * @FileName: QrCodeController.java
 * @Project : QrCode
 * @Date    : 2017. 02. 27. 
 * @Author  : 양석기	
 * @Version : 1.0
 */
@Controller
public class QrCodeController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	
	/** QrCode */
	@Autowired private QrCodeService QrCodeService;
	
	@RequestMapping(value="/txap/operation/qrcode.do")
	@CheckActivityHistory(desc="QR코드 만들기 페이지 방문")
	public ModelAndView qrcodeMain(Map<String,Object> commandMap
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/operation/qrcode/pra_qrcode_listView.adm");
		
		return mv;
	}
	
	@RequestMapping(value="/txap/operation/qrcode/insertAjax.do")
	@CheckActivityHistory(desc="QR코드 등록 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@ResponseBody
	public QrCode QrCodeInsertAjax(HttpServletRequest req, @ModelAttribute QrCode QrCode			
			) throws Exception {
		
		  
		  String url = QrCode.getCQ_URL(); 
		  
		  String temp = url;
		  if(url.indexOf("?") != -1){
			  temp = url.substring(0,url.indexOf("?"));
		  }
		  String file_name = temp.substring(temp.lastIndexOf("/")+1);	 
		  if(StringUtils.isEmpty(file_name)){
			  file_name = "default";
		  }else if(file_name.indexOf(".") != 0){
			  file_name = file_name.split("\\.")[0];
		  }
		  QrCode.setCQ_NAME(file_name);
		  
		  if(QrCode.getCQ_WIDTH() == 0){
			  QrCode.setCQ_WIDTH(150);
		  }
		  if(QrCode.getCQ_HEIGHT() == 0){
			  QrCode.setCQ_HEIGHT(150);
		  }
		  int width = QrCode.getCQ_WIDTH();
		  int height = QrCode.getCQ_HEIGHT();
		  
		  
		  QrCode = Component.getData("QrCode.CQ_getImg", QrCode);
		  
		  if(QrCode == null){
			  QrCode = QrCodeService.getQrCode(url,width,height,file_name); 
			  QrCode = Component.getData("QrCode.CQ_getImg", QrCode);
		  }
		  
		return QrCode;
	}
	
	@RequestMapping(value="/common/qrcode/dataAjax.do")
	@ResponseBody
	public QrCode commonQrcodeDataAjax(HttpServletRequest req, @ModelAttribute QrCode QrCode			
			) throws Exception {
		
		  
		  String url = QrCode.getCQ_URL(); 
		  
		  String temp = url;
		  if(url.indexOf("?") != -1){
			  temp = url.substring(0,url.indexOf("?"));
		  }
		  String file_name = temp.substring(temp.lastIndexOf("/")+1);	
		  
		  QrCode.setCQ_NAME(file_name);
		  if(QrCode.getCQ_WIDTH() == 0){
			  QrCode.setCQ_WIDTH(150);
		  }
		  if(QrCode.getCQ_HEIGHT() == 0){
			  QrCode.setCQ_HEIGHT(150);
		  }
		  int width = QrCode.getCQ_WIDTH();
		  int height = QrCode.getCQ_HEIGHT();
		  
		  QrCode = Component.getData("QrCode.CQ_getImg", QrCode);
		  
		  if(QrCode == null){
			  QrCode = QrCodeService.getQrCode(url,width,height,file_name); 
		  }
		  
		 req.setAttribute("CQ_NAME", QrCode.getCQ_NAME());
		  
		return QrCode;
	}
	
	
}
