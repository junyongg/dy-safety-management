package com.tx.admin.homepage.menu.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.plexus.util.StringUtils;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.DefaultWebInvocationPrivilegeEvaluator;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ibm.icu.text.SimpleDateFormat;
import com.tx.admin.homepage.authority.dto.Resource;
import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.menu.service.AdminMenuService;
import com.tx.admin.homepage.menu.service.AdminMenuSessionService;
import com.tx.admin.member.dto.UserDTO;
import com.tx.admin.operation.qrcode.dto.QrCode;
import com.tx.admin.operation.qrcode.service.QrCodeService;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileManageTools;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;
import com.tx.common.security.handler.ReloadableFilterInvocationSecurityMetadataSource;
import com.tx.common.xml.service.XMLService;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 관리자 - 메뉴관리
 * @author 
 * @version 1.0
 * @since 
 */
@Controller
public class AdminMenuManager {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 리로드 권한설정 */
	@Autowired ReloadableFilterInvocationSecurityMetadataSource reloadableFilterInvocationSecurityMetadataSource;
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/** QrCode */
	@Autowired private QrCodeService QrCodeService;
	
	/** Xml */
	@Autowired private XMLService XMLService;
	
	/** 메뉴관리 서비스 */
	@Autowired private AdminMenuService AdminMenuService;
	
	/** 메뉴관리 서비스2 */
	@Autowired private AdminMenuSessionService AdminMenuSessionService;
	
	/** 파일관리 툴 */
	@Autowired FileManageTools FileManageTools;

	/** 프로퍼티 정보 읽기 */
	@javax.annotation.Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private DefaultWebInvocationPrivilegeEvaluator webInvocationPrivilegeEvaluator;
	
	
	
