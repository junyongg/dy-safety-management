package com.tx.admin.hire.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.mvel2.optimizers.impl.refl.nodes.ArrayLength;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ibm.icu.text.SimpleDateFormat;
import com.tx.admin.board.dto.BoardColumn;
import com.tx.admin.board.dto.BoardColumnData;
import com.tx.admin.board.dto.BoardType;
import com.tx.admin.hire.dto.HireContentDTO;
import com.tx.admin.hire.dto.HireUserDTO;
import com.tx.admin.pdf.ConverToPdf;
import com.tx.admin.pdf.ConverToPdf2;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;
import com.tx.common.file.FileDownloadTools;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.file.impl.FileDownloadToolsImpl;
import com.tx.common.mail.service.impl.EmailServiceImpl;
import com.tx.common.page.PageAccess;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



@Controller
public class HireController {

	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired EmailServiceImpl Email;
	
	@Autowired ComponentService Component;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	@Autowired FileDownloadTools Filedown;
	
	@Autowired
	CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired
	private PageAccess PageAccess;
	/**
	 * 
	 * @param req
	 * @return
	 * @throws Exception
	 * 작성자 정보 등록페이지
	 */
	@RequestMapping(value = "/jact/hire/intro.do")
	public ModelAndView HireInsert(HttpServletRequest req
			,@RequestParam(value="BN_KEYNO")String BN_KEYNO
			,HireUserDTO hireDTO
			) throws Exception {
		ModelAndView mv = new ModelAndView("/hire/HireInsert_into");
		hireDTO.setTH_BNKEYNO(BN_KEYNO);

		List<BoardColumnData> bt = Component.getList("BoardColumnData.BD_getList",BN_KEYNO);
		
		HashMap<String,Object> map = Component.getData("Hire.BnTitleSelect",BN_KEYNO);
		
		mv.addObject("Title",map.get("BN_TITLE"));
		mv.addObject("hireUser",hireDTO);
		mv.addObject("BdDataList",bt);
		return mv;
	}
	/**
	 * 
	 * @param req
	 * @return
	 * @throws Exception
	 * 작성자 내용 등록 페이지
	 */
	@RequestMapping(value = "/jact/hire/intro2.do")
	public ModelAndView HireInsert2(HttpServletRequest req
			) throws Exception {
		ModelAndView mv = new ModelAndView("/hire/HireInsert_into2");
		return mv;
	}
	/**
	 * 
	 * @param req
	 * @return
	 * @throws Exception
	 * 작성자 등록 결과 페이지
	 */
	@RequestMapping(value = "/jact/hire/result.do")
	public ModelAndView HireInsert_result(HttpServletRequest req
			) throws Exception {
		ModelAndView mv = new ModelAndView("/hire/HireInsert_result");
		return mv;
	}
	/**
	 * 이메일 코드 인증하는것
	 * 
	 */
	@RequestMapping(value = "/hire/emailAjax.do")
	@ResponseBody
	public String HireEmailSend(HttpServletRequest req,
			@RequestParam(value="email",required=false)String email
			,@RequestParam(value="bnkey",required=false)String bnkey
			) throws Exception {
		HireUserDTO hire = new HireUserDTO();
		String key = "0";
		
		hire.setTH_EMAIL(email);
		hire.setTH_BNKEYNO(bnkey);
		
		hire.encode();
		int cnt = Component.getCount("Hire.EmailCheck",hire);
		if(cnt < 1) {
			key = Email.EmailAuthonCode(email,req);
		}
		
		return key;
	}
	
	
	/**
	 * 이메일로 비밀번호 전송하기
	 * 
	 */
	@RequestMapping(value = "/hire/emailPwAjax.do")
	@ResponseBody
	public String HireEmailSendPw(HttpServletRequest req,
			@RequestParam(value="Email",required=false)String email
			,@RequestParam(value="User",required=false)String User
			,@RequestParam(value="Bnkey",required=false)String Bnkey
			) throws Exception {
		HireUserDTO hire = new HireUserDTO();
		
		hire.setTH_EMAIL(email);
		hire.setTH_USER(User);
		hire.setTH_BNKEYNO(Bnkey);
		
		hire.encode();
		String msg = "";
		hire = Component.getData("Hire.SelectPw",hire);
		if(hire != null) {
			hire.decode();
			String pass = hire.getTH_PASSWORD().toString();
			Email.EmailPwCode(email, req, pass);
			msg = "해당 비밀번호를 메일로 전송하였습니다.";
		}else {
			msg = "일치하는 정보가 없습니다. 다시 확인해 주시기 바랍니다.";
		}
		return msg;
	}
	
	
	/**
	 * 신청자 정보먼저 등록하기
	 * 
	 */
	@RequestMapping(value ="/hire/userInsert.do")
	@Transactional
	public String HireUserInsert(
			HttpServletRequest req,
			HireUserDTO hireDTO,
			RedirectAttributes redirectAttribute
			) throws Exception {
		
		hireDTO.encode();
//		Component.createData("Hire.UserInsert", hireDTO);
		
		//넘버링 
		String result = numbering(hireDTO);
		
		redirectAttribute.addFlashAttribute("bndate",Component.getData("Hire.BnTitle",hireDTO));
		
		redirectAttribute.addFlashAttribute("HireNumber",result);
		redirectAttribute.addFlashAttribute("HireUser",hireDTO);
		
		return	"redirect:/jact/hire/intro2.do"; 
	}
	
