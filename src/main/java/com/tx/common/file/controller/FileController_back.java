package com.tx.common.file.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileDownloadTools;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 
 * @FileName: FileController.java
 * @Project : SafetheFood
 * @Date    : 2016. 12. 21. 
 * @Author  : 이재령
 * @Version :
 */
//@Controller
public class FileController_back {
	
	Logger log = Logger.getLogger(this.getClass());
     
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** 파일다운로드 툴*/
	@Autowired private FileDownloadTools FileDownloadTools;
  
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/** 프로퍼티 정보 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	/**
	 * 파일 다운로드 처리
	 * @param model
	 * @param req
	 * @param FS_FM_KEYNO
	 * @throws Exception
	 */
	@RequestMapping(value = "/async/MultiFile/download.do")
	@ResponseBody
	public void MultiFileDownload(Model model
			, HttpServletRequest req 
			, HttpServletResponse res 
			, @ModelAttribute FileSub FileSub 
			) throws Exception{
		
			
			FileSub = Component.getData("File.AFS_SubFileDetailselect", FileSub);
			//FileDownload
			FileDownloadTools.FileDownload(FileSub, req, res);

	}
	
	@RequestMapping(value = "/async/file/download.do")
	@ResponseBody
	public void manualDownload(Model model
			, HttpServletRequest req 
			, HttpServletResponse res 
			, @RequestParam String filepath
			, @RequestParam(value="filename",required = false) String filename
			) throws Exception{
		
			String name;
			if(filename != null){
				name = filename;
			}else{
				name = filepath.substring(filepath.lastIndexOf("/")+1);
			}
		
			//FileDownload
			FileDownloadTools.FileDownload(filepath,name, req, res);

	}
	

	/**
	 * 파일 상위 키 갱신 처리
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/async/MultiFile/mainkey/select.do")
	@ResponseBody
	public String getMultFileMainFilekey() throws Exception{
		return CommonService.getTableKey("FM"); //파일 상위정보 키 갱신
	}
	
	
	/**
	 * 파일 업로드 처리
	 * @param req
	 * @param FS_FM_KEYNO
	 * @throws Exception
	 */
	@RequestMapping(value = "/async/MultiFile/uploadAjax.do")
	@ResponseBody
	public FileSub MultiFileUpLoad(HttpServletRequest req
//		, @RequestParam(value="FS_FM_KEYNO",required = false) String FS_FM_KEYNO
			,String FS_FM_KEYNO
		) throws Exception{ 
		
		//등록자
		if(req.getSession().getAttribute("userInfo")!=null){
			String UI_KEYNO = CommonService.getSessionUserKey(req);
			if( !UI_KEYNO.isEmpty() ){
				FileSub FileSub = FileUploadTools.FileUpload(req, UI_KEYNO, new FileSub(FS_FM_KEYNO, null));
				
				if(FileSub.getFS_EXT() == null){
					throw new NullPointerException();
				}
				return FileSub;
						
			}else{
					throw new NullPointerException("#00 로그인 세션 정보 내 키값이 없습니다.");
			}
		}else{
				throw new NullPointerException("#00 로그인 세션 정보가 없습니다.");
		}
		
	}
	

	/**
	 * 파일 관리자용 업로드 처리
	 * @param req
	 * @param FS_FM_KEYNO
	 * @param FS_KEYNO
	 * @param fileName - 업로드할 파일 form의 name값 - defaultValue : file
	 * @throws Exception
	 */
	@RequestMapping(value = "/async/MultiFile/single/uploadAjax.do")
	@ResponseBody
	public FileSub MultiFileUpLoadInFileManage(HttpServletRequest req
			,String FS_FM_KEYNO
			,@RequestParam(value = "FS_KEYNO", required=false, defaultValue="") String FS_KEYNO
			,@RequestParam(value = "fileName", required=false, defaultValue="file") String fileName
			,FileSub fileSub
			) throws Exception{
		
			//세션 내 유저키
			String User = CommonService.getSessionUserKey(req);
			if( !User.isEmpty() ){
				final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) req;
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				MultipartFile file = null;
				if( files.get(fileName) != null ){
					file = files.get(fileName);
				}else{
					Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
					if(itr.hasNext()){
						Entry<String, MultipartFile> entry = itr.next();
						file = entry.getValue();
					}
				}
				fileSub = FileUploadTools.FileUpload(file, User, fileSub);
				
			}else{
				throw new NullPointerException();
			} 
		