	/**
	 * 메뉴관리 (List) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/menu.do")
	@CheckActivityHistory(desc = "메뉴관리 방문")
	public String MenuManagerView(Model model,Menu Menu) throws Exception{ 
		
		//홈페이지 구분 리스트
		List<HomeManager> homeDivList = CommonService.getHomeDivCode(true);
		model.addAttribute("homeDivList", homeDivList);
		
		
		String mnHomedivC =Menu.getMN_HOMEDIV_C();
		
		//실재하는 HomeKey인지 체크
		boolean isExistsHomeKey = false;
		for( Menu m : homeDivList ){
			if( m.getMN_HOMEDIV_C().equals(mnHomedivC) ){
				isExistsHomeKey = true;
				break;
			}
		}
		
		//홈페이지 구분값 없을 시 초기값 설정 (웹)
		if(isExistsHomeKey){
			Menu.setMN_MAINKEY(mnHomedivC);
		}else{
			Menu.setMN_HOMEDIV_C(SettingData.HOMEDIV_JACT);
			Menu.setMN_MAINKEY(SettingData.HOMEDIV_JACT);
		}
		
		Menu.setMN_DEL_YN("N");
		
		Menu.setMN_KEYNO(Menu.getMN_HOMEDIV_C());
		Menu = Component.getData("Menu.AMN_getDataByKey", Menu);
		model.addAttribute("menu", Menu);
		HomeManager hm = new HomeManager();
		hm.setHM_MN_HOMEDIV_C(Menu.getMN_HOMEDIV_C());
		hm = Component.getData("HomeManager.HM_getDataByHOMEDIV_C", hm);
		model.addAttribute("homeData", hm);
		
		//메뉴 타입 리스트
		model.addAttribute("menuList",Component.getList("Code.ASC_GetList", "AF"));
		
		//홈페이지 tiles 리스트
		model.addAttribute("homepageTilesCode",Component.getList("Code.ASC_GetList", "AE"));
		
		//게시판 타입 리스트
		model.addAttribute("boardTypeList",Component.getListNoParam("BoardType.BT_getList2"));
		
		//권한 리스트
		model.addAttribute("authorityList", Component.getList("HomeManager.UIA_GetListWithHome",hm));
		
		model.addAttribute("resultList",AdminMenuService.getMenuList(hm, null));
		
		return "/txap/homepage/menu/pra_menu_list.adm";
	}
	
	

	/**
	 * 메뉴관리 (subList) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/menu/subList/listAjax.do")
	public ModelAndView MenuManagerSubList(Model model,Menu Menu) throws Exception{ 
		
		ModelAndView mv  = new ModelAndView("/txap/homepage/menu/pra_menu_list_data");
		
		Menu.setMN_DEL_YN("N");
		
		mv.addObject("resultList", Component.getList("Menu.AMN_getMenuList",Menu));
		
		return mv;
	}
	
	
	/**
	 * 메뉴 페이지 엑셀 - excel ajax
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/menu/excelAjax.do")
	public ModelAndView MenuExcelAjax(
			HttpServletResponse res
			, Model model,Menu Menu) throws Exception{ 
		
		ModelAndView mv  = new ModelAndView("/txap/homepage/menu/pra_menu_list_excel");
		Menu.setMN_DEL_YN("N");
		HomeManager homeManager = Component.getData("Menu.AMN_getMenuList",Menu);
		mv.addObject("resultList", AdminMenuService.getMenuList(homeManager,null, true));
		
		Integer HM_MENU_DEPTH = Component.getData("Menu.get_HomeDepth", Menu);

		mv.addObject("depth", HM_MENU_DEPTH);
		
		try {
			Cookie cookie = new Cookie("fileDownload", "true");
			cookie.setPath("/");
			res.addCookie(cookie);
		} catch (Exception e) {
			System.out.println("쿠키 에러 :: "+e.getMessage());
		}
		
		String WebName = Component.getData("Menu.excel_getWebName", Menu);
		mv.addObject("WEBNAME", WebName);
		
		return mv;
	}
	
	/**
	 * 메뉴 페이지 엑셀Back- excel ajax
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/menu/excelAjaxBack.do")
	public ModelAndView MenuExcelAjaxBack(
			HttpServletResponse res
			, Model model,Menu Menu) throws Exception{ 
		
		ModelAndView mv  = new ModelAndView("/txap/homepage/menu/pra_menu_list_excel");
		Integer HM_MENU_DEPTH = Component.getData("Menu.get_HomeDepth", Menu);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("MN_HOMEDIV_C", Menu.getMN_HOMEDIV_C());
		List<HashMap<String, Integer>> list = new ArrayList<HashMap<String, Integer>>();
		for (int i = 0; i < HM_MENU_DEPTH; i++) {
			HashMap<String, Integer> data = new HashMap<String,Integer>();
			data.put("index", i+1);
			data.put("reverse", HM_MENU_DEPTH - i);
			list.add(data);
		}
		map.put("list", list);
		List<HashMap<String, Object>> resultList = Component.getList("Menu.excel_getMenuList", map);
		
		String categoryName[] = new String[HM_MENU_DEPTH+1];
		
		for(HashMap<String, Object> result : resultList){
			for(int i = 0; i < HM_MENU_DEPTH+1; i++ ){
				String num = String.valueOf(i);
				String depth = (String)result.get("DEPTH"+num);
				if(depth != null && !depth.equals(categoryName[i])){
					int rowSpan = getRowSpan(depth,resultList,"DEPTH"+num,result);
					result.put("DEPTH"+num+"_rowSpan", rowSpan);
					categoryName[i] = depth;
				}
			}
		}

		mv.addObject("resultList", resultList);
		mv.addObject("depth", HM_MENU_DEPTH);
		
		try {
			Cookie cookie = new Cookie("fileDownload", "true");
			cookie.setPath("/");
			res.addCookie(cookie);
		} catch (Exception e) {
			System.out.println("쿠키 에러 :: "+e.getMessage());
		}
		
		String WebName = Component.getData("Menu.excel_getWebName", Menu);
		mv.addObject("WEBNAME", WebName);

		return mv;
	}
	
	/**
	 * 
	 * @param categoryName
	 * @param resultList
	 * @param key 
	 * @param result
	 * @return
	 */
	private int getRowSpan(String categoryName, List<HashMap<String, Object>> resultList, String key, HashMap<String, Object> result) {
		int index = resultList.indexOf(result);
		
		List<HashMap<String, Object>> subResultList = resultList.subList(index, resultList.size());
		int count = 0;
		for(HashMap<String, Object> sub : subResultList){
			String data = (String)sub.get(key);
			if(categoryName.equals(data)){
				count++;
			}else{
				break;
			}
		}
		return count;
	}
	
	/**
	 * 메뉴 Xml 리스트 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */ 
	@ResponseBody
	@RequestMapping(value = "/txap/homepage/menu/xmlList/listAjax.do")
	public List<HashMap<String, Object>> MenuXmlListAjax(
			HttpServletResponse res
			, Model model,Menu Menu) throws Exception{ 
		
		List<HashMap<String, Object>> list = Component.getList("Menu.XML_getHistoryList", Menu); 

		return list;
	}