	/**
	 * 로그인 페이지
	 */
	@RequestMapping(value= "/jact/hire/login.do")
	public ModelAndView HireLogin(
			@RequestParam(value="BN_KEYNO",required=false)String BN_KEYNO
			,@RequestParam(value="BN_TITLE",required=false)String BN_TITLE
			,@RequestParam(value="type",required=false)String type
			,HireUserDTO hireDTO
			) throws Exception{
		ModelAndView mv = new ModelAndView("/hire/HireInsert_login");
		
		hireDTO.setTH_BNKEYNO(BN_KEYNO);
		
		mv.addObject("hireDTO",hireDTO);
		mv.addObject("BN_TITLE",BN_TITLE);
		mv.addObject("BN_KEYNO",BN_KEYNO);
		mv.addObject("type",type);
		return mv;
	}
	/**
	 * 로그인2 페이지
	 */
	@RequestMapping(value= "/jact/hire/login2.do")
	public ModelAndView HireLogin2(
			@RequestParam(value="BN_KEYNO",required=false)String BN_KEYNO
			,@RequestParam(value="BN_TITLE",required=false)String BN_TITLE
			,HireUserDTO hireDTO
			) throws Exception{
		ModelAndView mv = new ModelAndView("/hire/HireInsert_login2");
		
		hireDTO.setTH_BNKEYNO(BN_KEYNO);
		
		mv.addObject("hireDTO",hireDTO);
		mv.addObject("BN_TITLE",BN_TITLE);
		mv.addObject("BN_KEYNO",BN_KEYNO);
		return mv;
	}
	
	/**
	 * 중복된 아이디 체크
	 * @param hireDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/hire/loginAjax.do")
	@ResponseBody
	public int HireLogin(
			HireUserDTO hireDTO
			)throws Exception{
		hireDTO.encode();
		int cnt = Component.getCount("Hire.Usercheck",hireDTO);
		return cnt;
	}
	/**
	 * 중복된 아이디 체크2
	 * @param hireDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/hire/loginAjax2.do")
	@ResponseBody
	public int HireLogin2(
			HireUserDTO hireDTO
			)throws Exception{
		String temp = hireDTO.getTH_BNKEYNO();
		hireDTO.encode();
		hireDTO.setTH_BNKEYNO(hireDTO.getTH_BNKEYNO2());
		//1차 로그인 확인이후 키2값 체크해서 넣어주기
		int cnt = Component.getCount("Hire.Usercheck",hireDTO);
		if(cnt > 0) {
			hireDTO.setTH_BNKEYNO(temp);
			int cnt2 = Component.getCount("Hire.Usercheck2",hireDTO);
			if(cnt2 < 1) {
				Component.updateData("Hire.BnKey2Insert", hireDTO);
			}
		}
		return cnt;
	}
	
	/**
	 * 지원서 취소 
	 */
	@RequestMapping(value="/jact/hire/delectUser.do")
	@Transactional
	public String HireDelete(
			HttpServletRequest req
			,HireUserDTO hireDTO
			,HireContentDTO hirecontent
			) throws Exception {
		
		hireDTO.encode();
		hireDTO = Component.getData("Hire.UserKeySelect",hireDTO);
		Component.deleteData("Hire.UserDelete",hireDTO);
		Component.deleteData("Hire.ContentDelete",hireDTO);
		
		return	"redirect:/jact/open/hire.do"; 
	}
	
	
	/**
	 * 로그인 이후 마이페이지 가기
	 */
	@RequestMapping(value= "/jact/hire/mypage.do")
	public ModelAndView HireMypage(
			HttpServletRequest req
			,HireUserDTO hireDTO
			,HireContentDTO hirecontent
			) throws Exception {
		ModelAndView mv = new ModelAndView("/hire/HireInsert_mypage");
		String keyno = (String) req.getAttribute("TH_KEYNO");
		if(keyno != null) {
			hireDTO.setTH_KEYNO(keyno);
			hireDTO = Component.getData("Hire.GetUserData",hireDTO);
		}else {
			String temp = "";
			hireDTO.encode();
			if(!StringUtils.isBlank(hireDTO.getTH_BNKEYNO2())) {
				temp = hireDTO.getTH_BNKEYNO();
				hireDTO.setTH_BNKEYNO(hireDTO.getTH_BNKEYNO2());
			}
			
			hireDTO = Component.getData("Hire.UserKeySelect",hireDTO);
		}
		mv.addObject("bnData",Component.getData("Hire.BnTitle",hireDTO));
		mv.addObject("hire",Component.getData("Hire.GetAllData_log",hireDTO));
		
		return mv;
	}
	
	/**
	 * 임시저장
	 */
	@RequestMapping(value = "/hire/preInsert.do")
	@ResponseBody
	@Transactional
	public HashMap<String,Object> PreHireContentsInsert(
			HireContentDTO hirecontentDTO
			,HireUserDTO hireDTO
			) throws Exception{
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		hirecontentDTO.setTHC_USE_YN("N");
		hirecontentDTO.setTHC_DELETE("N");
		
		HashMap<String,Object> map = new HashMap<>();
		
		if(StringUtils.isEmpty(hireDTO.getTH_KEYNO())) {
			Component.createData("Hire.UserInsert", hireDTO);
			hirecontentDTO.setTHC_USERKEY(hireDTO.getTH_KEYNO());
		}
		
		int cnt = Component.getCount("Hire.ContentChecking",hirecontentDTO);
		if(cnt > 0) {
			map.put("number", hirecontentDTO.getTHC_NUMBER());
			hirecontentDTO.setTHC_UPDATE_DATE(format.format(date));
			Component.updateData("Hire.ContentUpdate", hirecontentDTO);
		}else {
			//동시에 될 수도 있기 때문에 넘버링 한번더 체크해서 넣어주기
			String result = numbering(hireDTO);
			hirecontentDTO.setTHC_NUMBER(result);
			map.put("number", result);
			hirecontentDTO.setTHC_INSERT_DATE(format.format(date));
			Component.createData("Hire.ContentInsert", hirecontentDTO);
		}
		map.put("keyno",  hireDTO.getTH_KEYNO());
		
		return map;
	}
	/**
	 * 컨텐츠 저장
	 */
	@RequestMapping(value = "/hire/insert.do")
	@ResponseBody
	@Transactional
	public String HireContentsInsert(
			HttpServletRequest req
			,HireContentDTO hirecontentDTO
			,HireUserDTO hireDTO
			,RedirectAttributes redirectAttribute
			,@RequestParam(value="type",required=false)String type
			) throws Exception{
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		hirecontentDTO.setTHC_USE_YN("Y");
		hirecontentDTO.setTHC_DELETE("N");
		
		if(StringUtils.isEmpty(hireDTO.getTH_KEYNO())) {
			Component.createData("Hire.UserInsert", hireDTO);
			hirecontentDTO.setTHC_USERKEY(hireDTO.getTH_KEYNO());
		}
		
		int cnt = Component.getCount("Hire.ContentChecking",hirecontentDTO);
		if(cnt > 0) {
			hirecontentDTO.setTHC_UPDATE_DATE(format.format(date));
			Component.updateData("Hire.ContentUpdate", hirecontentDTO);
		}else {
			//동시에 될 수도 있기 때문에 넘버링 한번더 체크해서 넣어주기
			String result = numbering(hireDTO);
			hirecontentDTO.setTHC_NUMBER(result);
			hirecontentDTO.setTHC_INSERT_DATE(format.format(date));
			Component.createData("Hire.ContentInsert", hirecontentDTO);
		}
		
//		String view = "redirect:/jact/hire/result.do";
		if(type.equals("update")) {
//			view = "forward:/jact/hire/mypage.do";
			req.setAttribute("TH_KEYNO", hirecontentDTO.getTHC_USERKEY());
		}else {
			HireUserDTO hire = new HireUserDTO();
			hire.setTH_KEYNO(hirecontentDTO.getTHC_USERKEY());
			hire = Component.getData("Hire.GetUserData",hire);
			redirectAttribute.addFlashAttribute("bndate",Component.getData("Hire.BnTitle",hire));
			redirectAttribute.addFlashAttribute("hire",hire);
			redirectAttribute.addFlashAttribute("hirecontentDTO", hirecontentDTO);
		}
		
		return hireDTO.getTH_KEYNO();
	}
	

	
	
