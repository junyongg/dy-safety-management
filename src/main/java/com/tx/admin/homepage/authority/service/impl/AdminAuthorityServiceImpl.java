package com.tx.admin.homepage.authority.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.admin.homepage.authority.dto.SecuredResource;
import com.tx.admin.homepage.authority.service.AdminAuthorityService;
import com.tx.admin.member.dto.UserDTO;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.security.handler.ReloadableFilterInvocationSecurityMetadataSource;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 권한 관리 서비스
 * @author 신강철
 * @date 2019-06-01
 *
 */
@Service("AdminAuthorityService")
public class AdminAuthorityServiceImpl  extends EgovAbstractServiceImpl implements AdminAuthorityService{
	
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 리로드 권한설정 */
	@Autowired ReloadableFilterInvocationSecurityMetadataSource reloadableFilterInvocationSecurityMetadataSource;
	
	/**
	 * 하위 그룹 및 권한 가져오기
	 * @param UIA_KEYNO
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<HashMap<String,Object>> getChildAuthority(String UIA_KEYNO) throws Exception{
		
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		List<HashMap<String,Object>> authorityList = Component.getListNoParam("Authority.UIA_GetList3");
		
		getChild(UIA_KEYNO,resultList,authorityList);
		
		return resultList;
	}
	
	private void getChild(String mainKey, List<HashMap<String,Object>> resultList, List<HashMap<String,Object>> authorityList) {
		// TODO Auto-generated method stub
		
		for(HashMap<String,Object> authority : authorityList){
			String UIA_MAINKEY = (String)authority.get("UIA_MAINKEY");
			
			if(mainKey.equals(UIA_MAINKEY)){
				resultList.add(authority);
				int depth = Integer.parseInt(authority.get("UIA_DEPTH").toString());
				String division = authority.get("UIA_DIVISION").toString();
				if(division.equals("G") && depth != 5){
					String UIA_KEYNO = authority.get("UIA_KEYNO").toString();
					getChild(UIA_KEYNO,resultList,authorityList);
				}
			}
		}
		
	}
	
	@Override
	public List<HashMap<String,Object>> getBoardList(String UIA_KEYNO) throws Exception {
		
		List<HashMap<String,Object>> boardList = Component.getList("Authority.UIA_boardList", UIA_KEYNO);
		
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		resultList.add(getBoardMap("","게시판","",1));
		
		String beforeHomeDiv = "";
		
		for(HashMap<String,Object> board : boardList){
			String homeDiv = board.get("MN_HOMEDIV_NAME").toString();
			if(!beforeHomeDiv.equals(homeDiv)){
				resultList.add(getBoardMap("",homeDiv,"",2));
				beforeHomeDiv = homeDiv;
			}
			String key = board.get("MN_KEYNO").toString();
			String name = board.get("MN_NAME").toString();
			String uirKey = (String)board.get("UIR_KEYNO");
			resultList.add(getBoardMap(key,name,uirKey,3));
			
		}
		
		return resultList;
		
	}
	
	private HashMap<String, Object> getBoardMap(String key, String name, String uirKey, int depth) {
		// TODO Auto-generated method stub
		HashMap<String,Object> temp = new HashMap<String,Object>();
		temp.put("MN_KEYNO", key);
		temp.put("MN_NAME", name);
		temp.put("UIR_KEYNO", uirKey);
		temp.put("MN_DEPTH", depth);
		return temp;
	}

	/**
	 * 시스템 권한 재설정
	 * @throws Exception
	 */
	@Override
	public void applyAuhotiry() throws Exception {
		
		//기존값 초기화
		CommonService.deleteData("T_USERINFO_SECURED_RESOURCE",null);
		CommonService.deleteData("T_USERINFO_RESOURCE_AUTHORITY",null);
		
		
		List<String> authorityList = Component.getListNoParam("Authority.UIA_GetAllList");
		
		List<HashMap<String,Object>> menuList = Component.getList("Authority.USR_getMenuListWidthAuthority", SettingData.AUTHORITY_ROLE_ACCESS);
		
		
		List<SecuredResource> securedResourceList = new ArrayList<SecuredResource>();
		
		List<SecuredResource> resourceAuthorityList = new ArrayList<SecuredResource>();
		
		Integer dataCount = 1;
		
		String USR_KEYNO = CommonService.getKeyno((dataCount++)+"", "USR");
		securedResourceList.add(new SecuredResource(USR_KEYNO,"/txap/user/**",1,SettingData.AUTHORITY_ROLE_ACCESS,""));
		addResourceAuthority(USR_KEYNO,authorityList,resourceAuthorityList);
		
		for(HashMap<String,Object> menu : menuList){
			
			String UIA_KEYNO[] = ((String)menu.get("UIA_KEYNO")).split(",");
			if(authorityList.size() == UIA_KEYNO.length + 1){
				//메뉴에 대해 모두 권한을 가지고 있으면 넘긴다 (설정값이 없으면 모두 접근 가능하다.), 개발자 권한을 더해줘야 모든 권한이 된다.
				continue;
			}
			
			USR_KEYNO = CommonService.getKeyno((dataCount++)+"", "USR");
			int USR_ORDER = Integer.parseInt(menu.get("USR_ORDER")+"");
			String MN_KEYNO = (String)menu.get("MN_KEYNO");
			securedResourceList.add(new SecuredResource(USR_KEYNO,"",USR_ORDER,SettingData.AUTHORITY_ROLE_ACCESS,MN_KEYNO));
			addResourceAuthority(USR_KEYNO,(String)menu.get("UIA_KEYNO"),resourceAuthorityList);
		}
		
		USR_KEYNO = CommonService.getKeyno((dataCount++)+"", "USR");
		securedResourceList.add(new SecuredResource(USR_KEYNO,"/**",100,SettingData.AUTHORITY_ROLE_ACCESS,""));
		addResourceAuthority(USR_KEYNO,authorityList,resourceAuthorityList);
		
		
		Component.createDataWithSplitList(null,securedResourceList,"Authority.securedResourceInsertAllData","securedResourceList",200);
		Component.createDataWithSplitList(null,resourceAuthorityList,"Authority.resourceAuthorityInsertAllData","resourceAuthorityList",200);
		
		
		reloadableFilterInvocationSecurityMetadataSource.reload();
		
	}

	private void addResourceAuthority(String USR_KEYNO, List<String> authorityList,
			List<SecuredResource> resourceAuthorityList) {
		// TODO Auto-generated method stub
		
		for(String authority : authorityList){
			resourceAuthorityList.add(new SecuredResource(USR_KEYNO,authority));
		}
	}
	
	private void addResourceAuthority(String USR_KEYNO, String authority,
			List<SecuredResource> resourceAuthorityList) {
		// TODO Auto-generated method stub
		authority += "," + SettingData.AUTHORITY_ADMIN;
		List<String> authorityList = Arrays.asList(authority.split(","));
		addResourceAuthority(USR_KEYNO,authorityList,resourceAuthorityList);
		
	}
}