	/**
	 * 메뉴 페이지 xml - xml ajax
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/menu/xmlList/backupAjax.do")
	public void MenuXmlBackupAjax(
			  HttpServletRequest request
			, HttpServletResponse response
			, Model model
			, Menu Menu
			, HomeManager HomeManager) throws Exception{ 
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("MN_HOMEDIV_C", Menu.getMN_HOMEDIV_C());
		List<HashMap<String, Object>> MenuInfoList = Component.getList("Menu.XML_getMenuInfo", map);
		
		Document doc = new Document();  
		doc = getXmlfile(MenuInfoList);
		
		String WebName = Component.getData("Menu.excel_getWebName", Menu);
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmss");
		WebName = WebName+"_"+date.format(today)+".xml";
		FileSub FileSub = new FileSub();
		try {                               
				  
				String propertiespath = propertiesService.getString("resourcePath");
				File fileFolder = new File(propertiespath+"attach/"); 
				if (!fileFolder.exists() || fileFolder.isFile()) {
		               fileFolder.mkdirs();
		            }
				String filepath = propertiespath+"attach/"+WebName;
				FileOutputStream out = new FileOutputStream(filepath); 
			    //xml 파일을 떨구기 위한 경로와 파일 이름 지정해 주기
			    XMLOutputter serializer = new XMLOutputter();                 
			                                                                    
			    Format f = serializer.getFormat();                            
			    f.setEncoding("UTF-8");
			    //encoding 타입을 UTF-8 로 설정
			    f.setIndent(" ");                                             
			    f.setLineSeparator("\r\n");                                   
			    f.setTextMode(Format.TextMode.TRIM);                          
			    serializer.setFormat(f);                                      
			                                                                    
			    serializer.output(doc, out);
			    
			    out.flush();
			    out.close(); 
			  
			    Map<String,Object> user = (HashMap<String, Object>) request.getSession().getAttribute("userInfo");
			    FileSub = FileUploadTools.FileUploadByXML(WebName, filepath,(String)user.get("UI_KEYNO"));
		        
		      //String 으로 xml 출력
		     // XMLOutputter outputter = new XMLOutputter(Format.getPrettyFormat().setEncoding("UTF-8")) ;
		     // System.out.println(outputter.outputString(doc));
		  } catch (IOException e) {                                         
		      System.err.println(e);                                        
		  }  
		
		   Menu.setXH_KEYNO(CommonService.getTableKey("XH"));
		   Menu.setXH_MN_KEYNO(Menu.getMN_HOMEDIV_C());
		   Menu.setXH_FS_KEYNO(FileSub.getFS_KEYNO());
		   Component.createData("Menu.XML_regist", Menu);
	}
	
	/**
	 * xml 파일 생성
	 @param resultList
	 @return
	 */
	private Document getXmlfile(List<HashMap<String, Object>> MenuInfoList) {
		Document document = null;
		Element rootElement = null;
		Element rootElement2 = null;
		Element rootElement3 = null;
		
		// document 초기화.
	    document = new Document();
	    rootElement = new Element("menuInfo");
	    // root Element의 태그와 value값을 설정함.
	    rootElement.setAttribute("type", "menu");
	    // document와 Element값을 합치는 작업.
	    document.addContent(rootElement);
	   
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("table", "T_MENU_MANAGER");
		//컬럼명
		List<HashMap<String, Object>> MenuColumn = Component.getList("Menu.XML_getMenuColumn", map);
		map.put("table", "T_MENU_RESOURCES");
		List<HashMap<String, Object>> MenuAuthColumn = Component.getList("Menu.XML_getMenuColumn", map);
		
		if(MenuInfoList != null && MenuInfoList.size() > 0){
			for(HashMap<String, Object> MenuData : MenuInfoList){
				rootElement2 = new Element("manager");
				rootElement2.setAttribute("type", "info");
				if(MenuColumn != null && MenuColumn.size() > 0){
					String key = null;
					for(HashMap<String, Object> column : MenuColumn){
						String value = null;
						String name = column.get("Field").toString();
						if(name.equals("MN_KEYNO")){
							key = MenuData.get(name).toString();
						}
						if(MenuData.get(name) == null){
							value = "";
						}else{
							value = MenuData.get(name).toString();
						}
						Element Element = null;
						// 실질적으로 element에 들어가는 태그와 value값을 설정하는 것.
						Element = new Element(name);
						Element.setText(value);
						// rootElement와 생성한 element를 합치는 작업
						rootElement2.addContent(Element); 
					}
					
					HashMap<String, Object> authmap = new HashMap<String, Object>();
					authmap.put("MN_KEYNO", key);
					List<HashMap<String, Object>> MenuAuthInfo = Component.getList("Menu.XML_getMenuAuthInfo", authmap);
					
					if(MenuAuthInfo != null && MenuAuthInfo.size() > 0){
						for(HashMap<String, Object> MenuAuthData : MenuAuthInfo){
							rootElement3 = new Element("resources");
							rootElement3.setAttribute("type", "auth");
							for(HashMap<String, Object> Authcolumn : MenuAuthColumn){
								String value = null;
								String name = Authcolumn.get("Field").toString();
								if(MenuAuthData.get(name) == null){
									value = "";
								}else{
									value = MenuAuthData.get(name).toString();
								}
								Element Element = null;
								// 실질적으로 element에 들어가는 태그와 value값을 설정하는 것.
								Element = new Element(name);
								Element.setText(value);
								// rootElement와 생성한 element를 합치는 작업
								rootElement3.addContent(Element); 
							}
							rootElement2.addContent(rootElement3);
						}
					}
				}
				rootElement.addContent(rootElement2);
			}
		}
	  return document;
		 
	}