	/**
	 * 무조건! 로그인 이후 지원서 수정하기
	 */
	@SuppressWarnings("null")
	@RequestMapping(value = "/hire/update.do")
	@Transactional
	public String HireContentUpdate(
			HireContentDTO hirecontentDTO
			,HireUserDTO hireDTO
			,RedirectAttributes redirectAttribute
			)throws Exception{
		hireDTO = Component.getData("Hire.GetUserData",hireDTO);
		hirecontentDTO.setTHC_USERKEY(hireDTO.getTH_KEYNO().toString());
		hirecontentDTO = Component.getData("Hire.ContentSelect", hirecontentDTO);
		if(hirecontentDTO != null) {
			redirectAttribute.addFlashAttribute("HireNumber",hirecontentDTO.getTHC_NUMBER());
			
			HashMap<String,Object> map = new HashMap<>();
			if(!StringUtils.isBlank(hirecontentDTO.getTHC_LOWPAY())) {
				String[] lowpay = hirecontentDTO.getTHC_LOWPAY().toString().split(",");
				map.put("lowpay", lowpay);
			}
			
			String[] edutype = hirecontentDTO.getTHC_EDUTYPE().toString().split(",");
			String[] edusubject = hirecontentDTO.getTHC_EDUSUBJECT().toString().split(",");
			String[] edustart = hirecontentDTO.getTHC_EDUSTARTTIME().toString().split(",");
//			String[] eduend = hirecontentDTO.getTHC_EDUENDTIME().toString().split(",");
			map.put("edutype", edutype);
			map.put("edusubject", edusubject);
			map.put("edustart", edustart);
//			map.put("eduend", eduend);
			
			String[] certificate = hirecontentDTO.getTHC_CERTIFICATE().toString().split(",");
			String[] certificateAgency = hirecontentDTO.getTHC_CERTIFICATEAGENCY().toString().split(",");
			String[] certificateTime = hirecontentDTO.getTHC_CERTIFICATETIME().toString().split(",");
			map.put("certificate", certificate);
			map.put("certificateAgency", certificateAgency);
			map.put("certificateTime", certificateTime);
			
			String[] careertype = hirecontentDTO.getTHC_CAREERTYPE().toString().split(",");
			String[] careerAgency = hirecontentDTO.getTHC_CAREERAGENCY().toString().split(",");
			String[] careerPosition = hirecontentDTO.getTHC_CAREERPOSITION().toString().split(",");
			String[] careerstart = hirecontentDTO.getTHC_CAREERSATRTTIME().toString().split(",");
			String[] careerend = hirecontentDTO.getTHC_CAREERENDTIME().toString().split(",");
			String[] careerdo = hirecontentDTO.getTHC_CAREERDO().toString().split(",");
			map.put("careertype", careertype);
			map.put("careerAgency", careerAgency);
			map.put("careerPosition", careerPosition);
			map.put("careerstart", careerstart);
			map.put("careerend", careerend);
			map.put("careerdo", careerdo);
			
			if(!StringUtils.isBlank(hirecontentDTO.getTHC_UNYOUNG5())){
				String[] unyoun5 = hirecontentDTO.getTHC_UNYOUNG5().toString().split(",");
				String[] unyoun6 = hirecontentDTO.getTHC_UNYOUNG6().toString().split(",");
				String[] unyoun7 = hirecontentDTO.getTHC_UNYOUNG7().toString().split(",");
				map.put("unyoun5", unyoun5);
				map.put("unyoun6", unyoun6);
				map.put("unyoun7", unyoun7);
			}
			redirectAttribute.addFlashAttribute("HireContent",hirecontentDTO);
			redirectAttribute.addFlashAttribute("HireList",map);
		}else {
			
			String classtype = hireDTO.getTH_CLASSTYPE().toString();
			
//			numbering(hireDTO);
//			String number = "";
//			if(classtype.equals("기획경영팀")) {number = "101";}
//			else if(classtype.equals("문화사업팀")) {number = "201";}
//			else if(classtype.equals("문화예술교육팀")) {number = "301";}
//			else if(classtype.equals("공연예술진흥팀")) {number = "401";}
//			else if(classtype.equals("문화재연구소")) {number = "501";}
//			
//			int cnt = Component.getData("Hire.ClassNumber",hireDTO);
			String c = numbering(hireDTO);
			redirectAttribute.addFlashAttribute("HireNumber",c);
		}
		redirectAttribute.addFlashAttribute("bndate",Component.getData("Hire.BnTitle",hireDTO));
		redirectAttribute.addFlashAttribute("HireUser",hireDTO);
		redirectAttribute.addFlashAttribute("type","update");
		
		return "redirect:/jact/hire/intro2.do";
	}
	
