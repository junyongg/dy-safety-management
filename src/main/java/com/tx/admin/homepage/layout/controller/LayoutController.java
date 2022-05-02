package com.tx.admin.homepage.layout.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.resource.dto.ResourcesDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileManageTools;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class LayoutController {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	@Autowired FileManageTools FileManageTools;
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * 레이아웃 관리
	 * @param req
	 * @param Menu
	 * @return
	 * @throws Exception
	 */   
	@RequestMapping(value = "/txap/homepage/layout.do")
	@CheckActivityHistory(desc = "레이아웃 관리 방문")
	public ModelAndView layoutView(
			HttpServletRequest req
			, Menu Menu
			,@RequestParam(value="SCOPE",required=false) String SCOPE
			) throws Exception{
		ModelAndView mv = new ModelAndView("/txap/homepage/layout/layout_view.adm");
		
		//홈페이지 구분 리스트 (관리자페이지 제외)
		mv.addObject("homeDivList", CommonService.getHomeDivCode(false));
		
		if(Menu.getMN_HOMEDIV_C() != null && !Menu.getMN_HOMEDIV_C().equals("")){
			Menu.setMN_KEYNO(Menu.getMN_HOMEDIV_C());
		}else{
			Menu.setMN_KEYNO(SettingData.HOMEDIV_JACT);
		}
		
		Menu = Component.getData("Menu.AMN_getDataByKey", Menu);
		mv.addObject("menu", Menu);
		
		HomeManager hm = new HomeManager();
		hm.setHM_MN_HOMEDIV_C(Menu.getMN_HOMEDIV_C());
		hm = Component.getData("HomeManager.HM_getDataByHOMEDIV_C", hm);
		mv.addObject("homeData", hm);
		
		mv.addObject("SCOPE", SCOPE);
		mv.addObject("type", "layout");
		
		return mv;
	}
	
	/**
	 * 레이아웃 관리 - 데이터 Ajax
	 * @param req
	 * @param Menu
	 * @return
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value = "/txap/homepage/layout/dataAjax.do")
	@ResponseBody
	public HashMap<String,Object> layoutDataAjax(
			ResourcesDTO ResourcesDTO
			) throws Exception{
		HashMap<String, Object> map = new HashMap<>();
		
		HashMap<String, Object> map2 = new HashMap<>();
		map2.put("RM_MN_HOMEDIV_C", ResourcesDTO.getRM_MN_HOMEDIV_C());
		map2.put("RM_TYPE", ResourcesDTO.getRM_TYPE());
		map2.put("RM_SCOPE", ResourcesDTO.getRM_SCOPE());
		map2.put("allck", "false");
		
		//데이터 정보 불러오기
		ResourcesDTO = Component.getData("Resources.RM_getData2", map2);
		
		map.put("LayoutData", ResourcesDTO);
		map.put("LayoutDataHistory", Component.getList("Resources.RMH_getList", ResourcesDTO));
		
		return map;
	}
	
	/**
	 * 레이아웃 관리 - 레이아웃 저장처리
	 * @param ResourcesDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/txap/homepage/layout/insert.do")
	@ResponseBody
	@CheckActivityHistory(desc = "레이아웃 저장 처리")
	@Transactional
	public String layoutInsert(
			ResourcesDTO ResourcesDTO
			, @RequestParam(value="MN_HOMEDIV_C", required=false) String MN_HOMEDIV_C
			, @RequestParam(value="actionType", required=false) String actiontype
			, HttpServletRequest req)
			throws Exception {
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		String regName = ((String) user.get("UI_KEYNO"));
		String REGDT = Component.getData("Resources.get_historyDate",ResourcesDTO);
		
		if(actiontype.equals("insert")){
			ResourcesDTO.setRM_KEYNO(CommonService.getTableKey("RM"));
			ResourcesDTO.setRM_MN_HOMEDIV_C(MN_HOMEDIV_C);
			ResourcesDTO.setRM_REGNM(regName);
			Component.createData("Resources.RM_insert", ResourcesDTO);
			REGDT = Component.getData("Resources.get_historyDate",ResourcesDTO);
		}else if(actiontype.equals("update")){
			ResourcesDTO.setRM_MODNM(regName);
			Component.createData("Resources.RM_update", ResourcesDTO);
		}
		
		/* 히스토리 저장 시작*/
		double VersionNum = Component.getData("Resources.get_historyVersion",ResourcesDTO);
		VersionNum += 0.01;
		ResourcesDTO.setRMH_KEYNO(CommonService.getTableKey("RMH"));
		ResourcesDTO.setRMH_RM_KEYNO(ResourcesDTO.getRM_KEYNO());
		ResourcesDTO.setRMH_STDT(REGDT);
		ResourcesDTO.setRMH_MODNM(regName);
		ResourcesDTO.setRMH_DATA(ResourcesDTO.getRM_DATA());
		ResourcesDTO.setRMH_VERSION(VersionNum);
		
		String message = ResourcesDTO.getRMH_COMMENT();
		if(ResourcesDTO.getRMH_COMMENT() == null || ResourcesDTO.getRMH_COMMENT().equals("")){
			message = "no message";
		}
		ResourcesDTO.setRMH_COMMENT(message);
		Component.createData("Resources.RMH_insert", ResourcesDTO);
		/* 히스토리 저장 끝*/
		
		return ResourcesDTO.getRM_SCOPE();
		

	}
	
	/**
	 * 레이아웃 관리 - 레이아웃 복원처리
	 * 
	 * @param ResourcesDTO
	 * @return
	 * @throws Exception
	 */   
	@RequestMapping(value = "/txap/homepage/layout/returnPageAjax.do")
	@ResponseBody
	public String layoutReturnPageAjax(HttpServletRequest req, ResourcesDTO ResourcesDTO
			) throws Exception{
		
		ResourcesDTO = Component.getData("Resources.RMH_getData",ResourcesDTO);
		String DATA = ResourcesDTO.getRMH_DATA();
		
		return DATA;
	}
	
	/**
	 * 레이아웃 관리 - 최신데이터와 비교, 변경사항
	 * 
	 * @param ResourcesDTO
	 * @return
	 * @throws Exception
	 */  
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/txap/homepage/layout/compareAjax.do")
	@ResponseBody
	public List layoutCompareAjax(HttpServletRequest req, ResourcesDTO ResourcesDTO
			) throws Exception{
		
		return Component.getList("Resources.RMH_compareData", ResourcesDTO);
	}
	
	/**
	 * 레이아웃 관리 - 배포
	 * 
	 * @param ResourcesDTO
	 * @return
	 * @throws Exception
	 */  
	@RequestMapping(value = "/txap/homepage/layout/distributeAjax.do")
	@ResponseBody
	@CheckActivityHistory(desc = "레이아웃 배포 처리")
	public Boolean layoutDistributeAjax(
			Model model
			,ResourcesDTO ResourcesDTO
			,@RequestParam(value="allck", required=false) Boolean allck
			) throws Exception{
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("RM_MN_HOMEDIV_C", ResourcesDTO.getRM_MN_HOMEDIV_C());
		map.put("RM_TYPE", ResourcesDTO.getRM_TYPE());
		map.put("RM_SCOPE", ResourcesDTO.getRM_SCOPE());
		map.put("allck", allck.toString());
		
		boolean state = true;
		
		//데이터 정보 불러오기
		List<ResourcesDTO> list = Component.getList("Resources.RM_getData2", map);
		
		if(list.size() > 0){
			for (ResourcesDTO dto: list) {
				String fileName = dto.getRM_FILE_NAME() + ".jsp";
				String filePath = "";
				String tiles = Component.getData("HomeManager.get_tiles", dto.getRM_MN_HOMEDIV_C());
				
				if(dto.getRM_SCOPE().equals("prc_main")){
					filePath = propertiesService.getString("jspPath") + "publish/" + tiles + "/"; 
				}else{
					filePath = propertiesService.getString("jspPath") + "publish/" + tiles + "/include/"; 
				}
				
				String data = dto.getRM_DATA();
				
				state = FileManageTools.create_File(filePath, fileName, data);
				
				if(!state){
					break;
				}
			}
		}
		
		return state;
	}
	
	
}