	/**
	 * 메뉴 페이지 xml - xml 복원
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */ 
	@ResponseBody
	@Transactional
	@RequestMapping(value = "/txap/homepage/menu/xmlList/refreshAjax.do")
	public String MenuXmlRefreshAjax(
			  HttpServletRequest request
			, HttpServletResponse response
			, Model model
			, Menu Menu) throws Exception{ 
		List<String> list = Component.getList("Menu.XML_getAllMenuList", Menu);
		if(list != null && list.size() > 0){
			for (String key : list) {
				Component.deleteData("Menu.XML_MenuResourceDel", key);
			}
			Component.deleteData("Menu.XML_MenuListDel", Menu);
		}
		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(Menu.getXH_FS_KEYNO());
		FileSub = Component.getData("File.AFS_SubFileDetailselect", FileSub);
		XMLService.getXmlData(FileSub,"T_MENU_MANAGER","manager",1);
		XMLService.getXmlData(FileSub,"T_MENU_RESOURCES","resources",0);
		return Menu.getMN_HOMEDIV_C();
	}
	
	 
	/**
	 * 메뉴 페이지 xml - xml 삭제
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */ 
	@ResponseBody
	@RequestMapping(value = "/txap/homepage/menu/xmlList/deleteAjax.do")
	public void MenuXmlDeleteAjax(
			HttpServletRequest request
			, HttpServletResponse response
			, Model model
			, Menu Menu) throws Exception{ 
		Component.deleteData("Menu.XML_Delete", Menu);
	}
	
	

	
	@RequestMapping(value = "/txap/homepage/menu/urlCheckAjax.do")
	@ResponseBody
	public Integer MenuUrlCheckAjax(
			  @ModelAttribute Menu Menu
			) throws Exception{ 
		
		Menu.setMN_PAGEDIV_C(SettingData.MENU_TYPE_LINK);
		
		return Component.getCount("Menu.AMN_getMenuUrlList",Menu);
	}
	
	
	@RequestMapping(value = "/txap/homepage/menu/countAjax.do")
	@ResponseBody
	public Integer MenuCountAjax(
			  Model model
			, @ModelAttribute Menu Menu
			, @RequestParam(value="key", required=false) String key
			, @RequestParam(value="homekey", required=false) String homekey
			) throws Exception{ 
		Menu.setMN_MAINKEY(key);
		Menu.setMN_HOMEDIV_C(homekey);
		return Component.getData("Menu.AMN_getMenuCnt",Menu);
	}
	
	@RequestMapping(value = "/txap/homepage/menu/dataAjax.do")
	@ResponseBody
	public HashMap<String, Object> MenuDataAjax(Model model,@ModelAttribute Menu Menu) throws Exception{ 
		HashMap<String, Object> map = new HashMap<>();
		map.put("result", Component.getData("Menu.AMN_getData",Menu));
		map.put("MenuCnt", Component.getData("Menu.AMN_getMenuCnt",Menu));
		return map;
	}
	
	
	/**
	 * 메뉴관리 (등록) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/insertAjax.do")
	@CheckActivityHistory(desc = "메뉴 등록 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerResist(Model model,@ModelAttribute Menu Menu, HttpServletRequest req) throws Exception{ 
		Menu.setMN_KEYNO(CommonService.getTableKey("MN"));
		int a;
		// 입력된 정렬기준의 절렬순서를 가지고 있는 메뉴를 찾아 갯수를 세는 sql문
		a = Component.getData("Menu.AMN_getMNLV", Menu);
		
		//sql문 결과 데이터가 존재하는 경우, 해당 번호부터 해당 번호보다 큰 숫자의 정렬 순서들을 모두 +1해주는 코딩문 실행
		if(a>0){
			Component.updateData("Menu.AMN_addMNLV", Menu);
		}
		
		if("Y".equals(Menu.getMN_QRCODE())){
			String url = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+Menu.getMN_URL();
			
			String filename = Menu.getMN_URL().replaceAll("/", "_");
			FileSub sub = QrCodeService.getMenuQrCode(url, 100, 100, filename);
			String QR_KEY = sub.getFS_KEYNO();
			Menu.setMN_QR_KEYNO(QR_KEY);
		}
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_REGNM((String)user.get("UI_KEYNO"));
		
		
		Component.createData("Menu.AMN_regist",Menu);
		
		//저장할때 해당키 수정시간저장
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		
		return "success";
	}
	
	/**
	 * 홈페이지 신규 등록 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/homeMenu/insert.do")
	@CheckActivityHistory(desc = "홈페이지 신규 등록 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String MenuManagerHomeResist(Model model,
			RedirectAttributes redirectAttributes,
			HomeManager hm,
			Menu Menu,
			@RequestParam(value="homeimg", required = false ) MultipartFile thumbnail,
			@RequestParam(value="template", required = false ) String template,
			@RequestParam(value="UIA_KEYNO", required = false ) String[] UIA_KEYNO,
			@RequestParam(value="HAM_DEFAULT_URL", required = false ) String[] HAM_DEFAULT_URL,
			HttpServletRequest req) throws Exception{ 
		Menu.setMN_KEYNO(CommonService.getTableKey("MN"));
	
		
		/* 홈페이지가 갖는 메뉴특성 세팅 */
		Menu.setMN_HOMEDIV_C(Menu.getMN_KEYNO());
		Menu.setMN_MAINKEY("");
		Menu.setMN_PAGEDIV_C(SettingData.MENU_TYPE_SUBMENU); //소메뉴형태
		Menu.setMN_FORWARD_URL(Menu.getMN_URL()+"/index.do");
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_REGNM((String)user.get("UI_KEYNO"));
		
		
		Menu menuInfo = new Menu();
		menuInfo.setMN_HOMEDIV_C(Menu.getMN_HOMEDIV_C());
		redirectAttributes.addFlashAttribute("menu",menuInfo);
		
