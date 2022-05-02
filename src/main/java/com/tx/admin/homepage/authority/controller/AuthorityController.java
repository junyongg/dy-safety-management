package com.tx.admin.homepage.authority.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.homepage.authority.service.AdminAuthorityService;
import com.tx.admin.homepage.menu.dto.HomeManager;
import com.tx.admin.homepage.menu.service.AdminMenuService;
import com.tx.admin.member.dto.UserDTO;
import com.tx.common.annotation.CheckActivityHistory;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.page.PageAccess;
import com.tx.common.security.handler.ReloadableFilterInvocationSecurityMetadataSource;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * @FileName: AuthorityController.java
 * @Project : CT CMS
 * @Date    : 2017. 02. 28. 
 * @Author  : 트로닉스 이재령	
 * @Version : 1.0
 * @meno	:
 * 	슈퍼관리자는  항상 어디든 접근가능하다.
 * 	메뉴별 권한 처리할때 슈퍼관리자는 항상 추가해준다. (SettingData.AUTHORITY_ADMIN)
 */
@Controller
public class AuthorityController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 페이지 처리 출 */
	@Autowired private PageAccess PageAccess;
	
	/** 메뉴리스트 서비스 */
	@Autowired private AdminMenuService AdminMenuService;
	
	/** 권한관리 서비스 */
	@Autowired private AdminAuthorityService AdminAuthorityService;
	
	/** 리로드 권한설정 */
	@Autowired ReloadableFilterInvocationSecurityMetadataSource reloadableFilterInvocationSecurityMetadataSource;
	
	/**
	 * 권한 관리
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/homepage/authority.do")
	@CheckActivityHistory(desc="권한 관리 페이지 방문")
	public ModelAndView adminAuthorityView(HttpServletRequest req
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/homepage/authority/pra_authority_view.adm");
		
		//mv.addObject("subAuthorityTypeList", Component.getList("Code.SC_GetList", "AI"));
		
		
		
		return mv;
	}
	
	
	
	/**
	 * 권한 관리 - 권한 / 회원 목록 가져오기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/txap/homepage/authority/listAjax.do")
	public ModelAndView adminAuthorityListAjax(HttpServletRequest req
			, @RequestParam String type
			, @RequestParam(value="pageIndex",required=false) Integer pageIndex
			, @RequestParam(value="searchKeyword",required=false) String searchKeyword
			) throws Exception {
		ModelAndView mv  = new ModelAndView("/txap/homepage/authority/list/pra_authority_list_"+type);
		
		if("A".equals(type)){
			mv.addObject("systemAuthorityList",Component.getListNoParam("UIA_GetSystemList"));
		}else if("B".equals(type)){
			List<HashMap<String,Object>> searchList = new ArrayList<HashMap<String,Object>>();
			HashMap<String,Object> searchMap = new HashMap<String,Object>();
			searchMap.put("searchIndex", "authority");
			searchMap.put("searchKeyword", searchKeyword);
			searchList.add(searchMap);
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("searchList", searchList);
			map.put("authority", "authority");
			
			PaginationInfo pageInfo = PageAccess.getPagInfo(pageIndex,"member.UI_getListCnt",map, 10, 5);
			
			map.put("firstIndex", pageInfo.getFirstRecordIndex());
			map.put("lastIndex", pageInfo.getLastRecordIndex());
			map.put("recordCountPerPage", pageInfo.getRecordCountPerPage());
			
			mv.addObject("paginationInfo", pageInfo);
			
			List<HashMap<String,Object>> resultList = Component.getList("member.UI_getList", map); 
			mv.addObject("resultList", resultList);
			mv.addObject("searchKeyword", searchKeyword);
		}
		
		return mv;
	}
	
	
	@RequestMapping(value="/txap/homepage/authority/dataAjax.do")
	@ResponseBody
	public List<HashMap<String,Object>> adminAuthorityDataAjax(HttpServletRequest req
			) throws Exception {
		
		List<HashMap<String,Object>> list = Component.getListNoParam("Authority.UIA_GetList3");
		
		return list;
	}
	
	@RequestMapping(value="/txap/homepage/authority/saveAjax.do")
	@ResponseBody
	@Transactional
	@CheckActivityHistory(desc="권한 관리 권한 구조 추가/변경 작업")
	public void adminAuthoritySaveAjax(HttpServletRequest req
			) throws Exception {
		
		String UIA_KEYNO[] = req.getParameterValues("UIA_KEYNO");
		String UIA_NAME[] = req.getParameterValues("UIA_NAME");
		String UIA_SYSTEM[] = req.getParameterValues("UIA_SYSTEM");
		String UIA_MAINKEY[] = req.getParameterValues("UIA_MAINKEY");
		String UIA_DEPTH[] = req.getParameterValues("UIA_DEPTH");
		String UIA_ORDER[] = req.getParameterValues("UIA_ORDER");
		String UIA_DIVISION[] = req.getParameterValues("UIA_DIVISION");
		
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		HashMap<String,Object> keyList = new HashMap<String,Object>();
		
		List<String> notDeleteKeyList = new ArrayList<String>();
		notDeleteKeyList.add(SettingData.AUTHORITY_ANONYMOUS);
		
		HashMap<String,Object> temp = null;
		for(int i=0;i<UIA_KEYNO.length;i++){
			if(UIA_SYSTEM[i].equals("N")){
				temp = new HashMap<String,Object>();
				
				boolean changeCheck = false;
				
				String key = UIA_KEYNO[i];
				if(key.startsWith("UIA")){
					changeCheck = true;
				}else{
					key = CommonService.getTableKey("UIA");
					keyList.put( UIA_KEYNO[i], key);
				}
				
				temp.put("UIA_KEYNO", key);
				temp.put("UIA_NAME", UIA_NAME[i]);
				temp.put("UIA_SYSTEM", UIA_SYSTEM[i]);
				
				String mainkey = UIA_MAINKEY[i];
				if(!mainkey.equals("") &&!mainkey.startsWith("UIA")){
					mainkey = (String)keyList.get(UIA_MAINKEY[i]);
				}
				temp.put("UIA_MAINKEY", mainkey);
				temp.put("UIA_DEPTH", UIA_DEPTH[i]);
				temp.put("UIA_ORDER", UIA_ORDER[i]);
				temp.put("UIA_DIVISION", UIA_DIVISION[i]);
				list.add(temp);
				
				if(changeCheck){	//기존에 등록되어있던 키라면 
					// 변경되면 0 기존 그대로이면 1
					int isChange = Component.getCount("Authority.UIA_isChange", temp);
					if(isChange == 1){
						notDeleteKeyList.add(key);
					}
				}
				
				
			}
			
			
		}
		
		List<HashMap<String,Object>> columns = new ArrayList<HashMap<String,Object>>();
		HashMap<String,Object> column = new HashMap<String,Object>();
		column.put("name", "UIA_SYSTEM");
		column.put("operator", "=");
		column.put("value", "N");
		columns.add(column);
		
		column = new HashMap<String,Object>();
		column.put("name", "UIA_DIVISION");
		column.put("operator", "!=");
		column.put("value", "U");
		columns.add(column);
		CommonService.deleteData("T_USERINFO_AUTHORITY",columns);
		
		HashMap<String,Object> deleteMap = new HashMap<String,Object>();
		deleteMap.put("notDeleteKeyList", notDeleteKeyList);
		Component.deleteData("Authority.UAR_deleteData2", deleteMap);
		
		
		HashMap<String,Object> insertMap = new HashMap<String,Object>();
		insertMap.put("list", list);
		
		Component.createData("Authority.UIA_insertAll", insertMap);
		
		
		//유저 커스텀 권한 중 상위 권한 삭제된거 같이 삭제
		Component.deleteData("UIA_deleteCustomAuthorityData");
		
		Component.deleteData("UIA_deleteCustomAuthorityData2",CommonService.createMap("tableName","T_USERINFO_AUTHORITY_ROLL"));
		Component.deleteData("UIA_deleteCustomAuthorityData2",CommonService.createMap("tableName","T_USERINFO_MEMBER_AUTHORITY"));
		Component.deleteData("UIA_deleteCustomAuthorityData2",CommonService.createMap("tableName","T_USERINFO_RESOURCE_AUTHORITY"));
		
		
		
		
	}
	
	@RequestMapping(value="/txap/homepage/authority/menuListAjax.do")
	public ModelAndView adminAuthorityMenuListAjax(HttpServletRequest req
			,@RequestParam String type
			,@RequestParam String key
			) throws Exception {
		
		ModelAndView mv  = new ModelAndView("/txap/homepage/authority/list/pra_authority_menuList");
		String UIA_KEYNO = null;
		String UIA_MAINKEY = null;
		mv.addObject("type",type);
		if("A".equals(type)){
			HashMap<String,Object> resultMap = Component.getData("Authority.UIA_getData",key);
			mv.addObject("resultData", resultMap);
			UIA_KEYNO = key;
			UIA_MAINKEY = (String)resultMap.get("UIA_MAINKEY");
		}else if("B".equals(type)){
			HashMap<String,Object> user = Component.getData("member.UI_getData",key);
			UIA_KEYNO = (String)user.get("UIA_KEYNO");
			UIA_MAINKEY = (String)user.get("UIA_MAINKEY");
			mv.addObject("resultData", user);
		}
		
		//홈페이지 구분 리스트
		List<HomeManager> homeManagerList = CommonService.getHomeDivCode(true);
		
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		HashMap<String,Object> temp = null;
		for(HomeManager homeManager : homeManagerList){
			
			temp = new HashMap<String,Object>();
			homeManager.setUIA_KEYNO(UIA_KEYNO);
			homeManager.setUIA_MAINKEY(UIA_MAINKEY);
			temp.put("homeManager", homeManager);
			temp.put("menuList", AdminMenuService.getMenuList(homeManager,null,true));
			
			resultList.add(temp);
		}
		
		mv.addObject("resultList", resultList);
		
		
		
		mv.addObject("boardList", AdminAuthorityService.getBoardList(UIA_KEYNO));
		
		UserDTO subType = new UserDTO();
		subType.setUIR_TYPE(SettingData.AUTHORITY_SUB_BOARD);
		mv.addObject("boardAuthorityList", Component.getList("Authority.UIR_GetList", subType));
		
		
		
		
		return mv;
	}
	
	@RequestMapping(value="/txap/homepage/authority/saveMenuListAjax.do")
	@ResponseBody
	@Transactional
	@CheckActivityHistory(desc="권한 관리 - 권한별 메뉴 접근 권한 변경 작업")
	public String adminAuthoritySaveMenuListAjax(HttpServletRequest req
			,@RequestParam String type
			,@RequestParam(value="UIA_KEYNO",required=false) String UIA_KEYNO
			,@RequestParam(value="UIA_DIVISION",required=false) String UIA_DIVISION
			,@RequestParam(value="UI_ID",required=false) String UI_ID
			,@RequestParam(value="UI_KEYNO",required=false) String UI_KEYNO
			,@RequestParam(value="accessRole",required=false) String[] accessRole
			) throws Exception {
		
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		//권한에서 들어올경우
		if("A".equals(type)){
			map.put("UIA_KEYNO", UIA_KEYNO);
			Component.deleteData("Authority.UAR_deleteData", map);
		//회원에서 들어올경우	
		}else if("B".equals(type)){
			UserDTO user = Component.getData("member.selectUserInfo",UI_ID);
			
			//회원만의 권한이 없을경우 권한을 새로 만듬
			if("A".equals(UIA_DIVISION)){
				String newKey = CommonService.getTableKey("UIA");
				map.put("UIA_KEYNO", newKey);
				map.put("UIA_NAME", user.getUIA_NAME()+"("+UI_ID+")");
				map.put("UIA_SYSTEM", "N");
				map.put("UIA_MAINKEY", UIA_KEYNO);
				map.put("UIA_DEPTH", 6);
				map.put("UIA_ORDER", 0);
				map.put("UIA_DIVISION", "U");
				Component.createData("Authority.UIA_insertData", map);
				
				map.put("UI_KEYNO", UI_KEYNO);
				map.put("UIA_KEYNO", newKey.split(","));
				Component.deleteData("member.UI_deleteAuthority", map);
				Component.createData("member.UI_setAuthority", map);
				
				map = new HashMap<String,Object>();
				UIA_KEYNO = newKey;
				map.put("UIA_KEYNO", UIA_KEYNO);
			
			//회원만의 권한이 있을경우 기존 매핑 데이터만 삭제
			}else if("U".equals(UIA_DIVISION)){
				
				UIA_KEYNO = user.getUIA_KEYNO();
				map.put("UIA_KEYNO", UIA_KEYNO);
				Component.deleteData("Authority.UAR_deleteData", map);
			}else{
				return "F";
			}
		}else{
			return "F";
		}
		
		
		List<HashMap<String,Object>> roleList = new ArrayList<HashMap<String,Object>>();
		HashMap<String,Object> role = null;
		if(accessRole != null){
			for(String access : accessRole){
				role = new HashMap<String,Object>();
				role.put("MN_KEYNO", access);
				role.put("UIR_KEYNO", SettingData.AUTHORITY_ROLE_ACCESS);
				roleList.add(role);
			}
		}
		
		UserDTO subType = new UserDTO();
		subType.setUIR_TYPE(SettingData.AUTHORITY_SUB_BOARD);
		List<UserDTO> subTypeList = Component.getList("Authority.UIR_GetList", subType);
		
		for(UserDTO sub : subTypeList){
			String name = sub.getUIR_NAME();
			String key = sub.getUIR_KEYNO();
			
			String boardAuthList[] = req.getParameterValues(name+"Role");
			if(boardAuthList != null){
				for(String boardAuth : boardAuthList){
					role = new HashMap<String,Object>();
					role.put("MN_KEYNO", boardAuth);
					role.put("UIR_KEYNO", key);
					roleList.add(role);
				}
			}
			
			
		}
		
		
		if(roleList.size() > 0){
			map.put("roleList", roleList);
			Component.createData("Authority.UAR_insertAll", map);
		}
		
		//그룹일 경우 하위 권한 및 그룹의 권한들을 체크해서 같이 수정해준다.
		if(UIA_DIVISION != null && UIA_DIVISION.equals("G")){
			List<HashMap<String,Object>> childAuthoirtyList = AdminAuthorityService.getChildAuthority(UIA_KEYNO);
			
			if(childAuthoirtyList.size() > 0){
				HashMap<String,Object> childAUthorityMap = new HashMap<String,Object>();
				childAUthorityMap.put("UIA_KEYNO", UIA_KEYNO);
				childAUthorityMap.put("childAuthoirtyList", childAuthoirtyList);
				childAUthorityMap.put("UIR_KEYNO", SettingData.AUTHORITY_ROLE_ACCESS);
				
				//권한있는 유저의 해당 메뉴 권한 삭제
				List<HashMap<String, Object>> usergroup = Component.getList("Authority.UIA_selectChildAuthorityMappingMenu", childAUthorityMap);
				for (HashMap<String, Object> user : usergroup) {
					HashMap<String, Object> data = new HashMap<>();
					data.put("UIA_MAINKEY", user.get("UIA_KEYNO"));
					data.put("MN_KEYNO", user.get("MN_KEYNO"));
					Component.deleteData("Authority.UIA_deleteSubChildAuthorityMappingMenu",data);
				}
				
				Component.deleteData("Authority.UIA_deleteChildAuthorityMappingMenu", childAUthorityMap);
			}
			
		}else if(UIA_DIVISION.equals("A")){ //유저 게시판일 경우
			List<HashMap<String, Object>> childAuthoirtyList = Component.getList("Authority.UIA_selectChildAuthorityMappingKeyno", UIA_KEYNO);
			if(childAuthoirtyList.size() > 0){
				HashMap<String,Object> childAUthorityBoardMap = new HashMap<String,Object>();
				childAUthorityBoardMap.put("UIA_KEYNO", UIA_KEYNO);
				childAUthorityBoardMap.put("childAuthoirtyList", childAuthoirtyList);
				childAUthorityBoardMap.put("UIR_KEYNO", SettingData.AUTHORITY_ROLE_ACCESS);
				
				//권한있는 유저의 해당 메뉴 권한 삭제
				List<HashMap<String, Object>> usergroup = Component.getList("Authority.UIA_selectChildAuthorityMappingMenu", childAUthorityBoardMap);
				for (HashMap<String, Object> user : usergroup) {
					HashMap<String, Object> data = new HashMap<>();
					data.put("UIA_KEYNO", user.get("UIA_KEYNO"));
					data.put("MN_KEYNO", user.get("MN_KEYNO"));
					Component.deleteData("Authority.UIA_deleteSubChildAuthorityMappingBoard",data);
				}
			}
		}
		
		return "S";
		
	}
	
	@RequestMapping(value="/txap/homepage/authority/applyAuthorityAjax.do")
	@ResponseBody
	@Transactional
	@CheckActivityHistory(desc="권한 관리 - 서버 권한 재설정 작업")
	public void adminAuthorityApplyAuthorityAjax(HttpServletRequest req
			) throws Exception {
		
		AdminAuthorityService.applyAuhotiry();
	}
}
