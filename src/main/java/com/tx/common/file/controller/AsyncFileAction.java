package com.tx.common.file.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tika.Tika;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileSub;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @AsyncFileAction
 * 비동기 처리 - 파일정보 및 배치 처리 등 비동기 처리로 수행할 서블릿을 담당한다.
 * @author 신희원
 * @version 1.0
 * @since 2014-11-16
 */

@Controller
public class AsyncFileAction {
	
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	

//	/** 페이지 처리 컨포넌트*/
//	@Autowired private PageAccess PageAccess;
	
	/** 프로퍼티 정보 */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;
	
  
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
  

	
	/*
	 * CKEDITOR 관련 업로드 메소드 - 기존 문화전당 소스 (유저 권한관리 작업 중이라 관련처리 임시삭제함)
	 */
	
	
	/**
	 * 파일 상위 키 갱신 처리
	 * @return
	 * @throws Exception
	 */
	public String getMultFileMainFilekey() throws Exception{
		return CommonService.getTableKey("FM"); //파일 상위정보 키 갱신
	}
	
	/**
	 * 파일 타입 체크 (이미지인지 PDF인지...)
	 * @param reg, 문자열 fileType ( ex "image" 나 "pdf" 등 )
	*/
	public boolean fileTypeChk( HttpServletRequest req, String[] fileType ){
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) req;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		
		while (itr.hasNext()){
			Entry<String, MultipartFile> entry = itr.next();
			MultipartFile file = entry.getValue();
			
			Tika tika = new Tika();
	    String mimetype = "";
			try {
				mimetype = tika.detect(file.getInputStream());
				//System.err.println(mimetype+"############# mimetype");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.err.println("isImageFile() ERROR");
			}
			
			String mimetypeLowerCase = mimetype.toLowerCase();
			for( String ft : fileType ){
				if( ft == null ) { ft = ""; }
				if( mimetypeLowerCase.indexOf(ft.toLowerCase()) >= 0 ){
					//System.err.println("@@@####"+ft+" 형식 확인 - TIKA MIME-TYPE 확인 : " + mimetype );				    
					return true;
				}
				if( ft.equals("master") ){ // 파일 업로드 제한 X 권한
					System.out.println("#51 : 확장자 체크 예외처리 : fileType 'master' in " + req.getRequestURI());
					return true;
				}
			}
		}
		return false;
	}
	
	
	/**
	 * CKeditor 관리자용 에디터 (단일) 파일업로드 프로세스 - 
	 * @param model
	 * @param req
	 * @param FS_FM_KEYNO
	 * @throws Exception
	 * @comment 기존  summernote가 사용하던 프로세스인 위의 메서드 MultiEditFileUpLoad()를 서비스 형태로 수정.
	 * 					FS_FM_KEYNO를 구하는 메서드를 내부에서 직접 호출 / return으로 ckeditor에 반응하는 함수값을 넘겨준다.
	 * @author SooAn
	 */
	@RequestMapping(value = "/ckeditor/SingleFile/uploadAjax.do", produces ="text/HTML; charset=utf8")
	@ResponseBody
	public String CK_SingleFileUpLoad(
			HttpServletRequest req
			,  String CKEditorFuncNum
			,  String[] fileType
			) throws Exception{ 
		
		//권한관리에 따른 업로드/다운로드는 원본소스 참조
		
	//프로퍼티 경로 불러오기
			String propertiespath = "/resources/img/upload/"; // 업로드 파일 저장 경로
//			String propertiespath = propertiesService.getString("FilePath");; // 업로드 파일 저장 경로
			
			String FS_FM_KEYNO = getMultFileMainFilekey();
			//등록자
//					String User = UserDTO.getUSER_SEQ();
					String User = CommonService.getSessionUserKey(req);
					
					boolean isChecked = fileTypeChk(req, fileType);
					String ret = "";

					if( isChecked == true ){
						FileSub FileSub = FileUploadTools.FileUpload(req, User, new FileSub(FS_FM_KEYNO, null)); // 파일 업로드
						ret = "<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
								+ CKEditorFuncNum + " , '" + propertiespath + FileSub.getFS_FOLDER() + FileSub.getFS_CHANGENM() + "." + FileSub.getFS_EXT() +"',  \"완료!\");</script>";
					}else{
						ret = "<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
								+ CKEditorFuncNum + " , '', \"적합한 파일 형식이 아닙니다.\");</script>";
					}
					return ret;
//			}else if(SecuritySession.getCurrentUser() instanceof WebUserDTO){
			
		}

	
	
	/**
	 * CKeditor 관리자용 에디터 드래그&드랍 방식 다중파일업로드에 이용되는 프로세스
	 * @param model
	 * @param req
	 * @param FS_FM_KEYNO
	 * @throws Exception
	 * @comment (!)1파일에 1개씩 업로드, 여러번 호출 
	 * @author SooAn
	 */
	@RequestMapping(value = "/ckeditor/MultiFile/uploadAjax.do", produces ="application/json; charset=utf8")
	@ResponseBody
	public JSONObject MultiEditFileUpLoad2(Model model
			,  HttpServletRequest req
			,  String CKEditorFuncNum
			) throws Exception{
		
	//프로퍼티 경로 불러오기
//			String propertiespath = "/resources/upload/"; // 업로드 파일 저장 경로
			String propertiespath = propertiesService.getString("FilePath"); // 업로드 파일 저장 경로
			
			String FS_FM_KEYNO = getMultFileMainFilekey();
			//등록자
//				WebUserDTO WebUserDTO = (WebUserDTO) SecuritySession.getCurrentUser();
					String User = CommonService.getSessionUserKey(req);
					FileSub FileSub = FileUploadTools.FileUpload(req, User, new FileSub(FS_FM_KEYNO, null)); // 파일 업로드
					String fileName = FileSub.getFS_CHANGENM() + "." +FileSub.getFS_EXT();
					JSONObject ret = new JSONObject();
					ret.put("uploaded", 1); // 단일로 정해짐
					ret.put("fileName", fileName);
					ret.put("url", propertiespath+FileSub.getFS_FOLDER() + fileName);
					//System.err.println(ret);
					return ret;
		}
	
	
	/**
	 * CKEditor plugin용 json 생성 (서버 내 이미지를 보여주는 브라우저 - imagebrowser)
	 * 폴더 내(하위 폴더 포함) 이미지들의 URL을 CKeditor형태에 맞게 JSON형태로 return
	 * @param folderPath /resource/부터의 경로
	 * @author SooAn
	 * @return
	 */
	@RequestMapping(value = "/async/ImageFiles/json/listAjax.do")
	@ResponseBody
	public JSONArray CKeditor_imageBrowserList_JSON(String folderPath){
		JSONArray jarr = new JSONArray();
		
		//혹시 모를 보안문제에 대비 폴더 강제입력
		folderPath = "/resources/img/";
		
		jarr = CKJsonImgList( jarr, folderPath );
		
		return jarr;
	}
	
	
	public JSONArray CKJsonImgList( JSONArray jarr, String folderPath ){
		//업로드 경로 조립 - upload폴더 경로에서 루트resource 경로가져옴
		String uploadPath = propertiesService.getString("FilePath").replace("resources/upload/", "");
		String folderFullPath = uploadPath + folderPath;
				
		JSONObject jobj = null;
		
		try {
			File clsFolder = new File( folderFullPath );
			
			if( clsFolder.exists() == false ) {
			    System.err.println( "folder is not found" );
			} else {
			    File [] arrFile = clsFolder.listFiles();
			    
			    /* ROOT 폴더를 위한 1번째 for문.
			     * 이미지 브라우저 내에서
			     * ROOT부터 순차표시하기 위한 정렬을 위해 동일한 for문 2번 돌림 
			    */
			    for( int i = 0; i < arrFile.length; ++i ) {
			    	/* ROOT 폴더 */
			    	if( !arrFile[i].isDirectory() ){
			    		String subDirAbsPath = arrFile[i].getCanonicalPath().toString();
			    		String subDirRelPath = subDirAbsPath.substring( subDirAbsPath.indexOf("resources")-1 );

			    		String[] subDirRelDir2 = subDirRelPath.split("\\\\"); // 파일명 제외 경로
			    		if( subDirRelDir2.length < 2 ){  // URL패턴일 경우  - 실서버
			    			subDirRelDir2 = subDirRelPath.split("/");
			    		}

			    		String mimeType = null;
			    		try {
			    			Tika tika = new Tika();
			    			mimeType = tika.detect(arrFile[i]);
			    			if( mimeType.indexOf("image") >= 0 ){
			    				jobj = new JSONObject();
			    				jobj.put("image", subDirRelPath);
			    				jobj.put("thumb", subDirRelPath);
			    				String lastFolderName = subDirRelDir2[subDirRelDir2.length-2]; // 파일의 마지막 폴더명
			    				
			    				// ROOT의 이미지는 폴더X - (!)images 폴더가 ROOT일 경우만.
			    				if( lastFolderName.toUpperCase().equals("IMAGES") ){
			    					jobj.put("folder", "기본" );
			    				}else{
			    					jobj.put("folder", subDirRelDir2[subDirRelDir2.length-2] );
			    				}
			    				jarr.put(jobj);
			    			}
			    		} 
			    		catch (Exception e) {
			    			System.out.println("예외 발생");
			    			System.err.println("ckeditorJSON - tika error 오류 - 내부");
			    		}
			    	}
			    }

			    
			    for( int i = 0; i < arrFile.length; ++i ) {
			    	/* 하위폴더 */
			    	if( arrFile[i].isDirectory() ){
			    		String subDirAbsPath = arrFile[i].getCanonicalPath().toString();
			    		String subDirRelPath = subDirAbsPath.substring( subDirAbsPath.indexOf("resources")-1 );
			    		CKJsonImgList( jarr, subDirRelPath );
			    	}
			    }
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("예외 발생");
			System.err.println("ckeditorJSON - tika error 오류 - 외부");

		}
		
		
		return jarr;
		
	}
	
	/**
	 * 네이버 스마트에디터2 파일 업로드
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/async/file_uploader_html5/insertAjax.do")
	@ResponseBody
	public String file_uploader_html5(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		
		//파일정보     
	    String sFileInfo = "";     
	    //파일명을 받는다 - 일반 원본파일명     
	    String filename = request.getHeader("file-name");     
	    filename = URLDecoder.decode(filename, "utf-8");

	    //파일 확장자     
	    String filename_ext = filename.substring(filename.lastIndexOf(".")+1);     
	    //확장자를소문자로 변경     
	    filename_ext = filename_ext.toLowerCase();           
	    //이미지 검증 배열변수     
	    String[] allow_file = {"jpg","png","bmp","gif"};
	   
	   
	    //돌리면서 확장자가 이미지인지      
	    int cnt = 0;     
	    for(int i=0; i < allow_file.length; i++)      
		   if(filename_ext.equals(allow_file[i])) cnt++;
	    
	    
	    //이미지가 아님     
	    if(cnt == 0) {      
		   return "NOTALLOW_"+filename;
	    }else{     
		   //이미지이므로 신규 파일로 디렉토리 설정 및 업로드    
		   sFileInfo = FileUploadTools.FileUploadWithSMARTEDITOR(request,filename);
		   
		   return sFileInfo;
	    }
	    
	    
	    
	}
	
	
}