		Component.createData("Menu.AMN_regist",Menu);
		
		hm.setHM_KEYNO(CommonService.getTableKey("HM"));
		hm.setHM_MN_HOMEDIV_C(Menu.getMN_KEYNO());
		
		if(thumbnail != null && !thumbnail.isEmpty()) {
			String favicon = FileUploadTools.FaviconUpload(thumbnail, hm.getHM_TILES());
			hm.setHM_FAVICON(favicon);
		}
		
		//홈페이지 정보 관리 DB insert
		Component.createData("HomeManager.HM_insertData", hm);
		
		//레이아웃 기본 빵틀 만들기
		if(!template.isEmpty()){
			if(!AdminMenuService.copy_layoutFile(template, hm.getHM_TILES(), req, Menu)){
				throw new RuntimeException();
			}
		}else{
			if(!AdminMenuService.create_layoutFile(hm.getHM_TILES(), req, Menu)){
				throw new RuntimeException();
			}
		}
		
		//권한별 시작 페이지 설정
		if(UIA_KEYNO != null){
			List<HashMap<String,Object>> insertList = new ArrayList<HashMap<String,Object>>();
			HashMap<String,Object> map2 = null;
			for(int i=0;i<UIA_KEYNO.length;i++){
				map2 = new HashMap<String,Object>();
				map2.put("HAM_DEFAULT_URL", HAM_DEFAULT_URL[i]);
				map2.put("HAM_KEYNO", CommonService.getTableKey("HAM"));
				map2.put("UIA_KEYNO", UIA_KEYNO[i]);
				insertList.add(map2);
			}
			
			if(insertList.size() > 1){
				map2 = new HashMap<String,Object>();
				map2.put("list", insertList);
				map2.put("HM_KEYNO", hm.getHM_KEYNO());
				Component.updateData("HomeManager.HAM_insertData", map2);
			}
			
		}
		
