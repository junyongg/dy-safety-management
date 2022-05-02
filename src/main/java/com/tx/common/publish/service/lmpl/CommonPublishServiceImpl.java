package com.tx.common.publish.service.lmpl;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.tx.admin.board.dto.BoardMainMini;
import com.tx.admin.homepage.resource.dto.ResourcesDTO;
import com.tx.admin.operation.popupzone.dto.PopupZoneCategoryDTO;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileManageTools;
import com.tx.common.publish.service.CommonPublishService;
import com.tx.common.util.tld.SiteProperties;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
@Service("CommonPublishService")
public class CommonPublishServiceImpl extends EgovAbstractServiceImpl implements CommonPublishService {
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	@Autowired FileManageTools FileManageTools;
	
	/**
	 * 리소스(css,js) 배포
	 */
	@Override
	public boolean resource(String tiles, String homeDiv , String key) throws Exception {
		// TODO Auto-generated method stub
		
		String resourceTypeList[] = {"css","js"};
		
		for(String resourceType : resourceTypeList){
			if(!resource(tiles, homeDiv, key, resourceType)) return false;
		}
		
		return true;
	}
	
	/**
	 * 리소스(css,js) 배포
	 */
	@Override
	public boolean resource(String tiles, String homeDiv , String key, String resourceType) throws Exception {
		// TODO Auto-generated method stub
		
		String filePath = checkSlush("RESOURCE_PATH") + "/publish/" + tiles +"/" + resourceType +"/";
		
		HashMap<String, Object> data = new HashMap<>();
		data.put("RM_MN_HOMEDIV_C", homeDiv);
		data.put("RM_TYPE", resourceType);
		
		if(StringUtils.isNotEmpty(key)) data.put("RM_KEYNO", key);
		
		List<HashMap<String, Object>> resourcesList = Component.getList("Resources.RM_getData", data);
		
		for (HashMap<String, Object> hashMap : resourcesList) {
			
			String str = StringUtils.defaultIfEmpty((String)hashMap.get("RM_DATA"), "");
			String fileName = (String)hashMap.get("RM_FILE_NAME") +"." + resourceType;
			
			boolean isCompression = fileName.contains(".min");
			if(!FileManageTools.create_File(filePath, fileName, str, isCompression)){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 레이아웃 배포
	 */
	@Override
	public boolean layout(String tiles, String homeDiv , String scope, boolean distributeType) throws Exception {
		// TODO Auto-generated method stub
		String filePath = checkSlush("JSP_PATH") + "/user/publish/" + tiles +"/";
		
		HashMap<String, Object> data = new HashMap<>();
		data.put("RM_MN_HOMEDIV_C", homeDiv);
		data.put("RM_TYPE", "layout");
		
		if(distributeType){scope = "";}
		
		if(StringUtils.isNotEmpty(scope)) data.put("RM_SCOPE", scope);
		
		List<ResourcesDTO> resourcesList = Component.getList("Resources.RM_getLayoutData", data);
		
		for (ResourcesDTO resources : resourcesList) {
			String layoutFilePath = filePath;
			String str = StringUtils.defaultIfEmpty(resources.getRM_DATA(), "");
			String fileName = resources.getRM_FILE_NAME() + ".jsp";
			if(!resources.getRM_SCOPE().equals("prc_main")){
				layoutFilePath = filePath + "include/";
			}
			boolean isCompression = fileName.contains(".min");
			
			if(!FileManageTools.create_File(layoutFilePath, fileName, str, isCompression)){
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * 페이지 배포
	 */
	@Override
	public boolean page(String tiles, String homeDiv , String key) throws Exception {
		// TODO Auto-generated method stub
		
		String filePath = checkSlush("JSP_PATH") + "/user/publish/" + tiles +"/views/";
		
		HashMap<String, Object> data = new HashMap<>();
		data.put("MVD_MN_HOMEDIV_C", homeDiv);
		if(StringUtils.isNotEmpty(key)){
			data.put("MVD_KEYNO", key);
		}
		
		List<HashMap<String, Object>> pageList = Component.getList("HTMLViewData.get_PageViewInfo", data);
		for (HashMap<String, Object> page : pageList) {
			String str = SettingData.JSPDATA;
			String MVD_DATA = (String)page.get("MVD_DATA");
			if(StringUtils.isNotEmpty(MVD_DATA)){
				str += MVD_DATA;
			}
			String fileName = getFileName("page", (String) page.get("MN_KEYNO"),true);
			boolean isCompression = fileName.contains(".min");
			
			if(!FileManageTools.create_File(filePath, fileName, str, isCompression)){
				return false;
			}
		}
		
		return true;
	}
	@Value("${jsp.path}") private String jsp_path;

	
	/**
	 * 페이지 미리보기 배포
	 */
	@Override
	public boolean pagePreview(String tiles, String contents) throws Exception {
		// TODO Auto-generated method stub
		contents = SettingData.JSPDATA + contents;
		//여기 수정해줘야함 ㅡㅡ;
		String filePath = jsp_path  + "user/publish/" + tiles +"/views/temp/";
		
		return FileManageTools.create_File(filePath, "temp.jsp", contents, false);
	}
	
	/**
	 * 미니게시판 배포
	 */
	@Override
	public boolean boardMini(BoardMainMini BoardMainMini) throws Exception{
		
		if(BoardMainMini == null ) BoardMainMini = new BoardMainMini();
		
		List<HashMap<String,Object>> list = Component.getList("BoardMainMini.BMM_getData", BoardMainMini);
		
		for (HashMap<String,Object> mini: list) {
			String fileName = getFileName("boardMini", (String)mini.get("BMM_KEYNO"),true);
			String filePath = checkSlush("JSP_PATH") + "/user/publish" + mini.get("BMM_MN_HOMEDIV_URL") + "/miniBoard/";
			
			String data = SettingData.JSPDATA + mini.get("BMM_FORM");
			if(!FileManageTools.create_File(filePath, fileName, data, false)){
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * 팝업존 카테고리 배포
	 */
	public boolean popupZone(PopupZoneCategoryDTO CategoryDTO) throws Exception{
		
		if(CategoryDTO == null ) CategoryDTO = new PopupZoneCategoryDTO();
		
		//데이터 가져오기
		List<HashMap<String,Object>> categoryList = Component.getList("PopupZone.TCGM_getData", CategoryDTO);
		
		HashMap<String, Object> map = null;
		
		for(HashMap<String,Object> cateogry : categoryList) {
			String fileName = getFileName("popupZone", (String)cateogry.get("TCGM_KEYNO"),true);
			String filePath = "/user/publish" + cateogry.get("TCGM_MN_HOMEDIV_URL") + "/popupZone/";
			String fullPath = checkSlush("JSP_PATH") + filePath;
			String data = SettingData.JSPDATA + cateogry.get("TCGM_FORM");
			
			boolean state = FileManageTools.create_File(fullPath, fileName, data, false);
			
			//파일 내용 저장
			if(state) {
				map = new HashMap<String, Object>();
				map.put("fileName", fileName);
				map.put("filePath", filePath);
				map.put("TCGM_KEYNO", cateogry.get("TCGM_KEYNO"));
				Component.updateData("PopupZone.TCGM_fileCreate", map);
			} else {
				System.out.println("카테고리 배포...ing 배포실패!");
				return false;
			}
			
		}
		
		return true;
	}
	
	@Override
	public String getFileName(String type , String key, boolean isAddExt){
		
		String fileName = null;
		
		key = key.substring(key.indexOf("_"));
		
		key = CommonService.getKeyno(key, "");
		switch (type) {
		case "page":
			fileName= "prp_views" + key;
			break;
		case "boardMini":
			fileName= "prp_miniboard" + key;
			break;
		case "popupZone":
			fileName= "prp_popupZone" + key;
			break;

		default:
			break;
		}
		if(isAddExt){
			fileName += ".jsp";
		}
		return fileName;
	}

	private String checkSlush(String properties) {
		// TODO Auto-generated method stub
		
		String path = SiteProperties.getString(properties);
		if(!path.endsWith("/")){
			path = path + "/";
		}
		return path;
	}
	
	
}

