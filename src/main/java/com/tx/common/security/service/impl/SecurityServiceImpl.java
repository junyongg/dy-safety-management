package com.tx.common.security.service.impl;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.tx.admin.member.dto.UserDTO;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.security.service.SecurityService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("SecurityService")
public class SecurityServiceImpl extends EgovAbstractServiceImpl implements SecurityService{

	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	/**
	 * 스프링 시큐리티 권한 생성
	 * @param currentAuth
	 * @param username
	 * @param req
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Authentication createNewAuthentication(Authentication currentAuth, String username, HttpServletRequest req) {
		
		UserDTO user = Component.getData("member.selectUserInfo", username);
		user.decode();
        UserDetails newPrincipal = user;
        Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
        String authority[] = user.getUIA_NAME().split(",");
		for(String auth : authority){
			roles.add(new SimpleGrantedAuthority(auth));
		}
		
        UsernamePasswordAuthenticationToken newAuth = 
            new UsernamePasswordAuthenticationToken(newPrincipal,currentAuth.getCredentials(),roles);
        newAuth.setDetails(currentAuth.getDetails());
        Object principal = newAuth.getPrincipal();
		Map<String, Object> map = ConverObjectToMap(principal);
		if (principal != null && principal instanceof UserDTO) {
			String UIA_NAME = (String)map.get("UIA_NAME");
			Map<String, Object> authorityMap = new HashMap<String,Object>();
			authorityMap.put("authList", UIA_NAME.split(","));
			map.put("isAdmin", Component.getData("Authority.UIA_isAdmin", authorityMap)); //관리자 여부
			String ip = CommonService.getClientIP(req);
			map.put("ip", ip);
			req.getSession().setAttribute("userInfo", map);
		}
        return newAuth;
    }
	
	/**
	 * Object -> map
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static Map ConverObjectToMap(Object obj) {
		try {
			// Field[] fields = obj.getClass().getFields(); //private field는 나오지
			// 않음.
			Field[] fields = obj.getClass().getDeclaredFields();
			Map resultMap = new HashMap();
			for (int i = 0; i <= fields.length - 1; i++) {
				fields[i].setAccessible(true);
				resultMap.put(fields[i].getName(), fields[i].get(obj));
			}
			return resultMap;
		} catch (IllegalArgumentException e) {
			System.out.println(e.getMessage());
		} catch (IllegalAccessException e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
}