		return fileSub;
	}
	
	
	/**
	 * @param req - FS_KEYNO, FS_ALT, FS_COMMENTS...
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/async/file/info/uploadAjax.do")
	@ResponseBody
	public List<FileSub> fileInfoUpdate(HttpServletRequest req
			) throws Exception{
		List<FileSub> fsList = new ArrayList<FileSub>();
		//세션 내 유저키
		String User = CommonService.getSessionUserKey(req);
		if( !User.isEmpty() ){
			fsList = FileUploadTools.getFileSubInfoList(req);
			for( FileSub fs : fsList ){
				Component.updateData("FileManage.AFS_SubInfoUpdate", fs);
			}
		}else{
			throw new NullPointerException();
		} 
		
		return fsList;
	}
	
	
	
	/**
	 * 파일 삭제
	 * @param model
	 * @param req
	 * @param FS_KEYNO
	 * @throws Exception
	 */
	@RequestMapping(value = "/async/MultiFile/fs/deleteAjax.do")
	@ResponseBody
	public void MultiFileDelete(HttpServletRequest req
			,String FS_KEYNO
			) throws Exception{
		
		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) req.getSession().getAttribute("userInfo");
		
		if(map == null){
			System.out.println("유저 정보가 없음 - 파일 삭제 불가");
			return;
		}
		
		FS_KEYNO = CommonService.getKeyno(FS_KEYNO, "FS");
		FileSub FileSub = Component.getData("File.AFS_SubFileDetailselect",FS_KEYNO);
		String isAdmin = map.get("isAdmin") +"";
		String userId = map.get("UI_KEYNO") +"";
		
		// 관리자 이거나 파일 업로드 한사람일경우만 삭제
		if(FileSub != null && (isAdmin.equals("Y") || FileSub.getFS_REGNM().equals(userId))){
			//Component.deleteData("File.AFS_FileDeleteFileSub", FS_KEYNO);
			/* 2019.01.21. 물리파일도 함께 삭제 */
			FileUploadTools.UpdateFileDelete(FS_KEYNO);
		}else{
			System.out.println("회원정보가 일치하지 않고 관리자도 아님 - 파일 삭제 불가");
		}
		
	}
	
//	/**
//	 * 업로드 파일 로딩
//	 * @param model
//	 * @param req
//	 * @param FS_KEYNO
//	 * @throws Exception
//	 */
//	@RequestMapping(value = "/async/MultiFile/fs/load.do")
//	@ResponseBody
//	public JSONObject MultiFileLoad(HttpServletRequest req
//			,String FS_KEYNO
//			) throws Exception{
//		List<FileSub> list = new ArrayList<FileSub>();
//		JSONObject j = new JSONObject();
//
//		list = Component.getList("File.AFS_FileSelectFileSub", FS_KEYNO);
//		j.put("name", list.get(3));
//		j.put("path", "/resources/img/upload/2/"+list.get(4)+"."+list.get(5));
//		j.put("size", list.get(2));
//		
//		return j;
//		}
	
	/**
	 * CkEditor 파일 업로드
	 * @param req
	 * @param FS_FM_KEYNO
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/community/imageUpload.do", method = RequestMethod.POST)
	public void CkEditorFileUpLoad(HttpServletRequest request, HttpServletResponse response
			,@RequestParam(value = "upload", required = false) MultipartFile upload
			,@RequestParam(value = "CKEditorFuncNum", required=false, defaultValue="") String CKEditorFuncNum) throws Exception {
		
		HashMap<String, Object> HashMap = new HashMap<>();

		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) request.getSession().getAttribute("userInfo");
		String User = map.get("UI_KEYNO").toString();
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        FileSub FileSub = new FileSub();
		FileSub = FileUploadTools.ckeditorImageUpload(request, response, upload, User);

		String dir = "/resources/img/upload/";
		String path = dir + FileSub.getFS_FOLDER() + FileSub.getFS_CHANGENM() + "." + FileSub.getFS_EXT();
		HashMap.put("FUNC_NUM", 1);
		HashMap.put("FILE_PATH", path);
	
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); 
//		{"filename" : "'.$img_filename.'", "uploaded" : 1, "url":"'.$img_url.'"}
		String ck = "{\"filename\" : \""+FileSub.getFS_ORINM()+"\", \"uploaded\" : 1, \"url\":\""+path+"\"}";
		out.println(ck);
		System.out.println(ck);
		out.flush();
		
		return;
	}
	
	
}