	/**
	 *응시표 출력 
	 */
	@RequestMapping(value="/jact/hire/printPage.do")
	public ModelAndView HirePrintPage(
			HireUserDTO hireDTO
			,@RequestParam(value="BN_TITLE")String bntitle
			,@RequestParam(value="BN_DATE")String bndate
			)throws Exception {
		ModelAndView mv = new ModelAndView("/hire/HireInsert_print");
		
		HashMap<String,Object> map = Component.getData("Hire.GetAllData_log",hireDTO);
		mv.addObject("hire",map);
		mv.addObject("bntitle",bntitle);
		mv.addObject("bndate",bndate);
		
		return mv;
	}
	/**
	 *응시표 출력 
	 */
	@RequestMapping(value="/hire/PassAjax.do")
	@ResponseBody
	public String PassAjax(
			HireUserDTO hireDTO
			)throws Exception {
		hireDTO.encode();
		hireDTO = Component.getData("Hire.UserKeySelect2",hireDTO);
		String pass = hireDTO.getTH_PASS_YN();
		return pass;
	}
	/**
	 *파일등록 
	 */
	@RequestMapping(value="/jact/hire/fileInsert.do")
	@ResponseBody
	public ModelAndView fileInsertview(
			HireUserDTO hireDTO
			)throws Exception {
		ModelAndView mv = new ModelAndView("/hire/HireInsert_file");
		hireDTO = Component.getData("Hire.GetUserData",hireDTO);
		
		
		/*if(!StringUtils.isEmpty(hireDTO.getTH_FILE())) {
			String[] keylist = hireDTO.getTH_FILE().toString().split(",");
			
			ArrayList<String> fileT = new ArrayList<>();
			
			String FS_KEYNO =""; 
			if(keylist.length > 0) {
				for(int i=0;i<keylist.length;i++) {
					FS_KEYNO = keylist[i];
					FileSub file = Component.getData("File.AFS_SubFileDetailselect",FS_KEYNO);
					fileT.add(file.getFS_ORINM());
				}
				mv.addObject("fileT",fileT);
			}
		}*/
		if(!StringUtils.isEmpty(hireDTO.getTH_FILE1())) {
			mv.addObject("fileT1",UpdateTitleView(hireDTO.getTH_FILE1()));
			mv.addObject("fileT2",UpdateTitleView(hireDTO.getTH_FILE2()));
			mv.addObject("fileT3",UpdateTitleView(hireDTO.getTH_FILE3()));
			mv.addObject("fileT4",UpdateTitleView(hireDTO.getTH_FILE4()));
			mv.addObject("fileT5",UpdateTitleView(hireDTO.getTH_FILE5()));
			mv.addObject("fileT6",UpdateTitleView(hireDTO.getTH_FILE6()));
			mv.addObject("fileT7",UpdateTitleView(hireDTO.getTH_FILE7()));
			mv.addObject("fileT8",UpdateTitleView(hireDTO.getTH_FILE8()));
		}
		mv.addObject("hire",hireDTO);
		
		return mv;
	}
	
	
	public ArrayList<String> UpdateTitleView(String FS_KEYNO) {
		ArrayList<String> fileT = new ArrayList<>();
		
		if(!StringUtils.isEmpty(FS_KEYNO)) {
			String[] keylist = FS_KEYNO.toString().split(",");
			
			String KEYNO =""; 
			if(keylist.length > 0) {
				for(int i=0;i<keylist.length;i++) {
					KEYNO = keylist[i];
					FileSub file = Component.getData("File.AFS_SubFileDetailselect",KEYNO);
					fileT.add(file.getFS_ORINM());
				}
			}
		}
		return fileT;
	}
	
	
	/**
	 *파일등록 
	 */
	@RequestMapping(value="/hire/Fileinsert2.do")
	@Transactional
	public String fInsert(
			HireUserDTO hireDTO
			,HttpServletRequest req
			,MultipartHttpServletRequest request
			)throws Exception {
			List<List<MultipartFile>> AllList = new ArrayList<>();
		
			List<MultipartFile> fileList1 = request.getFiles("file1");
			List<MultipartFile> fileList2 = request.getFiles("file2");
			List<MultipartFile> fileList3 = request.getFiles("file3");
			List<MultipartFile> fileList4 = request.getFiles("file4");
			List<MultipartFile> fileList5 = request.getFiles("file5");
			List<MultipartFile> fileList6 = request.getFiles("file6");
			List<MultipartFile> fileList7 = request.getFiles("file7");
			List<MultipartFile> fileList8 = request.getFiles("file8");
		
			AllList.add(fileList1);
			AllList.add(fileList2);
			AllList.add(fileList3);
			AllList.add(fileList4);
			AllList.add(fileList5);
			AllList.add(fileList6);
			AllList.add(fileList7);
			AllList.add(fileList8);
			
			FileSub fsVo = new FileSub();
			boolean update = false;
			
			if(StringUtils.isBlank(hireDTO.getTH_FILE1())) {
				fsVo = null;
			}else {
				update = true;
			}
			
			//등록처리
			if(!update) {
				for(int i=0;i<AllList.size();i++) {
					List<String> Fskey = new ArrayList<>();
	
					for(MultipartFile m : AllList.get(i)) {
						
						String type = "";
						if(i==0) {type = "주민등록초본 )";}
						else if(i==1) {type = "기본증명서 )";}
						else if(i==2) {type = "증명사진 )";}
						else if(i==3) {type = "교육이수확인증 )";}
						else if(i==4) {type = "경력증명서 )";}
						else if(i==5) {type = "건강보험 )";}
						else if(i==6) {type = "직무관련자격증 )";}
						else if(i==7) {type = "기타 증빙자료 )";}
						
						FileSub file = FileUploadTools.FileUpload(m, "UI_SFMHO", fsVo, type);
						Fskey.add(file.getFS_KEYNO());
					}
					String file =  StringUtils.join(Fskey,",");
	
					if(i==0) {hireDTO.setTH_FILE1(file);}
					else if(i==1) {hireDTO.setTH_FILE2(file);}
					else if(i==2) {hireDTO.setTH_FILE3(file);}
					else if(i==3) {hireDTO.setTH_FILE4(file);}
					else if(i==4) {hireDTO.setTH_FILE5(file);}
					else if(i==5) {hireDTO.setTH_FILE6(file);}
					else if(i==6) {hireDTO.setTH_FILE7(file);}
					else if(i==7) {hireDTO.setTH_FILE8(file);}
				}
				Component.updateData("Hire.UserFileKeyAll", hireDTO);
			}
			
			//수정처리
			if(update) {
				List<String> Fskey = new ArrayList<>();

				for(int i=0;i<AllList.size();i++) {
					String keyno = "";
					
					if(i==0) {
						keyno = hireDTO.getTH_FILE1();
						hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);
					}
					else if(i==1) {keyno = hireDTO.getTH_FILE2();hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);}
					else if(i==2) {keyno = hireDTO.getTH_FILE3();hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);}
					else if(i==3) {keyno = hireDTO.getTH_FILE4();hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);}
					else if(i==4) {keyno = hireDTO.getTH_FILE5();hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);}
					else if(i==5) {keyno = hireDTO.getTH_FILE6();hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);}
					else if(i==6) {keyno = hireDTO.getTH_FILE7();hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);}
					else if(i==7) {keyno = hireDTO.getTH_FILE8();hireDTO = UpdateFsKey(AllList.get(i),keyno,hireDTO,i);}
					
				}
				Component.updateData("Hire.UserFileKeyAll", hireDTO);
			}
			
			//-------------------------------알집파일 처리 --------------------------------------
			FileSub file = new FileSub();
			hireDTO = Component.getData("Hire.GetUserData",hireDTO);
			
			if(hireDTO.getTH_ZIP_KEYNO() != null) {
				String FS_KEYNO = hireDTO.getTH_ZIP_KEYNO();
				file = Component.getData("File.AFS_SubFileDetailselect",FS_KEYNO);
			}else {
				file = null;
			}
			//알집파일 등록 또는 수정
			FileUploadTools.FileZip(hireDTO,file);
			
			req.setAttribute("TH_KEYNO", hireDTO.getTH_KEYNO());
			return "forward:/jact/hire/mypage.do";
	}
	
	
	
	public HireUserDTO UpdateFsKey(List<MultipartFile> FileList, String FileKey,HireUserDTO hireDTO, int cnt) {
		String type = "";
		if(cnt==0) {type = "주민등록초본 )";}
		else if(cnt==1) {type = "기본증명서 )";}
		else if(cnt==2) {type = "증명사진 )";}
		else if(cnt==3) {type = "교육이수확인증 )";}
		else if(cnt==4) {type = "경력증명서 )";}
		else if(cnt==5) {type = "건강보험 )";}
		else if(cnt==6) {type = "직무관련자격증 )";}
		else if(cnt==7) {type = "기타 증빙자료 )";}
		
		FileSub fsVo = new FileSub();
		ArrayList<String> temp = new ArrayList<>();
		String[] list = FileKey.split(",");
		//파일 갯수가 적을때
		if(FileList.size() < list.length) {
			for (int i = 0; i<FileList.size();i++) {
				fsVo = Component.getData("File.AFS_SubFileDetailselect",list[i]);
				FileSub file = FileUploadTools.FileUpload(FileList.get(i), "UI_SFMHO", fsVo, type);
				temp.add(file.getFS_KEYNO());
			}
			
			if(cnt==0) {hireDTO.setTH_FILE1(String.join(",",temp));}
			else if(cnt==1) {hireDTO.setTH_FILE2(String.join(",",temp));}
			else if(cnt==2) {hireDTO.setTH_FILE3(String.join(",",temp));}
			else if(cnt==3) {hireDTO.setTH_FILE4(String.join(",",temp));}
			else if(cnt==4) {hireDTO.setTH_FILE5(String.join(",",temp));}
			else if(cnt==5) {hireDTO.setTH_FILE6(String.join(",",temp));}
			else if(cnt==6) {hireDTO.setTH_FILE7(String.join(",",temp));}
			else if(cnt==7) {hireDTO.setTH_FILE8(String.join(",",temp));}
			
		}else {
			for (int i = 0; i<list.length;i++) {
				fsVo = Component.getData("File.AFS_SubFileDetailselect",list[i]);
				FileSub file = FileUploadTools.FileUpload(FileList.get(i), "UI_SFMHO", fsVo, type);
				temp.add(file.getFS_KEYNO());
			}
			//추가 파일 있을 때
			if(FileList.size() > list.length) {
				
				for(int j=list.length;j<FileList.size();j++) {
					MultipartFile ff = FileList.get(j);
					FileSub file = FileUploadTools.FileUpload(ff, "UI_SFMHO", null);
					temp.add(file.getFS_KEYNO());
				}
				if(cnt==0) {hireDTO.setTH_FILE1(String.join(",",temp));}
				else if(cnt==1) {hireDTO.setTH_FILE2(String.join(",",temp));}
				else if(cnt==2) {hireDTO.setTH_FILE3(String.join(",",temp));}
				else if(cnt==3) {hireDTO.setTH_FILE4(String.join(",",temp));}
				else if(cnt==4) {hireDTO.setTH_FILE5(String.join(",",temp));}
				else if(cnt==5) {hireDTO.setTH_FILE6(String.join(",",temp));}
				else if(cnt==6) {hireDTO.setTH_FILE7(String.join(",",temp));}
				else if(cnt==7) {hireDTO.setTH_FILE8(String.join(",",temp));}
			}
			
		}
		
		return hireDTO;
	}
	
	
	/**
	 *파일등록 
	 */
	@RequestMapping(value="/hire/FileinsertAll.do")
	public String FileinsertAll(
			HireUserDTO hireDTO
			,HttpServletRequest req
			,MultipartHttpServletRequest request
			)throws Exception {
		//파일 받아옴
		List<MultipartFile> fileList = request.getFiles("file");
		ArrayList<String> keylist = new ArrayList<>();
		FileSub fsVo = new FileSub();
		boolean update = false;
		
		
		//업데이트
		if(!StringUtils.isEmpty(hireDTO.getTH_FILE())) {
			update = true;
			String[] list = hireDTO.getTH_FILE().toString().split(",");
			 
			for (int i = 0; i<list.length;i++) {
				fsVo = Component.getData("File.AFS_SubFileDetailselect",list[i]);
				FileSub file = FileUploadTools.FileUpload(fileList.get(i), "UI_SFMHO", fsVo);
				keylist.add(file.getFS_KEYNO());
			}
			//추가 파일 있을 때
			if(fileList.size() != list.length) {
				
				for(int j=list.length;j<fileList.size();j++) {
					MultipartFile ff = fileList.get(j);
					FileSub file = FileUploadTools.FileUpload(ff, "UI_SFMHO", null);
					keylist.add(file.getFS_KEYNO());
				}
				
				hireDTO.setTH_FILE(String.join(",",keylist));
				
				Component.updateData("Hire.UserFileKey", hireDTO);
			}
		}
		
		
		//신규 처리
		if(!update) {
			for (MultipartFile f : fileList) {
				FileSub file = FileUploadTools.FileUpload(f, "UI_SFMHO", fsVo);
				keylist.add(file.getFS_KEYNO());
			}
			hireDTO.setTH_FILE(String.join(",",keylist));
			
			Component.updateData("Hire.UserFileKey", hireDTO);
		}
		
		
		//-----------------------------------------------------------------------
		//알집 처리
		FileSub file = new FileSub();
		hireDTO = Component.getData("Hire.GetUserData",hireDTO);
		if(hireDTO.getTH_ZIP_KEYNO() != null) {
			String FS_KEYNO = hireDTO.getTH_ZIP_KEYNO();
			file = Component.getData("File.AFS_SubFileDetailselect",FS_KEYNO);
		}else {
			file = null;
		}
		//알집파일 등록 또는 수정
		FileUploadTools.FileZip(hireDTO,file);
		
		
		req.setAttribute("TH_KEYNO", hireDTO.getTH_KEYNO());
		return "forward:/jact/hire/mypage.do";
	}
	
	
	
	
	//-----------------------------------------관리자 컨트롤러--------------------------------------------------
	
	
	
	@RequestMapping(value = "/txap/hire.do")
	@CheckActivityHistory(desc = "채용 관리 페이지 방문")
	public ModelAndView BoardHire(
			HttpServletRequest req
			) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/hire/pra_hire_data_listView.adm");

		//채용공고 게시물 key와 title만 뽑기
		List<HashMap<String,Object>> list = Component.getListNoParam("Hire.AdminHireBoardSelect");
		
		mv.addObject("HireBoard",list);
		
		return mv;
	}
	
	
	@RequestMapping(value = "/txap/hire/pageAjax.do")
	public ModelAndView BoardHirePage(
			HttpServletRequest req,
			Common search,
			@RequestParam(value = "BN_KEYNO", required = false) String BN_KEYNO
			) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/hire/pra_hire_data_listView_data");
		List<HashMap<String, Object>> searchList = Component.getSearchList(req);
		Map<String, Object> map = CommonService.ConverObjectToMap(search);
		map.put("BN_KEYNO", BN_KEYNO);
		if (searchList != null) {
			map.put("searchList", searchList);
		}
		
		String sql = "Hire.UserSelect";
		String whatcnt = "one";
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(), "Hire.UserSelectCnt", map,search.getPageUnit(), 10);
		if(pageInfo.getTotalRecordCount() == 0 && StringUtils.isNotBlank(BN_KEYNO)) {
			pageInfo = PageAccess.getPagInfo(search.getPageIndex(), "Hire.UserSelectCnt2", map,search.getPageUnit(), 10);
			if(pageInfo.getTotalRecordCount() > 0) {
				sql = "Hire.UserSelect2";
				whatcnt = "two";
			}
		}
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		List<HireUserDTO> hirelist = Component.getList(sql,map);
		
		List<HireUserDTO> hirelist2 = new ArrayList<>();
		for(HireUserDTO h : hirelist) {
			h.decode();
			hirelist2.add(h);
		}
		mv.addObject("whatcnt",whatcnt);
		mv.addObject("resultList",hirelist2);
		mv.addObject("TH_BNKEYNO",BN_KEYNO);
		mv.addObject("search", search);
		
		
		return mv;
	}
	
	
	@RequestMapping(value = "/txap/hire/excelAjax.do")
	public Object BoardDataListViewExcelAjax(
			HttpServletRequest req,
			Common search,
			HttpServletResponse res,
			@RequestParam(value = "BN_KEYNO", required = false) String BN_KEYNO
			) throws Exception {
		ModelAndView mv = new ModelAndView("/txap/hire/pra_hire_data_listView_excel");

		List<HashMap<String, Object>> searchList = Component.getSearchList(req);

		Map<String, Object> map = CommonService.ConverObjectToMap(search);
		map.put("BN_KEYNO", BN_KEYNO);
		if (searchList != null) {
			map.put("searchList", searchList);
		}
		
		String sql = "Hire.UserSelect";
		PaginationInfo pageInfo = PageAccess.getPagInfo(search.getPageIndex(), "Hire.UserSelectCnt", map,search.getPageUnit(), 10);
		if(pageInfo.getTotalRecordCount() == 0 && StringUtils.isNotBlank(BN_KEYNO)) {
			pageInfo = PageAccess.getPagInfo(search.getPageIndex(), "Hire.UserSelectCnt2", map,search.getPageUnit(), 10);
			if(pageInfo.getTotalRecordCount() > 0) {
				sql = "Hire.UserSelect2";
			}
		}
		map.put("firstIndex", pageInfo.getFirstRecordIndex());
		map.put("lastIndex", pageInfo.getLastRecordIndex());
		map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
		
		mv.addObject("paginationInfo", pageInfo);
		List<HireUserDTO> hirelist = Component.getList(sql,map);
		
		List<HireUserDTO> hirelist2 = new ArrayList<>();
		for(HireUserDTO h : hirelist) {
			h.decode();
			hirelist2.add(h);
		}
		mv.addObject("resultList",hirelist2);

		try {

			Cookie cookie = new Cookie("fileDownload", "true");
			cookie.setPath("/");
			res.addCookie(cookie);

		} catch (Exception e) {
			System.out.println("쿠키 에러 :: " + e.getMessage());
		}
		return mv;

	}
	
	
	
	
	@RequestMapping(value = "/hire/UserPrint.do")
	@Transactional
	public ModelAndView UserInfoPrint(
			HireUserDTO hire
			)throws Exception {
		ModelAndView mv = new ModelAndView("/hire/HireInsert_into_print_pdf.none");
		HashMap<String,Object> result = Component.getData("Hire.UserSelectAll",hire);
		
		HashMap<String,Object> map = new HashMap<>();
		if(null != result.get("THC_LOWPAY")) {
			String[] lowpay = result.get("THC_LOWPAY").toString().split(",");
			map.put("lowpay", lowpay);
		}
		
		String[] edutype = result.get("THC_EDUTYPE").toString().split(",");
		String[] edusubject = result.get("THC_EDUSUBJECT").toString().split(",");
		String[] edustart = result.get("THC_EDUSTARTTIME").toString().split(",");
//		String[] eduend = result.get("THC_EDUENDTIME").toString().split(",");
		map.put("edutype", edutype);
		map.put("edusubject", edusubject);
		map.put("edustart", edustart);
//		map.put("eduend", eduend);
		
		String[] certificate = result.get("THC_CERTIFICATE").toString().split(",");
		String[] certificateAgency = result.get("THC_CERTIFICATEAGENCY").toString().split(",");
		String[] certificateTime = result.get("THC_CERTIFICATETIME").toString().split(",");
		map.put("certificate", certificate);
		map.put("certificateAgency", certificateAgency);
		map.put("certificateTime", certificateTime);
		
		String[] careertype = result.get("THC_CAREERTYPE").toString().split(",");
		String[] careerAgency = result.get("THC_CAREERAGENCY").toString().split(",");
		String[] careerPosition = result.get("THC_CAREERPOSITION").toString().split(",");
		String[] careerstart = result.get("THC_CAREERSATRTTIME").toString().split(",");
		String[] careerend = result.get("THC_CAREERENDTIME").toString().split(",");
		String[] careerdo = result.get("THC_CAREERDO").toString().split(",");
		map.put("careertype", careertype);
		map.put("careerAgency", careerAgency);
		map.put("careerPosition", careerPosition);
		map.put("careerstart", careerstart);
		map.put("careerend", careerend);
		map.put("careerdo", careerdo);
		
		if(!StringUtils.isBlank(result.get("THC_UNYOUNG5").toString())){
			String[] unyoun5 = result.get("THC_UNYOUNG5").toString().split(",");
			String[] unyoun6 = result.get("THC_UNYOUNG6").toString().split(",");
			String[] unyoun7 = result.get("THC_UNYOUNG7").toString().split(",");
			map.put("unyoun5", unyoun5);
			map.put("unyoun6", unyoun6);
			map.put("unyoun7", unyoun7);
		}
		
		String army = result.get("THC_ARMY").toString();
		if(army.equals("P")) {
			army = "군필";
		}else if(army.equals("M")) {
			army = "미필";
		}else {
			army = "면제/비대상";
		}
		
		
		
//		ConvertToPdf pdf = new ConvertToPdf();
//		pdf.createPdf("test", htmlStr, request);
		
		mv.addObject("army",army);
		mv.addObject("Hire",result);
		mv.addObject("HireList",map);
		
		
		return mv;
	}
	
	//pdf 변환 진행
	@RequestMapping(value = "/hire/PdfAjax.do")
	@Transactional
	public String Pdfdownload(
			HttpServletRequest req,
			HireContentDTO hirecontentDTO,
			RedirectAttributes redirectAttribute,
			@RequestParam(value="htmlStr",required=false)String htmlStr,
			@RequestParam(value="TH_KEYNO",required=false)String TH_KEYNO,
			@RequestParam(value="type",required=false)String type
			) throws Exception {
		HireUserDTO hire = Component.getData("Hire.GetAllData",TH_KEYNO);
		String filename = hire.getTHC_NUMBER()+"-"+ hire.getTH_USER();
		ConverToPdf pdf = new ConverToPdf();
		MultipartFile mfile = pdf.createPdf(filename, htmlStr, req , propertiesService);

		if(StringUtils.isEmpty(hire.getTH_PDF_KEYNO())) {
			FileSub filesub = FileUploadTools.FileUpload(mfile, "UI_SFMHO", null);
			hire.setTH_PDF_KEYNO(filesub.getFS_KEYNO());
			Component.createData("Hire.PdfFileInsert", hire);
		}else {
			String FS_KEYNO = hire.getTH_PDF_KEYNO();
			FileSub fsVo = Component.getData("File.AFS_SubFileDetailselect",FS_KEYNO);
			fsVo = FileUploadTools.FileUpload(mfile, "UI_SFMHO", fsVo);
		}
		
		String view = "redirect:/jact/hire/result.do";
		if(type.equals("update")) {
			view = "forward:/jact/hire/mypage.do";
			req.setAttribute("TH_KEYNO", hirecontentDTO.getTHC_USERKEY());
		}else {
			HireUserDTO hire2 = new HireUserDTO();
			hire2.setTH_KEYNO(hirecontentDTO.getTHC_USERKEY());
			hire2 = Component.getData("Hire.GetUserData",hire2);
			redirectAttribute.addFlashAttribute("bndate",Component.getData("Hire.BnTitle",hire2));
			redirectAttribute.addFlashAttribute("hire",hire2);
			redirectAttribute.addFlashAttribute("hirecontentDTO", hirecontentDTO);
		}
		return view;
	}
	//PDF전체 다운로드
	@RequestMapping(value = "/txap/hire/PDFALLAjax.do")
	public void Pdfdownload2(
			HttpServletRequest req,
			HttpServletResponse res,
			@RequestParam(value="TH_BNKEYNO",required=false)String BN_KEYNO,
			@RequestParam(value="whatcnt",required=false)String whatcnt,
			@RequestParam(value="TITLE",required=false)String TITLE
			) throws Exception {
		
		String mysql = "Hire.UserSelect_pdf";
		if(whatcnt.equals("two")) {
			mysql = "Hire.UserSelect2_pdf";
		}
		
		ArrayList<String> KeyList = new ArrayList<>();
		List<HireUserDTO> list = Component.getList(mysql, BN_KEYNO);
		
		String filename = TITLE +"-"+BN_KEYNO.substring(8);
		for(HireUserDTO l : list) {
			KeyList.add(l.getTH_PDF_KEYNO());
		}
		
		HashMap<String,Object> map = FileUploadTools.FileZip2(KeyList,filename);
		Filedown.FileDownload(map.get("filepath").toString(),map.get("filename").toString(), req, res);
		
	}
	
	//합격 여부 수정
	@RequestMapping(value = "/txap/hire/PassAjax.do")
	@ResponseBody
	public void PassAjax(
			HttpServletRequest req,
			HireUserDTO hireDTO
			) throws Exception {
		Component.updateData("Hire.PassUpdate", hireDTO);
	}

	//넘버링 체크하고 만드는거 
	public String numbering(
			HireUserDTO hireDTO
			)throws Exception{
		
		String classtype = hireDTO.getTH_CLASSTYPE().toString();
		String number = "";
		if(classtype.equals("기획경영팀")) {number = "101";}
		else if(classtype.equals("문화사업팀")) {number = "201";}
		else if(classtype.equals("문화예술교육팀")) {number = "301";}
		else if(classtype.equals("공연예술진흥팀")) {number = "401";}
		else if(classtype.equals("문화재연구소")) {number = "501";}
		
		String cnt = Component.getData("Hire.ClassNumber",hireDTO);
		int cN = 0;
		
		if(cnt == null) {
			cN = Integer.parseInt("0");
		}else {
			cnt = cnt.substring(cnt.indexOf("-")+1,cnt.length());
			cN = Integer.parseInt(cnt);
		}
		String c = String.format("%02d",(cN+1));
		String result = number+"-"+c;
		
		return result;
	}
	
	/*//pdf 변환 진행 테스트
		@RequestMapping(value = "/hire/PdfAjaxtest.do")
		@Transactional
		public void Pdfdownload2(
				HttpServletRequest req,
				HttpServletResponse res,
				HireContentDTO hirecontentDTO,
				RedirectAttributes redirectAttribute,
				@RequestParam(value="htmlStr",required=false)String htmlStr,
				@RequestParam(value="TH_KEYNO",required=false)String TH_KEYNO,
				@RequestParam(value="type",required=false)String type
				) throws Exception {
			String filename = "Dd";
			ConverToPdf2 pdf = new ConverToPdf2();
			pdf.createPdf(filename, htmlStr, req , propertiesService, res);
		}*/
		
		
		//pdf 변환 진행  - 에러로 인해 pdf생성안될때 재생성
		@RequestMapping(value = "/hire/PdfAjax2.do")
		@Transactional
		@ResponseBody
		public String Pdfdownload2(
				HttpServletRequest req,
				@RequestParam(value="htmlStr",required=false)String htmlStr,
				@RequestParam(value="KEYNO",required=false)String TH_KEYNO
				) throws Exception {
			HireUserDTO hire = Component.getData("Hire.GetAllData",TH_KEYNO);
			String filename = hire.getTHC_NUMBER()+"-"+ hire.getTH_USER();
			ConverToPdf pdf = new ConverToPdf();
			MultipartFile mfile = pdf.createPdf(filename, htmlStr, req , propertiesService);

			FileSub filesub = FileUploadTools.FileUpload(mfile, "UI_SFMHO", null);
			hire.setTH_PDF_KEYNO(filesub.getFS_KEYNO());
			Component.createData("Hire.PdfFileInsert", hire);		
			
			return filesub.getFS_KEYNO();
		}	
		
		//회원정보 확인하기
		@RequestMapping(value="/hire/userInfo.do")
		public ModelAndView UserInfo(
				HttpServletRequest req
				) throws Exception {
			ModelAndView mv = new ModelAndView("/hire/HireInsert_UserInfo");		
			
			return mv;
		}	
		
		//회원정보 확인하기 확인
		@RequestMapping(value="/hire/userInfo2.do")
		@ResponseBody
		public HireUserDTO UserInfo2(
				HttpServletRequest req,
				HireUserDTO hireUser
				) throws Exception {
			HashMap<String, Object> map = new HashMap<String, Object>();
			hireUser = Component.getData("Hire.UserInfo", hireUser);
			hireUser.decode();
			
			return hireUser;
		}	
		
		//동의서 출력부분
		@RequestMapping(value = "/hire/UserAgree.do")
		@ResponseBody
		public ModelAndView UserAgree(
				HttpServletRequest req
				)throws Exception {
			
			ModelAndView mv = new ModelAndView("/hire/HireInsert_AgreePrint.none");		
			
			return mv;
		}
}
