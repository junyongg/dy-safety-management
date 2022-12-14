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
 * ????????? - ????????????
 * @author 
 * @version 1.0
 * @since 
 */
@Controller
public class AdminMenuManager {
	
	/** ?????? ???????????? */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** ????????? ???????????? */
	@Autowired ReloadableFilterInvocationSecurityMetadataSource reloadableFilterInvocationSecurityMetadataSource;
	
	/** ??????????????? ???*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/** QrCode */
	@Autowired private QrCodeService QrCodeService;
	
	/** Xml */
	@Autowired private XMLService XMLService;
	
	/** ???????????? ????????? */
	@Autowired private AdminMenuService AdminMenuService;
	
	/** ???????????? ?????????2 */
	@Autowired private AdminMenuSessionService AdminMenuSessionService;
	
	/** ???????????? ??? */
	@Autowired FileManageTools FileManageTools;

	/** ???????????? ?????? ?????? */
	@javax.annotation.Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private DefaultWebInvocationPrivilegeEvaluator webInvocationPrivilegeEvaluator;
	
	
	
	/**
	 * ???????????? (List) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   
	@RequestMapping(value = "/txap/homepage/menu.do")
	@CheckActivityHistory(desc = "???????????? ??????")
	public String MenuManagerView(Model model,Menu Menu) throws Exception{ 
		
		//???????????? ?????? ?????????
		List<HomeManager> homeDivList = CommonService.getHomeDivCode(true);
		model.addAttribute("homeDivList", homeDivList);
		
		
		String mnHomedivC =Menu.getMN_HOMEDIV_C();
		
		//???????????? HomeKey?????? ??????
		boolean isExistsHomeKey = false;
		for( Menu m : homeDivList ){
			if( m.getMN_HOMEDIV_C().equals(mnHomedivC) ){
				isExistsHomeKey = true;
				break;
			}
		}
		
		//???????????? ????????? ?????? ??? ????????? ?????? (???)
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
		
		//?????? ?????? ?????????
		model.addAttribute("menuList",Component.getList("Code.ASC_GetList", "AF"));
		
		//???????????? tiles ?????????
		model.addAttribute("homepageTilesCode",Component.getList("Code.ASC_GetList", "AE"));
		
		//????????? ?????? ?????????
		model.addAttribute("boardTypeList",Component.getListNoParam("BoardType.BT_getList2"));
		
		//?????? ?????????
		model.addAttribute("authorityList", Component.getList("HomeManager.UIA_GetListWithHome",hm));
		
		model.addAttribute("resultList",AdminMenuService.getMenuList(hm, null));
		
		return "/txap/homepage/menu/pra_menu_list.adm";
	}
	
	

	/**
	 * ???????????? (subList) - admin
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
	 * ?????? ????????? ?????? - excel ajax
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
			System.out.println("?????? ?????? :: "+e.getMessage());
		}
		
		String WebName = Component.getData("Menu.excel_getWebName", Menu);
		mv.addObject("WEBNAME", WebName);
		
		return mv;
	}
	
	/**
	 * ?????? ????????? ??????Back- excel ajax
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
			System.out.println("?????? ?????? :: "+e.getMessage());
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
	 * ?????? Xml ????????? 
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
	 * ?????? ????????? xml - xml ajax
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
			    //xml ????????? ????????? ?????? ????????? ?????? ?????? ????????? ??????
			    XMLOutputter serializer = new XMLOutputter();                 
			                                                                    
			    Format f = serializer.getFormat();                            
			    f.setEncoding("UTF-8");
			    //encoding ????????? UTF-8 ??? ??????
			    f.setIndent(" ");                                             
			    f.setLineSeparator("\r\n");                                   
			    f.setTextMode(Format.TextMode.TRIM);                          
			    serializer.setFormat(f);                                      
			                                                                    
			    serializer.output(doc, out);
			    
			    out.flush();
			    out.close(); 
			  
			    Map<String,Object> user = (HashMap<String, Object>) request.getSession().getAttribute("userInfo");
			    FileSub = FileUploadTools.FileUploadByXML(WebName, filepath,(String)user.get("UI_KEYNO"));
		        
		      //String ?????? xml ??????
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
	 * xml ?????? ??????
	 @param resultList
	 @return
	 */
	private Document getXmlfile(List<HashMap<String, Object>> MenuInfoList) {
		Document document = null;
		Element rootElement = null;
		Element rootElement2 = null;
		Element rootElement3 = null;
		
		// document ?????????.
	    document = new Document();
	    rootElement = new Element("menuInfo");
	    // root Element??? ????????? value?????? ?????????.
	    rootElement.setAttribute("type", "menu");
	    // document??? Element?????? ????????? ??????.
	    document.addContent(rootElement);
	   
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("table", "T_MENU_MANAGER");
		//?????????
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
						// ??????????????? element??? ???????????? ????????? value?????? ???????????? ???.
						Element = new Element(name);
						Element.setText(value);
						// rootElement??? ????????? element??? ????????? ??????
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
								// ??????????????? element??? ???????????? ????????? value?????? ???????????? ???.
								Element = new Element(name);
								Element.setText(value);
								// rootElement??? ????????? element??? ????????? ??????
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
	 * ?????? ????????? xml - xml ??????
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
	 * ?????? ????????? xml - xml ??????
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
	 * ???????????? (??????) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/insertAjax.do")
	@CheckActivityHistory(desc = "?????? ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerResist(Model model,@ModelAttribute Menu Menu, HttpServletRequest req) throws Exception{ 
		Menu.setMN_KEYNO(CommonService.getTableKey("MN"));
		int a;
		// ????????? ??????????????? ??????????????? ????????? ?????? ????????? ?????? ????????? ?????? sql???
		a = Component.getData("Menu.AMN_getMNLV", Menu);
		
		//sql??? ?????? ???????????? ???????????? ??????, ?????? ???????????? ?????? ???????????? ??? ????????? ?????? ???????????? ?????? +1????????? ????????? ??????
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
		
		//???????????? ????????? ??????????????????
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		
		return "success";
	}
	
	/**
	 * ???????????? ?????? ?????? - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/homeMenu/insert.do")
	@CheckActivityHistory(desc = "???????????? ?????? ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
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
	
		
		/* ??????????????? ?????? ???????????? ?????? */
		Menu.setMN_HOMEDIV_C(Menu.getMN_KEYNO());
		Menu.setMN_MAINKEY("");
		Menu.setMN_PAGEDIV_C(SettingData.MENU_TYPE_SUBMENU); //???????????????
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
		
		//???????????? ?????? ?????? DB insert
		Component.createData("HomeManager.HM_insertData", hm);
		
		//???????????? ?????? ?????? ?????????
		if(!template.isEmpty()){
			if(!AdminMenuService.copy_layoutFile(template, hm.getHM_TILES(), req, Menu)){
				throw new RuntimeException();
			}
		}else{
			if(!AdminMenuService.create_layoutFile(hm.getHM_TILES(), req, Menu)){
				throw new RuntimeException();
			}
		}
		
		//????????? ?????? ????????? ??????
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
		
		//???????????? ????????? ??????????????????
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
	 * ???????????? ?????? - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/homeMenu/update.do")
	@CheckActivityHistory(desc = "???????????? ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
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
		
		if(!hm.getMN_NAME().equals(homeManager.getMN_NAME())) { // ???????????? ????????? ??????????????? ?????? ??????
			map.put("MN_NAME", hm.getMN_NAME());
			Component.updateData("HomeManager.MN_updateName", map);
		}
		
		if(!hm.getMN_ORDER().equals(homeManager.getMN_ORDER())){ // ???????????? ??????????????? ?????? ??????
			map.put("MN_ORDER", hm.getMN_ORDER());
			Component.updateData("HomeManager.MN_updateOrder", map);
		}
		
		if(thumbnail != null && !thumbnail.isEmpty()) {
			
			String tiles = hm.getMN_URL().substring(1);
			
			String favicon = FileUploadTools.FaviconUpload(thumbnail, tiles);
			hm.setHM_FAVICON(favicon);
		}
		
		Component.updateData("HomeManager.HM_updateData", hm);
		
		//????????? ?????? ????????? ??????
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
		
		//???????????? ????????? ??????????????????
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		
		return "redirect:/txap/homepage/menu.do?MN_HOMEDIV_C="+homeManager.getHM_MN_HOMEDIV_C();
	}
	
	/**
	 * ???????????? ?????? - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/homeMenu/delete.do")
	@CheckActivityHistory(desc = "???????????? ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	public String MenuManagerHomeDelete(Model model
			, HttpServletRequest req
			, @RequestParam("key") String key) throws Exception{ 
		
		
		HomeManager hm = new HomeManager();
		hm.setHM_KEYNO(key);
		HomeManager homeManager = Component.getData("HomeManager.HM_getDataByKey",hm);
		
		Component.updateData("HomeManager.HM_deleteData", hm); //homeManager ????????? ??????
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		hm.setMN_MODNM((String)user.get("UI_KEYNO"));
		
		Component.updateData("HomeManager.MN_deleteDataWithHomeDiv", homeManager); // ?????? ?????? ??????????????? ??????
		
		//???????????? ???????????? ??????
		String path = propertiesService.getString("jspPath") + "publish/" + homeManager.getHM_TILES() + "/"; 
		FileManageTools.delete_Folder(path);
		
		//???????????? ????????? ??????
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
	 * ???????????? (??????) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/updateAjax.do")
	@CheckActivityHistory(desc = "???????????? ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
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
		
		//??????????????? ?????? ????????? url ??????
		if(Menu.getMN_PAGEDIV_C().equals("SC_QXCFB")){ //SC_QXCFB ????????? ??????
			Component.updateData("Menu.AMN_updateSubList",Menu);
		}
	
		//???????????? ????????? ??????????????????
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
				
				
		return "success";
	}
	
	/**
	 * ???????????? (????????????) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/use/updateAjax.do")
	@CheckActivityHistory(desc = "???????????? - ???????????? ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerUse(Model model,Menu Menu, HttpServletRequest req) throws Exception{ 
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_MODNM((String)user.get("UI_KEYNO"));
		Component.updateData("Menu.AMN_Use",Menu);
		//???????????? ????????? ??????????????????
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		return "success";
	}
	
	/**
	 * ???????????? (?????????/?????????) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/show/updateAjax.do")
	@CheckActivityHistory(desc = "???????????? ?????????/????????? ????????????" , homeDiv= SettingData.HOMEDIV_ADMIN)
	@Transactional
	@ResponseBody
	public String MenuManagerShow(Model model,Menu Menu, HttpServletRequest req) throws Exception{ 
		
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_MODNM((String)user.get("UI_KEYNO"));
		Component.updateData("Menu.AMN_Show",Menu);
		//???????????? ????????? ??????????????????
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		return "success";
	}
	
	
	/**
	 * ???????????? (??????) - admin
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 * 
	 */   					 
	@RequestMapping(value = "/txap/homepage/menu/deleteAjax.do")
	@CheckActivityHistory(desc = "???????????? - ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
	@ResponseBody
	public String MenuManagerDelete(Model model,Menu Menu, HttpServletRequest req) throws Exception{ 
		
		Menu = Component.getData("Menu.AMN_getDataByKey", Menu);
		Component.updateData("Menu.AMN_DeleteOrder", Menu);
		@SuppressWarnings("unchecked")
		Map<String,Object> user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		Menu.setMN_MODNM((String)user.get("UI_KEYNO"));
		Component.deleteData("Menu.AMN_DeleteByLikeURL", Menu);
		
		//????????? ???????????? ?????? ??????
		Component.deleteData("Authority.MN_deleteData", Menu.getMN_KEYNO());
		
		//???????????? ????????? ??????????????????
		AdminMenuSessionService.updateTime(Menu.getMN_HOMEDIV_C());
		
		return "success";
	}
	
	
	/**
	 * ?????? ?????? ?????????
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
			user.setUIR_TYPE("SC_MYKFE"); // ????????? ??????
		}
//		System.out.println(user.getUIR_TYPE());
		return Component.getList("Authority.UIR_GetList",user);
	}
	
	/**
	 * ?????? ?????? ??????
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
	 * ?????? ?????????
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
	 * ?????? url??? ????????? ?????? ?????????
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
	 * ?????? ??????
	 * @param model
	 * @param Menu
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/homepage/menu/authority/insertAjax.do")
	@CheckActivityHistory(desc = "???????????? - ?????? ?????? ??????", homeDiv= SettingData.HOMEDIV_ADMIN)
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
				
				//UiA_TYPE ?????? ?????? ?????? ??????
				
				/*if(type[i].equals("B")){ // ????????????
					map.put("UIA_TYPE", new String[]{"A"});
					List<String> keyList = Component.getList("Authority.UIA_GetListwidthType", map);
					keyArray =keyList.toArray(new String[keyList.size()]); 
				}else if(type[i].equals("D")){ // ?????????
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
				System.out.println("?????? :: /txap/homepage/menu/authority/insertAjax.do");
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
	 * @param menu ????????? ??? ????????? ????????? url ????????????
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/common/user/firstChildUrlAjax.do")
	@ResponseBody
	public String MenuFirstChildUrlAjaxdo(HttpServletRequest req,
			Menu menu) throws Exception{ 
		
		HashMap<String,Object> Type_Url= Component.getData("Menu.AMN_getMenuUrl",menu);
		//????????? ?????? ?????????
		if(Type_Url.get("MN_PAGEDIV_C").equals("SC_QXCFB")) {
			
			menu.setMN_URL((String)Type_Url.get("MN_URL"));
			Type_Url = Component.getData("Menu.AMN_getMenuUrl",menu);
		}
		String url = (String)Type_Url.get("MN_URL");
		return url;
	}
	
}
