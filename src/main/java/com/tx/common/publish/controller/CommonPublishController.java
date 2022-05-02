package com.tx.common.publish.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.tx.admin.board.dto.BoardColumn;
import com.tx.admin.board.dto.BoardMainMini;
import com.tx.admin.operation.popupzone.dto.CategoryDTO;
import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.dto.Common;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 
 * @FileName: CommonPublishController.java
 * @Date    : 2019. 06. 10. 
 * @Author  : 주지은	
 * @Version : 1.0
 */
@Controller
public class CommonPublishController {

	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
    @RequestMapping(value = "/common/Board/MainMiniBoard/UserViewAjax.do")
    public ModelAndView exam1(HttpServletRequest req, Common search, Map<String, Object> commandMap) throws Exception {
        ModelAndView mv  = new ModelAndView();
        
        String key = (String) req.getParameter("key");
        
        BoardMainMini BoardMainMini = new BoardMainMini();
        BoardMainMini.setBMM_KEYNO(CommonService.getKeyno(key, "BMM"));
        
        //미니게시판 정보 가져오기
        BoardMainMini = Component.getData("BoardMainMini.BMM_getData", BoardMainMini);
        
        //JSP 경로 설정
        String fileName = "prp_" + BoardMainMini.getBMM_KEYNO() + ".jsp";
		String filePath = propertiesService.getString("jspPath") + "publish" + BoardMainMini.getBMM_MN_HOMEDIV_URL() + "/miniBoard/";
        
        String jspPage = "";
        File file = new File(filePath + fileName);
		if(file.exists()){
			jspPage = "/publish" + BoardMainMini.getBMM_MN_HOMEDIV_URL() + "/miniBoard/prp_" + BoardMainMini.getBMM_KEYNO() ;
		}else{
			jspPage = "/error/error";
		}
        
        HashMap<String, Object> map = new HashMap<>();
        String MN_KEYNO = BoardMainMini.getBMM_MN_KEYNO();
        map.put("MN_KEYNO", MN_KEYNO);

        map.put("BOARD_COLUMN_TYPE_CHECK", SettingData.BOARD_COLUMN_TYPE_CHECK);
        map.put("BOARD_COLUMN_TYPE_CHECK_CODE", SettingData.BOARD_COLUMN_TYPE_CHECK_CODE);
        map.put("BOARD_COLUMN_TYPE_RADIO_CODE", SettingData.BOARD_COLUMN_TYPE_RADIO_CODE);
        map.put("BOARD_COLUMN_TYPE_SELECT_CODE", SettingData.BOARD_COLUMN_TYPE_SELECT_CODE);

        List<BoardColumn> BoardColumnList = Component.getList("BoardColumn.BL_getviewList2", MN_KEYNO);
        map.put("BoardColumnList", BoardColumnList);
        map.put("SIZE", Integer.parseInt(BoardMainMini.getBMM_SIZE()));

        mv.addObject("resultList", Component.getList("BoardMainMini.User_Board_List", map));
        mv.addObject("tiles", BoardMainMini.getBMM_MN_HOMEDIV_TILES());
        mv.addObject("tilesUrl", BoardMainMini.getBMM_MN_HOMEDIV_URL());
        
        mv.setViewName(jspPage);    
        
        return mv;
    }

    /*
     * 카테고리 관리
     * */
    @RequestMapping(value = "/common/operation/popupzone/UserViewAjax.do")
	public ModelAndView userView(HttpServletRequest req, Common search, Map<String, Object> commandMap) throws Exception {
		ModelAndView mv  = new ModelAndView();
		
		String key = (String) req.getParameter("key");
		CategoryDTO CategoryDTO = new CategoryDTO();
		CategoryDTO.setTCGM_KEYNO(CommonService.getKeyno(key, "TCGM"));
		
		//카테고리 정보 가져오기
		CategoryDTO = Component.getData("Category.TCGM_getData", CategoryDTO);
		
		//JSP 경로 설정
		String path = CategoryDTO.getTCGM_FILE_PATH();
		String fileName = CategoryDTO.getTCGM_FILE_NAME();
		fileName = fileName.substring(0, fileName.indexOf(".jsp") );
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("TCGM_KEYNO", CategoryDTO.getTCGM_KEYNO());

		mv.addObject("resultList", Component.getList("Category.TCGM_getListByTCGM_Keyno", map));
		
		mv.setViewName("/" + path + fileName + ".notiles");	
		
		return mv;
	}
	
}
