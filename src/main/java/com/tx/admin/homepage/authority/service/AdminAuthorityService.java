package com.tx.admin.homepage.authority.service;

import java.util.HashMap;
import java.util.List;

/**
 * 권한 관리 서비스
 * @author 이재령
 * @date 2019-06-01
 *
 */
public interface AdminAuthorityService {

	/**
	 * 하위 그룹 및 권한 가져오기
	 * @param UIA_KEYNO
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String,Object>> getChildAuthority(String UIA_KEYNO) throws Exception;
	
	/**
	 * 게시판 리스트 트리구조로 가져오기
	 * @param UIA_KEYNO
	 * @return
	 * @throws Exception
	 */
	public List<HashMap<String,Object>> getBoardList(String UIA_KEYNO) throws Exception;
	
	/**
	 * 시스템 권한 재설정
	 * @throws Exception
	 */
	public void applyAuhotiry() throws Exception;
}
