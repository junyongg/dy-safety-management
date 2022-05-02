package com.tx.migration.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tx.admin.member.dto.UserDTO;
import com.tx.admin.member.dto.UserSettingDTO;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.mail.service.EmailService;
import com.tx.common.security.aes.AES256Cipher;

import ucar.nc2.iosp.misc.GtopoIosp;


@Controller
public class MigrationController {

	
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	@Autowired
	MigrationService migration;
	
	@RequestMapping(value="/migration/userinfo.do")
	@ResponseBody
	public void migrationUserInfo(HttpServletRequest req
			) throws Exception {
		
		PasswordEncoder passwordEncoder = new StandardPasswordEncoder("TRONIX$(%&@!CTCMS");

		List<UserDTO> list = Component.getListNoParam("migration.UI_getList");
		for(UserDTO user : list){
			user.setUI_PASSWORD(passwordEncoder.encode("qwer4321!"));
			Component.updateData("migration.UI_updateData", user);
		}
	}
	
	@RequestMapping(value="/magration/filefree.do")
	public void changeFile(HttpServletRequest req)throws Exception{
		//migration.fileCopyOroriginal("5_5");
		String arr[] = new String[6];
		
		for(int i =1; i<= 6 ; i++) {
			arr[i-1] = "5_" + i; 
		}
		
		for(String a : arr) {
			System.out.println(a + "파일 처리");
			migration.fileCopyOroriginal(a);
		}
	}
	
	
	@RequestMapping(value="/magration/user.do")
	public void migrationUser(HttpServletRequest req)throws Exception{
		
	 List<UserJact>g4list =	Component.getListNoParam("migration.jact_user");
	 
	 if(g4list != null && g4list.size()>0) {
		 UserDTO UserDTO = null;
		 String email, phone;
		 
		 UserSettingDTO setting = Component.getData("member.US_getData","jact");
		 int cnt = 0;
		 for(UserJact g4dto : g4list) {
			 cnt++;
			 System.out.println(cnt+"번째"+ g4dto.getMb_name());
			 //이메일 휴대폰번호 암호화
			 email = g4dto.getMb_email();
			 if(email != null && !email.equals("") ) {
				 g4dto.setMb_email( AES256Cipher.encode(email));
			 }
			 phone = g4dto.getMb_hp();
			 if(phone != null && !phone.equals("")) {
				 g4dto.setMb_hp(AES256Cipher.encode(phone));
			 }
			 
			 //dto 매핑
			 UserDTO = new UserDTO();
			 UserDTO.setUI_KEYNO(CommonService.getTableKey("UI"));
			 UserDTO.setUI_ID(g4dto.getMb_id());
			 UserDTO.setUI_MB_PASSWORD(g4dto.getMb_password());// 기존암호화된
			 UserDTO.setUI_NAME(g4dto.getMb_name());
			 UserDTO.setUI_REP_NAME(g4dto.getMb_name());
			 UserDTO.setUI_MB_NICK(g4dto.getMb_nick());
			 UserDTO.setUI_MB_NICK_DATE(g4dto.getMb_nick_date());
			 UserDTO.setUI_EMAIL(g4dto.getMb_email());
			 UserDTO.setUI_MB_LEVEL(g4dto.getMb_level());
			 UserDTO.setUI_ZENDER(g4dto.getMb_sex());
			 UserDTO.setUI_BIRTH(g4dto.getMb_birth());
			 UserDTO.setUI_MB_TEL(g4dto.getMb_tel());
			 UserDTO.setUI_PHONE(g4dto.getMb_hp());
			 UserDTO.setUI_MB_ZIP1(g4dto.getMb_zip1());
			 UserDTO.setUI_MB_ZIP2(g4dto.getMb_zip2());
			 UserDTO.setUI_MB_ADDR1(g4dto.getMb_addr1());
			 UserDTO.setUI_MB_ADDR2(g4dto.getMb_addr2());
			 UserDTO.setUI_MB_RECOMMEND(g4dto.getMb_recommend());
			 UserDTO.setUI_MB_POINT(g4dto.getMb_point());
			 UserDTO.setUI_LASTLOGIN(g4dto.getMb_today_login());
			 UserDTO.setUI_MB_LOGIN_IP(g4dto.getMb_login_ip());
			 UserDTO.setUI_REGDT(g4dto.getMb_datetime());
			 UserDTO.setUI_MB_IP(g4dto.getMb_ip());
			 UserDTO.setUI_INTERCEPT_DATE(g4dto.getMb_intercept_date());
			 UserDTO.setUI_MB_EMAIL_CERTIFY(g4dto.getMb_email_certify());
			 UserDTO.setUI_MB_MAILLING(g4dto.getMb_mailling());
			 UserDTO.setUI_MB_SMS(g4dto.getMb_sms());
			 UserDTO.setUI_MB_OPEN(g4dto.getMb_open());
			 UserDTO.setUI_MB_OPEN_DATE(g4dto.getMb_open_date());
			 UserDTO.setUI_MB_1(g4dto.getMb_1());
				
			 //이메일 인증
			 UserDTO.setUI_AUTH_YN("Y");
				
			 Component.createData("migration.g4_member_to_userinfo", UserDTO);
				
			 if(setting.getUS_UIA_KEYNO() != null && !setting.getUS_UIA_KEYNO().equals("")){
				Map<String, Object> map = new HashMap<String,Object>();
				map.put("UI_KEYNO", UserDTO.getUI_KEYNO());
				map.put("UIA_KEYNO", setting.getUS_UIA_KEYNO().split(","));
				Component.createData("member.UI_setAuthority", map);
			 }
		 }//end for
	 }// null check
	 
	 
	}
	
	
	@RequestMapping(value="/magration/boardfree.do")
	public void boardFree(HttpServletRequest req)throws Exception{
		//자유게시판
		//migration.board_migration("FREE");
		
		//공지사항
		//migration.board_migration("NOTI");
		
		//보도자료
		//migration.board_migration("BODO");
		
		//입찰공고
		//migration.board_migration("biddannouncement");
		
		//채용공고
		//migration.board_migration("Careers");
		
		
		//동영상
		//migration.board_migration("movie");
		
		//photo  
		//migration.board_migration("photo");
		
		//pdf
		//migration.board_migration("pdf");
		
		//학술자료실
		//Academic Library
		//migration.board_migration("Academic Library");
		
		//임원현황
		//migration.board_migration("people");
		
		
		//감사결과
		//migration.board_migration("AuditResult");
		
		//이사회 개최 현황
		//migration.board_migration("Board of Directors");
		
		//노동조합
		//migration.board_migration("Union");
		
		//예산관리 -조달계약실적
		//migration.board_migration("조달계약실적");
		
		//업무추진비 사용내역
		//migration.board_migration("업무추진비");
		
		//복리후생비 
		//migration.board_migration("복리후생비");
		
		//지역사회공헌
		//migration.board_migration("지역사회공헌");
		
		
		//문화재 연구소
		
		//지표조사
		//migration.board_migration("지표조사");
		
		//시발굴조사
		//migration.board_migration("시발굴조사");
		
		//연구소소식
		//migration.board_migration("연구소소식");

		//자료실 -학술보고서
		//migration.board_migration("학술보고서");

		//학술세미나
		//migration.board_migration("학술세미나");
		
		//학술논문집
		//migration.board_migration("학술논문집");
		
		//무형문화재
		migration.board_migration("무형문화재");
		
		
	}
	
	
	
}
