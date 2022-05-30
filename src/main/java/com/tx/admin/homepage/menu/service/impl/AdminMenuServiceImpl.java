package com.tx.admin.homepage.menu.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.dto.Menu;
import com.tx.admin.homepage.menu.service.AdminMenuService;
import com.tx.admin.homepage.resource.dto.ResourcesDTO;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileManageTools;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * AdminMenuService
 * 
 * @author 신강철
 * @version 1.0
 * @since 2019-05-15
 */
@Service("AdminMenuService")
public class AdminMenuServiceImpl extends EgovAbstractServiceImpl implements AdminMenuService {

	/** 공통 컴포넌트 */
	@Autowired
	ComponentService Component;
	@Autowired
	CommonService CommonService;
	@Autowired
	FileManageTools FileManageTools;

	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	EgovPropertyService propertiesService;

	@Override
	public List<Menu> getMenuList(HomeManager homeManager, List<String> pageDivList, boolean isIncludeHomeDiv)
			throws Exception {

		homeManager.setPageDivList(pageDivList);

		List<Menu> menuList = Component.getList("Menu.AMN_getMenuAllList", homeManager);

		List<Menu> resultList = new ArrayList<Menu>();

		int depth = Integer.parseInt(homeManager.getHM_MENU_DEPTH());

		if (isIncludeHomeDiv) {
			getChild("", resultList, menuList, depth);
		} else {
			getChild(homeManager.getHM_MN_HOMEDIV_C(), resultList, menuList, depth);
		}

		return resultList;
	}

	@Override
	public List<Menu> getMenuList(HomeManager homeManager, List<String> pageDivList) throws Exception {
		// TODO Auto-generated method stub
		return getMenuList(homeManager, pageDivList, false);

	}

	@Override
	public List<Menu> getMenuList(HomeManager homeManager) throws Exception {
		return getMenuList(homeManager, null);
	}

	private void getChild(String mainKey, List<Menu> resultList, List<Menu> menuList, int depth) {
		// TODO Auto-generated method stub

		for (Menu menu : menuList) {
			if(mainKey.equals(StringUtils.defaultIfBlank(menu.getMN_MAINKEY(), ""))){
				resultList.add(menu);
				if (menu.getMN_PAGEDIV_C().equals(SettingData.MENU_TYPE_SUBMENU) && menu.getMN_LEV() < depth) {
					getChild(menu.getMN_KEYNO(), resultList, menuList, depth);
				}
			}
		}

	}

	/**
	 * 레이아웃 기본 파일 생성
	 * 
	 * @param file_list
	 * @throws Exception
	 */
	@Override
	public boolean create_layoutFile(String tiles, HttpServletRequest req, Menu Menu) throws Exception {

		boolean state = true;
		String[] file_arr = { "prc_main", "css", "script", "header", "footer", "subTop" };
		String filePath = "";

		for (String name : file_arr) {
			if (name.equals("prc_main")) {
				filePath = propertiesService.getString("jspPath") + tiles + "/main/";
			} else {
				filePath = propertiesService.getString("jspPath") + "publish/" + tiles + "/include/";
			}

			String fileName = name + ".jsp";
			File file = new File(filePath + fileName);

			if (!file.isFile()) {
				state = FileManageTools.create_File(filePath, fileName, SettingData.JSPDATA);
			}
			
			//리소스 DB 저장
			createResource(name, req, Menu, SettingData.JSPDATA);

			if (!state) {
				break;
			}
		}

		return state;
	}
	
	void createResource(String name, HttpServletRequest req, Menu Menu, String data){
		@SuppressWarnings({ "unchecked", "rawtypes" })
		Map user = (HashMap<String, Object>) req.getSession().getAttribute("userInfo");
		String regName = ((String) user.get("UI_KEYNO"));
		
		ResourcesDTO ResourcesDTO = new ResourcesDTO();
		ResourcesDTO.setRM_KEYNO(CommonService.getTableKey("RM"));
		ResourcesDTO.setRM_MN_HOMEDIV_C(Menu.getMN_KEYNO());
		ResourcesDTO.setRM_REGNM(regName);
		ResourcesDTO.setRM_DATA(data);
		ResourcesDTO.setRM_SCOPE(name);
		ResourcesDTO.setRM_FILE_NAME(name);
		ResourcesDTO.setRM_TYPE("layout");
		
		Component.createData("Resources.RM_insert", ResourcesDTO);
		
		/* 히스토리 저장 시작*/
		String REGDT = Component.getData("Resources.get_historyDate",ResourcesDTO);
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
		
	}

	/**
	 * 레이아웃 템플릿 파일 복사
	 * 
	 * @param oriTiles
	 * @param newTiles
	 * @throws Exception
	 */
	@Override
	public boolean copy_layoutFile(String oriTiles, String newTiles, HttpServletRequest req, Menu Menu) throws Exception {

		boolean state = true;
		String[] file_arr = { "prc_main", "css", "script", "header", "footer" ,"subTop"};
		String orifilePath, newfilePath = "";
		String data = "";

		for (String name : file_arr) {
			if (name.equals("prc_main")) {
				orifilePath = propertiesService.getString("jspPath") + "publish/" + oriTiles + "/";
				newfilePath = propertiesService.getString("jspPath") + "publish/" + newTiles + "/";
			} else {
				orifilePath = propertiesService.getString("jspPath") + "publish/" + oriTiles + "/include/";
				newfilePath = propertiesService.getString("jspPath") + "publish/" + newTiles + "/include/";
			}

			String fileName = name + ".jsp";
			File file = new File(orifilePath + fileName);

			if (!file.isFile()) {
				state = FileManageTools.create_File(newfilePath, fileName, SettingData.JSPDATA);
				data = SettingData.JSPDATA;
			} else {
				state = FileManageTools.file_copy(orifilePath, newfilePath, fileName);
				data = FileManageTools.read_file(newfilePath, fileName);
			}
			
			//리소스 DB 저장
			createResource(name, req, Menu, data);

			if (!state) {
				break;
			}
		}

		return state;
	}

}