		//저장할때 해당키 수정시간저장
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		
		return "redirect:/txap/homepage/menu.do";
	}
	
	@RequestMapping(value = "/txap/homepage/menu/homeMenu/checkTilesNameAjax.do")
	@ResponseBody
	public String MenuManagerHomeCheckTilesName(Model model,
			@RequestParam("HM_TILES") String HM_TILES) throws Exception{ 
		
		HM_TILES = HM_TILES.toLowerCase();
		
		String resultMsg = "OK";
		
		if(HM_TILES.indexOf("notiles") != -1){
			resultMsg = "F";
		}else {
			int count = Component.getCount("Menu.HM_getTilesCount", HM_TILES);
			if(count > 0){
				resultMsg = "F";
		  	}
		}
		
		return resultMsg;
	}
	
	/**
	 * 홈페이지 수정 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/homeMenu/update.do")
	@CheckActivityHistory(desc = "홈페이지 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String MenuManagerHomeUpdate(Model model,
			RedirectAttributes redirectAttributes,
			HomeManager hm,
			@RequestParam(value="homeimg2", required = false ) MultipartFile thumbnail,
			@RequestParam(value="HAM_KEYNO", required = false ) String[] HAM_KEYNO,
			@RequestParam(value="UIA_KEYNO", required = false ) String[] UIA_KEYNO,
			@RequestParam(value="HAM_DEFAULT_URL", required = false ) String[] HAM_DEFAULT_URL,
			Menu Menu,
			HttpServletRequest req) throws Exception{ 
		
		HomeManager homeManager = Component.getData("HomeManager.HM_getDataByKey",hm);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("MN_KEYNO", homeManager.getHM_MN_HOMEDIV_C());
		
		if(!hm.getMN_NAME().equals(homeManager.getMN_NAME())) { // 홈페이지 메뉴명 변경됬으면 변경 처리
			map.put("MN_NAME", hm.getMN_NAME());
			Component.updateData("HomeManager.MN_updateName", map);
		}
		
		if(!hm.getMN_ORDER().equals(homeManager.getMN_ORDER())){ // 정렬순서 변경됬으면 변경 처리
			map.put("MN_ORDER", hm.getMN_ORDER());
			Component.updateData("HomeManager.MN_updateOrder", map);
		}
		
		if(thumbnail != null && !thumbnail.isEmpty()) {
			
			String tiles = hm.getMN_URL().substring(1);
			
			String favicon = FileUploadTools.FaviconUpload(thumbnail, tiles);
			hm.setHM_FAVICON(favicon);
		}
		
		Component.updateData("HomeManager.HM_updateData", hm);
		
		//권한별 시작 페이지 설정
		if(HAM_KEYNO != null){
			List<HashMap<String,Object>> insertList = new ArrayList<HashMap<String,Object>>();
			List<HashMap<String,Object>> updateList = new ArrayList<HashMap<String,Object>>();
			HashMap<String,Object> map2 = null;
			for(int i=0;i<HAM_KEYNO.length;i++){
				map2 = new HashMap<String,Object>();
				map2.put("HAM_DEFAULT_URL", HAM_DEFAULT_URL[i]);
				if(StringUtils.isNotEmpty(HAM_KEYNO[i])){	//update
					map2.put("HAM_KEYNO", HAM_KEYNO[i]);
					updateList.add(map2);
				}else{	//insert
					map2.put("HAM_KEYNO", CommonService.getTableKey("HAM"));
					map2.put("UIA_KEYNO", UIA_KEYNO[i]);
					insertList.add(map2);
				}
			}
			if(updateList.size() > 1){
				map2 = new HashMap<String,Object>();
				map2.put("list", updateList);
				map2.put("HM_KEYNO", hm.getHM_KEYNO());
				Component.updateData("HomeManager.HAM_updateData", map2);
			}
			
			if(insertList.size() > 1){
				map2 = new HashMap<String,Object>();
				map2.put("list", insertList);
				map2.put("HM_KEYNO", hm.getHM_KEYNO());
				Component.updateData("HomeManager.HAM_insertData", map2);
			}
			
		}
		
		//저장할때 해당키 수정시간저장
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		
		return "redirect:/txap/homepage/menu.do?MN_HOMEDIV_C="+homeManager.getHM_MN_HOMEDIV_C();
	}
	
	/**
	 * 홈페이지 삭제 - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/homeMenu/delete.do")
	@CheckActivityHistory(desc = "홈페이지 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String MenuManagerHomeDelete(Model model
			, HttpServletRequest req
			, @RequestParam("key") String key) throws Exception{ 
		
		
		HomeManager hm = new HomeManager();
		hm.setHM_KEYNO(key);
		HomeManager homeManager = Component.getData("HomeManager.HM_getDataByKey",hm);
		
		Component.updateData("HomeManager.HM_deleteData", hm); //homeManager 데이터 삭제
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		hm.setMN_MODNM((String)user.get("UI_KEYNO"));
		
		Component.updateData("HomeManager.MN_deleteDataWithHomeDiv", homeManager); // 해당 모든 하위메뉴들 삭제
		
		//레이아웃 디렉토리 삭제
		String path = propertiesService.getString("jspPath") + "publish/" + homeManager.getHM_TILES() + "/"; 
		FileManageTools.delete_Folder(path);
		
		//레이아웃 리소스 삭제
		HashMap<String, Object> map = new HashMap<>();
		map.put("RM_MN_HOMEDIV_C", homeManager.getHM_MN_HOMEDIV_C());
		map.put("RM_TYPE", "layout");
		
		List<HashMap<String,Object>> list = Component.getList("Resources.RM_getList", map);
		for(HashMap<String,Object> dto : list){
			Component.updateData("Resources.RM_deleteByMNKey", dto);
			Component.updateData("Resources.RMH_deleteByMNKey", dto);
		}
		
		return "redirect:/txap/homepage/menu.do";
	}
	
	/**
	 * 메뉴관리 (수정) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/updateAjax.do")
	@CheckActivityHistory(desc = "메뉴관리 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerUpdate(
			HttpServletRequest request,
			Model model,
			Menu Menu,
			HttpServletRequest req,
			QrCode QrCode
			) throws Exception{ 
		
		if("Y".equals(Menu.getMN_QRCODE())){
			String url = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+Menu.getMN_URL();
			
			String filename = Menu.getMN_URL().replaceAll("/", "_");
			FileSub sub = QrCodeService.getMenuQrCode(url, 100, 100, filename);
			String QR_KEY = sub.getFS_KEYNO();
			Menu.setMN_QR_KEYNO(QR_KEY);
		}
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_MODNM((String)user.get("UI_KEYNO"));
		
		Component.updateData("Menu.AMN_update",Menu);
		Component.updateData("Menu.MN_OrderUpdate",Menu);
		
		//소메뉴일시 하위 메뉴들 url 변경
		if(Menu.getMN_PAGEDIV_C().equals("SC_QXCFB")){ //SC_QXCFB 소메뉴 코드
			Component.updateData("Menu.AMN_updateSubList",Menu);
		}
	
		//저장할때 해당키 수정시간저장
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
				
				
		return "success";
	}
	
	/**
	 * 메뉴관리 (사용여부) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/use/updateAjax.do")
	@CheckActivityHistory(desc = "메뉴관리 - 사용여부 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerUse(Model model,Menu Menu, HttpServletRequest req) throws Exception{ 
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_MODNM((String)user.get("UI_KEYNO"));
		Component.updateData("Menu.AMN_Use",Menu);
		//저장할때 해당키 수정시간저장
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		return "success";
	}
	
	/**
	 * 메뉴관리 (보이기/감추기) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/show/updateAjax.do")
	@CheckActivityHistory(desc = "메뉴관리 보이기/감추기 수정작업" , homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerShow(Model model,Menu Menu, HttpServletRequest req) throws Exception{ 
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_MODNM((String)user.get("UI_KEYNO"));
		Component.updateData("Menu.AMN_Show",Menu);
		//저장할때 해당키 수정시간저장
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		return "success";
	}
	
	
	/**
	 * 메뉴관리 (삭제) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/deleteAjax.do")
	@CheckActivityHistory(desc = "메뉴관리 - 삭제 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@ResponseBody
	public String MenuManagerDelete(Model model,Menu Menu, HttpServletRequest req) throws Exception{ 
		
		Menu = Component.getData("Menu.AMN_getDataByKey", Menu);
		Component.updateData("Menu.AMN_DeleteOrder", Menu);
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_MODNM((String)user.get("UI_KEYNO"));
		Component.deleteData("Menu.AMN_DeleteByLikeURL", Menu);
		
		//메뉴에 해당하는 권한 삭제
		Component.deleteData("Authority.MN_deleteData", Menu.getMN_KEYNO());
		
		//저장할때 해당키 수정시간저장
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		
		return "success";
	}
	
	
	/**
	 * 서브 권한 리스트
	 * @param model
	 * @param Menu
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/homepage/menu/authority/subAuthorityAjax.do")
	@ResponseBody
	public List MenuManagerSubAuthorityListAjax(UserDTO user) throws Exception{ 
		
		if(user.getUIR_TYPE() == null){
			user.setUIR_TYPE("SC_MYKFE"); // 게시판 타입
		}
//		System.out.println(user.getUIR_TYPE());
		return Component.getList("Authority.UIR_GetList",user);
	}
	
	/**
	 * 보드 타입 정보
	 * @param user
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/homepage/menu/authority/getBTInfoAjax.do")
	@ResponseBody
	public Object MenuManagerBTInfoAjax(@RequestParam("MN_KEYNO") String key) throws Exception{ 
		
		return Component.getData("BoardType.BT_getData2",key);
	}
	
	/**
	 * 권한 리스트
	 * @param model
	 * @param Menu
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/homepage/menu/authority/listAjax.do")
	@ResponseBody
	public List MenuManagerAuthorityListAjax() throws Exception{ 
		
		return Component.getListNoParam("Authority.UIA_GetList");
	}
	
	/**
	 * 현재 url에 설정된 권한 리스트
	 * @param model
	 * @param Menu
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/homepage/menu/authority/nameListAjax.do")
	@ResponseBody
	public List MenuManagerAuthorityListAjax(@RequestParam(value="MN_KEYNO") String MN_KEYNO) throws Exception{ 
		
		return Component.getList("Authority.UIA_GetListwidthUrl",MN_KEYNO);
	}
	
	/**
	 * 권한 설정
	 * @param model
	 * @param Menu
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/homepage/menu/authority/insertAjax.do")
	@CheckActivityHistory(desc = "메뉴관리 - 권한 수정 작업", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerAuthorityInsertAjax(
			  @RequestParam("key") String key[]
			, @RequestParam("type") String type[]
			, @RequestParam("data") String data[]
			, Menu Menu
			, Resource Resource) throws Exception{ 
		
		String url = Menu.getMN_URL();
		int order = (10 - url.split("/").length) * 10 ;
		if(url.indexOf(".do") == -1){
			order++;
		}
		String usrKey;
		Resource.setUSR_PATTERN(url);
		Resource.setMN_KEYNO(Menu.getMN_KEYNO());
		for(int i=0;i<key.length;i++){
			Resource.setUSR_UIR_KEYNO(key[i]);
			usrKey = Component.getData("Authority.USR_getKey",Resource);
//			System.out.println(type[i]);
			if(type[i].equals("A")){
				if(usrKey != null){
					Component.deleteData("Authority.URA_deleteWidthUSR",usrKey);
				}
			}else if(type[i].equals("B") || type[i].equals("C") || type[i].equals("D") ){
				Map<String,Object> map = new HashMap<String,Object>();
				String[] keyArray = null;
				
				//UiA_TYPE 삭제 관련 에러 예정
				
				/*if(type[i].equals("B")){ // 관리자만
					map.put("UIA_TYPE", new String[]{"A"});
					List<String> keyList = Component.getList("Authority.UIA_GetListwidthType", map);
					keyArray =keyList.toArray(new String[keyList.size()]); 
				}else if(type[i].equals("D")){ // 회원만
					map.put("UIA_TYPE", new String[]{"A","U"});
					List<String> keyList = Component.getList("Authority.UIA_GetListwidthType", map);
					keyArray =keyList.toArray(new String[keyList.size()]); 
				}else{
					keyArray =  data[i].split("\\|");
				}*/
				Resource.setUrlResources(keyArray);
				if(usrKey != null){
					Component.deleteData("Authority.URA_deleteWidthUSR",usrKey);
					Resource.setUSR_KEYNO(usrKey);
				}else{
					usrKey = CommonService.getTableKey("USR");
					Resource.setUSR_KEYNO(usrKey);
					Resource.setUSR_TYPE("url");
					Resource.setUSR_ORDER_CLASS("middle");
					Resource.setUSR_ORDER(order);
					
					Component.createData("Authority.USR_insert", Resource);
				}
				Component.createData("Authority.URA_insert", Resource);
				
			}else{
				System.out.println("오류 :: /txap/homepage/menu/authority/insertAjax.do");
				return type[i];
			}
			Resource.setUSR_TYPE(type[i]);
			Component.createData("Authority.AMN_Authority", Resource);
		}
		
		reloadableFilterInvocationSecurityMetadataSource.reload();
		
		
		
		return "success";
		
	}
	
	@RequestMapping(value = "/txap/user/firstChildUrlAjax.do")
	@ResponseBody
	public String MenuFirstChildUrlAjax(HttpServletRequest req,
			Menu menu) throws Exception{ 
		
		String introUrl = Component.getData("Menu.AMN_getIntroUrl",menu);
		
		if(StringUtils.isNotEmpty(introUrl)){
			return introUrl;
		}
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		
		return getFirstChildUrl(menu,authentication);
	}
	
	
	
	private String getFirstChildUrl(Menu menu, Authentication authentication) {
		// TODO Auto-generated method stub
		
		List<Menu> menuList = Component.getList("Menu.AMN_getMenuChildList",menu);
		
		for(Menu m : menuList ){
			if(m.getMN_PAGEDIV_C().equals(SettingData.MENU_TYPE_SUBMENU)){
				String introUrl = Component.getData("Menu.AMN_getIntroUrl",m.getMN_URL());
				if(StringUtils.isNotEmpty(introUrl)){
					return introUrl;
				}
				String url = getFirstChildUrl(m, authentication);
				if(StringUtils.isNotEmpty(url)){
					return url;
				}
			}else{
				if(webInvocationPrivilegeEvaluator.isAllowed(m.getMN_URL(), authentication)){
					return m.getMN_URL();
				}
			}
		}
		
		return "";
		
	}
	
	/**
	 * 
	 * @param req
	 * @param menu 클릭시 첫 메뉴의 페이지 url 들어가기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/common/user/firstChildUrlAjax.do")
	@ResponseBody
	public String MenuFirstChildUrlAjaxdo(HttpServletRequest req,
			Menu menu) throws Exception{ 
		
		HashMap<String,Object> Type_Url= Component.getData("Menu.AMN_getMenuUrl",menu);
		//소메뉴 형일 경우에
		if(Type_Url.get("MN_PAGEDIV_C").equals("SC_QXCFB")) {
			
			menu.setMN_URL((String)Type_Url.get("MN_URL"));
			Type_Url = Component.getData("Menu.AMN_getMenuUrl",menu);
		}
		String url = (String)Type_Url.get("MN_URL");
		return url;
	}
	
}
