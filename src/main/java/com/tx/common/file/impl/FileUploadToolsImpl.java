package com.tx.common.file.impl;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.nio.channels.FileChannel;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.tika.Tika;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tx.common.common.SettingData;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.CMYKConverter;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileMain;
import com.tx.common.file.dto.FileSub;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @FileUploadTools
 * @Service : FileUploadTools
 * 공통기능의 파일 업로드를 관리 하는 툴 클래스 
 * @author 신희원
 * @version 1.0
 * @since 2014-11-12
 */

@Service("FileUploadTools")
public class FileUploadToolsImpl extends EgovAbstractServiceImpl implements FileUploadTools{
	
	private static final Logger logger = LoggerFactory.getLogger(FileUploadToolsImpl.class);
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	
	/** CMYKConverter */
	@Autowired CMYKConverter CMYKConverter;
	
	
	//하나의 폴더당 내부 파일의 개수
	final private int FOLDER_FILE_CNT = 100;
	
	
	
	
	/**
	 * 파일 업로드 + 리사이즈
	 * @param beforeFile
	 * @param REGNM
	 * @param FM_KEYNO 
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	@Override
	public FileSub FileUploadWithFile(File beforeFile, String REGNM, String FM_KEYNO) throws Exception {
		// TODO Auto-generated method stub
		
		
		 //프로퍼티 경로 불러오기
		   String propertiespath = propertiesService.getString("FilePath");
		   
		   FileSub FileSub = new FileSub();
			
		   String filename = beforeFile.getName();
		   
			//확장자
			String FS_EXT =  filename.substring(filename.lastIndexOf(".")+1);
			//원본파일명
			String FS_ORINM = filename;
			//파일사이즈
			String FS_SIZE  = beforeFile.length() +"";
			
			//변경 파일명
			String FS_CHANGENM = setfilename();
			
			String thumbnail = FS_CHANGENM + "_thumbnail";
			
			FileSub.setFS_FM_KEYNO(FM_KEYNO);
			FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
			FileSub.setFS_FOLDER(SaveFolder(propertiespath));
			
			/** 경로 설정 */
			String uploadPath = propertiespath + FileSub.getFS_FOLDER();
			
		   //파일 기본경로     
		   //파일 기본경로 _ 상세경로     
		   File file = new File(uploadPath);     
		   if(!file.exists()) {      
			   file.mkdirs();     
		   }     
		   String rlFileNm = uploadPath + FS_CHANGENM+"."+FS_EXT;
		   
		   FileInputStream inputStream = null;
		   FileOutputStream outputStream = null;
		   FileChannel fcin = null;
		   FileChannel fcout = null;
		   
		   try{
			  
			   inputStream = new FileInputStream(beforeFile);        
			   outputStream = new FileOutputStream(rlFileNm);
			     
			   fcin =  inputStream.getChannel();
			   fcout = outputStream.getChannel();
			     
			   long size = fcin.size();
			   fcin.transferTo(0, size, fcout);
			     
			   fcout.close();
			   fcin.close();
			     
			   outputStream.close();
			   inputStream.close();
			   
			   /** 리사이즈 */
			    String mobileFilePath = uploadPath + FilenameUtils.getName( thumbnail + "." + FS_EXT);
			    ImgResize(rlFileNm, mobileFilePath, FS_EXT, SettingData.DEFAULT_IMG_RESIZE_WIDTH, SettingData.DEFAULT_IMG_RESIZE_HEIGHT);
				   
		   }catch(Exception e){
			   FileSub.setFS_KEYNO("");
			   return FileSub;
		   }finally {
			   if(fcout != null){
				   fcout.close();
			   }
			   if(fcin != null){
				   fcin.close();
			   }
			   if(outputStream != null){
				   outputStream.close();
			   }
			   if(inputStream != null){
				   inputStream.close();
			   }
		   }
		   
		 //파일 정보 저장
			FileSub.setFS_FILE_SIZE(FS_SIZE);
			FileSub.setFS_EXT(FS_EXT);
			FileSub.setFS_ORINM(FS_ORINM);
			FileSub.setFS_CHANGENM(FS_CHANGENM);
			FileSub.setFS_THUMBNAIL(thumbnail);
			FileSub.setFS_REGNM(REGNM);
			FileSub.setFS_ALT(FS_ORINM);
			Component.createData("File.AFS_FileInfoInsert", FileSub);
			return FileSub;
			
		   
	}
	
	/**
	 * 메뉴 xml 파일 업로드
	 * @param beforeFile
	 * @param REGNM
	 * @param FM_KEYNO 
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	@Override
	public FileSub FileUploadByXML(String filename, String filepath, String REGNM) throws Exception {
		// TODO Auto-generated method stub
		
		String FM_KEYNO = makeFileMainData(REGNM);
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		
		FileSub FileSub = new FileSub();
		
		File beforeFile = new File(filepath);
		
		//확장자
		String FS_EXT =  filename.substring(filename.lastIndexOf(".")+1);
		//원본파일명
		String FS_ORINM = filename;
		//파일사이즈
		String FS_SIZE  = beforeFile.length() +"";
		
		//변경 파일명
		String FS_CHANGENM = setfilename();
		
		String thumbnail = FS_CHANGENM + "_thumbnail";
		
		FileSub.setFS_FM_KEYNO(FM_KEYNO);
		FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
		FileSub.setFS_FOLDER(SaveFolder(propertiespath));
		
		/** 경로 설정 */
		String uploadPath = propertiespath + FileSub.getFS_FOLDER();
		
		//파일 기본경로     
		//파일 기본경로 _ 상세경로     
		File file = new File(uploadPath);     
		if(!file.exists()) {      
			file.mkdirs();     
		}     
		String rlFileNm = uploadPath + FS_CHANGENM+"."+FS_EXT;
		
		FileInputStream inputStream = null;
		FileOutputStream outputStream = null;
		FileChannel fcin = null;
		FileChannel fcout = null;
		
		try{
			
			inputStream = new FileInputStream(filepath);        
			outputStream = new FileOutputStream(rlFileNm);
			
			fcin =  inputStream.getChannel();
			fcout = outputStream.getChannel();
			
			long size = fcin.size();
			fcin.transferTo(0, size, fcout);
			
			fcout.close();
			fcin.close();
			
			outputStream.close();
			inputStream.close();
			
		}catch(Exception e){
			FileSub.setFS_KEYNO("");
			return FileSub;
		}finally {
			if(fcout != null){
				fcout.close();
			}
			if(fcin != null){
				fcin.close();
			}
			if(outputStream != null){
				outputStream.close();
			}
			if(inputStream != null){
				inputStream.close();
			}
		}
		
		//파일 정보 저장
		FileSub.setFS_FILE_SIZE(FS_SIZE);
		FileSub.setFS_EXT(FS_EXT);
		FileSub.setFS_ORINM(FS_ORINM);
		FileSub.setFS_CHANGENM(FS_CHANGENM);
		FileSub.setFS_THUMBNAIL(thumbnail);
		FileSub.setFS_REGNM(REGNM);
		FileSub.setFS_ALT(FS_ORINM);
		Component.createData("File.AFS_FileInfoInsert", FileSub);
		return FileSub;
		
		
	}
	
	/**
	 * 네이버 스마트에디터2 용 파일 업로드
	 * @param request
	 * @param filename
	 * @return
	 * @throws Exception
	 */
	@Override
	public String FileUploadWithSMARTEDITOR(HttpServletRequest request, String filename) throws Exception {
		// TODO Auto-generated method stub
			
		   String sFileInfo = "";
		   
		 //프로퍼티 경로 불러오기
		   String propertiespath = propertiesService.getString("FilePath");
		   
		   FileSub FileSub = new FileSub();
			
			//확장자
			String FS_EXT =  filename.substring(filename.lastIndexOf(".")+1);
			//원본파일명
			String FS_ORINM = filename;
			//파일사이즈
			String FS_SIZE = request.getHeader("file-size");
			//변경 파일명
			String FS_CHANGENM = setfilename();
			
			FileSub.setFS_FM_KEYNO("SMARTADMIN2");
			FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
			FileSub.setFS_FOLDER(SaveFolder(propertiespath));
			
			/** 경로 설정 */
			String uploadPath = propertiespath + FileSub.getFS_FOLDER();
			
		   //파일 기본경로     
		   //파일 기본경로 _ 상세경로     
		   File file = new File(uploadPath);     
		   if(!file.exists()) {      
			   file.mkdirs();     
		   }     
		   String rlFileNm = uploadPath + FS_CHANGENM+"."+FS_EXT;     
		   ///////////////// 서버에 파일쓰기 /////////////////      
		   InputStream is = request.getInputStream();     
		   OutputStream os=new FileOutputStream(rlFileNm);     
		   int numRead;     
		   byte b[] = new byte[Integer.parseInt(FS_SIZE)];     
		   while((numRead = is.read(b,0,b.length)) != -1){      
			   os.write(b,0,numRead);     
		   }     
		   if(is != null) {      
			   is.close();     
		   }     
		   os.flush();     
		   os.close(); 
		   
		   // 정보 출력     
		   sFileInfo += "&bNewLine=true";     
		   // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함     
		   sFileInfo += "&sFileName="+ filename;    
		   
		   String fileUrl = "";
		   if(rlFileNm.indexOf("/resources/") != -1){
			   fileUrl = rlFileNm.substring(rlFileNm.indexOf("/resources/"));
		   }else{ // upload 실제 경로 변경시 셋팅
			   fileUrl = "/resources/img/"+ rlFileNm.substring(rlFileNm.indexOf("/upload/"));
		   }
		   
		 //파일 정보 저장
			FileSub.setFS_FILE_SIZE(FS_SIZE);
			FileSub.setFS_EXT(FS_EXT);
			FileSub.setFS_ORINM(FS_ORINM);
			FileSub.setFS_CHANGENM(FS_CHANGENM);
			FileSub.setFS_ALT(FS_ORINM); //파일명을 임시 ALT값으로 사용
			
			String menuName = request.getHeader("menuName");     
			menuName = URLDecoder.decode(menuName, "utf-8");
			
			sFileInfo += "&sFileURL=" + fileUrl;
			
			FileSub.setFS_REGNM("SMARTEDITOR :: " + menuName);
			Component.createData("File.AFS_FileInfoInsert", FileSub);
		   
		   
		return sFileInfo;
	}
	
	
	@Override
	public FileSub FileUpload(MultipartFile file, String FS_FM_KEYNO, String REGNM,boolean isResize) {
		
		if(isResize){
			return FileUpload(file, FS_FM_KEYNO, REGNM, SettingData.DEFAULT_IMG_RESIZE_WIDTH, SettingData.DEFAULT_IMG_RESIZE_HEIGHT);
		}else{
			return FileUpload(file, REGNM, new FileSub(FS_FM_KEYNO, null));
		}
		
		
	}

	@Override
	public FileSub FileUpload(MultipartFile file, String FS_FM_KEYNO, String REGNM, int width, int height) {
		return FileUpload(file, REGNM, new FileSub(FS_FM_KEYNO, null).IS_RESIZE().RESIZE_WIDTH(width).RESIZE_HEIGHT(height));
	}

	/**
	 * 하나의 파일을 업로드 한다.
	 * + 리사이즈
	 * @param request 요청
	 * @param FS_FM_KEYNO 메인코드 키
	 * @param REGNM 등록자
	 * @param fsVO 수정 분기를 위한 FS_KEYNO, 그 외 등록/수정에 이미지 리사이징, 썸네일 생성 등의 정보 전달용 DTO
	 * @throws Exception
	 * 관리자 : 파일관리용
	 * FileUpload(MultipartFile file, String FS_FM_KEYNO, String REGNM,int width,int height)에서 파생
	 */
	@Override
	public FileSub FileUpload(MultipartFile file, String REGNM, FileSub fsVO) {
		
		if( fsVO == null ) fsVO = new FileSub();
		
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		
		FileSub FileSub = new FileSub();
		boolean isUpdate = false; 
		/* 수정or신규 여부 확인 */
		if( fsVO != null && StringUtils.isNotEmpty(fsVO.getFS_KEYNO()) ){
			FileSub = Component.getData("File.AFS_SubFileDetailselect", fsVO);
			if( FileSub != null ){
				isUpdate = true;
			}
		}
		
		//확장자
		String FS_EXT = "";
		//원본파일명
		String FS_ORINM = "";
		//파일사이즈
		String FS_SIZE = "";
		//변경 파일명
		String FS_CHANGENM = "";
		
		//경로 설정
		String uploadPath = "";
		String filePath = "";
		
		FileSub.setFS_FM_KEYNO(fsVO.getFS_FM_KEYNO());
		
		//파일 처리
		if( file != null && file.getOriginalFilename() != null && !file.getOriginalFilename().equals("") ){
			/** 원본파일명 취득 */
			FS_ORINM = file.getOriginalFilename();
			/** 확장자 취득 */
			FS_EXT = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1, file.getOriginalFilename().length());
			if(StringUtils.isNotEmpty(FS_EXT)){
				FS_EXT = FS_EXT.toLowerCase();
			}
			/** 사이즈 취득 */
			FS_SIZE = Long.toString(file.getSize());
			
			
			try {
				
					//수정
				if( isUpdate ){
					//수정 프로세스1 : 기존 경로와 파일명, 확장자를 사용한다.
					/*FS_CHANGENM = FileSub.getFS_CHANGENM();
					uploadPath = propertiespath + FileSub.getFS_FOLDER();
					FS_EXT = FileSub.getFS_EXT();*/
					FileSub.setFS_FOLDER(SaveFolder(propertiespath));
					/** 파일명 변환 후 저장*/
					FS_CHANGENM = setfilename();
					uploadPath = propertiespath + FileSub.getFS_FOLDER();
					//신규등록
				}else{
					FileSub.setFS_FOLDER(SaveFolder(propertiespath));
					/** 파일명 변환 후 저장*/
					FS_CHANGENM = setfilename();
					uploadPath = propertiespath + FileSub.getFS_FOLDER();
					
				}
				
				/** 원본 업로드 */
				filePath = uploadPath + FilenameUtils.getName(FS_CHANGENM + "." + FS_EXT);
				File newFile = new File(filePath);
				file.transferTo(newFile);

				if( isImageFile(newFile) ){
					
					Image imgSrc;
					try {
						imgSrc = ImageIO.read(newFile);
					} catch (Exception e) {
						System.out.println("#51 파일 저장중 에러!!  >> 나던거 처리 ");
						imgSrc = com.tx.migration.controller.CMYKConverter.readImage(newFile);
					}
					
					FileSub.setFS_ORIWIDTH(imgSrc.getWidth(null));
					FileSub.setFS_ORIHEIGHT(imgSrc.getHeight(null));
					
					/** 이미지 리사이즈  */
					if( fsVO.getIS_RESIZE() ){
						ImgResize(filePath, filePath, FS_EXT, fsVO.getRESIZE_WIDTH(), fsVO.getRESIZE_HEIGHT() );
					}
					
					/** 이미지 썸네일 생성(리사이즈 기본)  */
					if( fsVO.getIS_MAKE_THUMBNAIL() ){
						String thumbFileName = FS_CHANGENM +"_thumbnail";
						String thumbFilePath = uploadPath + FilenameUtils.getName( thumbFileName + "." + FS_EXT);
						int thumbWidth = fsVO.getTHUMB_WIDTH();
						int thumbHeight = fsVO.getTHUMB_HEIGHT();
						
						//수정 프로세스2 : 기존 썸네일의 width/height를 사용한다.
						/*if( thumbWidth == 0 && thumbHeight == 0 ){
							if( isUpdate && StringUtils.isNotEmpty(fsVO.getFS_THUMBNAIL()) ){
								Image thumbImgSrc = ImageIO.read(new File(thumbFilePath));
								thumbWidth = thumbImgSrc.getWidth(null);
								thumbHeight = thumbImgSrc.getHeight(null);
							}
						}*/
						
						Image resizedImg = ImgResize(filePath, thumbFilePath, FS_EXT, thumbWidth, thumbHeight);
						if( resizedImg != null ){
							FileSub.setFS_THUMBNAIL(thumbFileName);
						}
						
					}
					
				}else{
					FileSub.setFS_ORIWIDTH(0);
					FileSub.setFS_ORIHEIGHT(0);
					FileSub.setFS_THUMBNAIL(null);
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("#51 파일 저장중 에러!!");
				e.printStackTrace();
			}
			//파일 정보 저장
			FileSub.setFS_FILE_SIZE(FS_SIZE);
			FileSub.setFS_EXT(FS_EXT);
			FileSub.setFS_ORINM(FS_ORINM);
			FileSub.setFS_CHANGENM(FS_CHANGENM);
		}
		FileSub.setFS_REGNM(REGNM);
		
		
		/* 뷰페이지에서 넘어온 FileSub 데이터 세팅 - FS_ALT, FS_COMMENTS */
		if( StringUtils.isNotEmpty(fsVO.getFS_ALT()) ){
			FileSub.setFS_ALT(fsVO.getFS_ALT());
		}
		if( StringUtils.isNotEmpty(fsVO.getFS_COMMENTS()) ){
			FileSub.setFS_COMMENTS(fsVO.getFS_COMMENTS());
		}
		
		/*
		 * 신규 등록이 아닌 기존파일 교체를 위한 프로세스 3. - DB데이터 갱신 : 등록자, 파일용량, 원본파일명 등
		 */
		if( isUpdate ){ //수정
			Component.updateData("FileManage.AFS_FileUpdateData", FileSub);
			
		}else{ //신규
			FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
			Component.createData("File.AFS_FileInfoInsert", FileSub);
		}
		
		return FileSub;
		
	}
	
	/**
	 * favicon.ico 업로드
	 * @param thumbnail
	 * @param hm_TILES
	 * @return
	 */
	@Override
	public String FaviconUpload(MultipartFile file, String tiles) throws Exception {
		
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("resourcePath") + "favicon/";
		
		File saveFolder = new File(propertiespath);
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		propertiespath += tiles;
		
		saveFolder = new File(propertiespath);
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}
		
		String filePath = propertiespath + "/favicon.ico";
		
		try {
			file.transferTo(new File(filePath));
			
			
		} catch (Exception e) {
			// TODO: handle exception
				System.out.println("파일 저장중 에러!!");
				return "";
		}
		
		return filePath.substring(filePath.indexOf("/resources"));
		
	}
	
	@Override
	public FileSub FileUpload(HttpServletRequest request, String REGNM, FileSub fsParam) {
		return FileUploadNthFile(request, REGNM, -1, fsParam, false);
		//주의 : 4번째 FileSub Option 파라미터가 들어갈 경우 request 내 모든 파일의 정보를 갈음하게 됨
	}
	
	public FileSub resizeFileUpload(HttpServletRequest request,
			String FS_FM_KEYNO, String REGNM, int cnt, int width, int height)
			throws Exception {
		FileSub fileOpt = new FileSub();
		fileOpt.setFS_FM_KEYNO(FS_FM_KEYNO);
		fileOpt.IS_RESIZE().RESIZE_WIDTH(width).RESIZE_HEIGHT(height);
		
		return FileUploadNthFile(request, REGNM, cnt, fileOpt, false);
	}
	
	@Override
	public FileSub resizeFileUpload(HttpServletRequest request,
			String FS_FM_KEYNO, String addFM_WHERE_KEY, String FM_COMMENTS, String REGNM, int cnt, int width, int height, boolean isThumbnail)
					throws Exception {
		FileSub fileOpt = new FileSub();
		fileOpt.setFS_FM_KEYNO(FS_FM_KEYNO);
		fileOpt.setFM_WHERE_KEYS(addFM_WHERE_KEY);
		fileOpt.setFM_COMMENTS(FM_COMMENTS);
		fileOpt.IS_RESIZE().RESIZE_WIDTH(width).RESIZE_HEIGHT(height);
		
		return FileUploadNthFile(request, REGNM, cnt, fileOpt, isThumbnail);
	}
	
	/**
 	 * 다중 파일을 업로드 하며 함께 전달된 FileSub 리스트의 내용을 주입한다.
 	 * @param request 요청 - 다중 파일 및 그에 수반하는 더즁 파라미터들을 전달
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @param count 몇번 째 파일을 업로드 할 것인지 ( -1 : 모든 파일 )
 	 * @param fsParam 컨트롤러에서 주입하는 데이터를 담는 DTO.
 	 * - IS_RESIZE, RESIZE_WIDTH, RESIZE_HEIGHT (리사이즈 여부 및 크기)
 	 * - IS_MAKE_THUMBNAIL, THUMB_WIDTH, THUMB_HEIGHT (썸네일 생성 여부 및 리사이즈 크기)
 	 * - FS_KEYNO (파일 교체 및 수정을 원할 경우 전달)
 	 * - FS_FM_KEYNO (부모키 FM_KEYNO)
 	 *  리사이징/썸네일 생성 여부 및 가로세로 크기 값 등. 수정을 위한 FS_KEYNO는 count가 -1이 아닌 경우에만 사용 가능
 	 * @throws Exception
 	 * @return 마지막 업로드 된 파일의 FileSub 객체
 	 */
	@Override
	public FileSub FileUploadNthFile(HttpServletRequest request, String REGNM, int count, FileSub fsParam, boolean isThumbnail) {

		FileSub fileSub = new FileSub();
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		List<FileSub> fsList = getFileSubList(request, files.size(), count, isThumbnail); //다중 파라미터 FS_ALT, FS_COMMENTS를 List로
		int fsIdx = 0; //list index
		int fileCount = 1; //request 내 파일 카운트
		int fsListSize = fsList.size();
		
		/** 파일 저장 처리 */  
		while (itr.hasNext()){
			Entry<String, MultipartFile> entry = itr.next();
			if( count == -1 || count == fileCount ){
				MultipartFile file = entry.getValue();
				
				FileSub fsVO = new FileSub();
				if( file != null ){
					//FileSub 배열 정보값 주입
					if( fsIdx < fsListSize ){
						fsVO = fsList.get(fsIdx);
					}
					
					//객체로 전달받은 param 주입 - request로부터 받은 param보다 우선순위 낮음.
					if( fsParam != null ){
						
						//모든 파일 정보를 하나의 DTO로 갈음하는 것 방지
						if( count != -1 ){
							//옵션으로 FS_KEYNO 전달 : 파일 변경
							if( StringUtils.isEmpty(fsVO.getFS_KEYNO()) ){
								fsVO.setFS_KEYNO(fsParam.getFS_KEYNO());
							}
						}
						
						//FileMain
						if( StringUtils.isEmpty(fsVO.getFS_FM_KEYNO()) ){
							fsVO.setFS_FM_KEYNO(fsParam.getFS_FM_KEYNO());
						}
						if( StringUtils.isEmpty(fsVO.getFM_WHERE_KEYS()) ){
							fsVO.setFM_WHERE_KEYS(fsParam.getFM_WHERE_KEYS());
						}
						if( StringUtils.isEmpty(fsVO.getFM_COMMENTS()) ){
							fsVO.setFM_COMMENTS(fsParam.getFM_COMMENTS());
						}
						//리사이징/썸네일 생성
						if( fsVO.getIS_RESIZE() == false ){
							fsVO
							.RESIZE_WIDTH(fsParam.getRESIZE_WIDTH())
							.RESIZE_HEIGHT(fsParam.getRESIZE_HEIGHT())
							.setIS_RESIZE(fsParam.getIS_RESIZE());
						}
						if( fsVO.getIS_MAKE_THUMBNAIL() == false ){
							fsVO
							.THUMB_WIDTH(fsParam.getTHUMB_WIDTH())
							.THUMB_HEIGHT(fsParam.getTHUMB_HEIGHT())
							.setIS_MAKE_THUMBNAIL(fsParam.getIS_MAKE_THUMBNAIL());
						}
					}
					//메인코드 실재 확인 및 신규등록 처리 - FM_WHERE_KEYS, FM_COMMENTS 주입
					fsVO.setFS_FM_KEYNO(updateFileMain(fsVO.getFS_FM_KEYNO(), fsVO, REGNM));
					fileSub = FileUpload(file, REGNM, fsVO);
				}
			}
			fsIdx++;
			fileCount++;
		}
		
		return fileSub;
		
	}
	
	
	/**
	 * 리사이즈 
 	 * 순번에 따른 파일을 업로드 한다.
 	 * SettingData 내 리사이징 기본값을 따른다.
 	 * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @throws Exception
 	 */
	@Override
	public FileSub imageUploadNthFileWithDefaultResizing(HttpServletRequest request, String REGNM, int cnt) throws Exception {
		return FileUploadNthFile(request, REGNM, cnt, new FileSub().IS_RESIZE()
					.RESIZE_WIDTH(SettingData.DEFAULT_IMG_RESIZE_WIDTH), false)
					.RESIZE_HEIGHT(SettingData.DEFAULT_IMG_RESIZE_HEIGHT);
	}
	
	@Override
	public FileSub FileUploadWithDefaultThumb(HttpServletRequest request, String FS_FM_KEYNO, String REGNM) throws Exception {
		return FileUploadNthFile(request, REGNM, -1, new FileSub(FS_FM_KEYNO, null).IS_MAKE_THUMBNAIL()
				.THUMB_WIDTH(SettingData.DEFAULT_IMG_THUMBNAIL_RESIZE_WIDTH), false)
				.THUMB_WIDTH(SettingData.DEFAULT_IMG_THUMBNAIL_RESIZE_HEIGHT);
	}
	
	/**
 	 * ckeditor업로드
 	 * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @throws Exception
 	 */
	@Override
	public FileSub ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile file, String REGNM) {
		 
		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		
		FileSub FileSub = new FileSub();
		
		//확장자
		String FS_EXT = "";
		//원본파일명
		String FS_ORINM = "";
		//파일사이즈
		String FS_SIZE = "";
		//변경 파일명
		String FS_CHANGENM = "";
		
		//썸네일 이름
		String thumbnail = "";
		
		FileSub.setFS_FM_KEYNO("CKEDITOR4");
		FileSub.setFS_FOLDER(SaveFolder(propertiespath));
		
		/** 경로 설정 */
		String uploadPath = propertiespath + FileSub.getFS_FOLDER();
		
		/** 폴더 생성 */ 
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		
		/** 파일 저장 처리 */  
		while (itr.hasNext()){
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")){
				/** 원본파일명 취득 */
				FS_ORINM = file.getOriginalFilename();
				/** 확장자 취득 */
				FS_EXT = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1, file.getOriginalFilename().length());
				/** 사이즈 취득 */
				FS_SIZE = Long.toString(file.getSize());
				/** 파일명 변환 후 저장*/
				FS_CHANGENM = setfilename();
				String filePath = uploadPath + FilenameUtils.getName(FS_CHANGENM + "." + FS_EXT);
				try {
					file.transferTo(new File(filePath));
					
					/** 리사이즈 */
				    thumbnail = FS_CHANGENM +"_thumbnail";
				    String mobileFilePath = uploadPath + FilenameUtils.getName( thumbnail + "." + FS_EXT);
				    ImgResize(filePath, mobileFilePath, FS_EXT, SettingData.DEFAULT_IMG_RESIZE_WIDTH, SettingData.DEFAULT_IMG_RESIZE_HEIGHT);
				    
					//파일 정보 저장
					FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
					FileSub.setFS_FILE_SIZE(FS_SIZE);
					FileSub.setFS_EXT(FS_EXT);
					FileSub.setFS_ORINM(FS_ORINM);
					FileSub.setFS_CHANGENM(FS_CHANGENM);
					FileSub.setFS_THUMBNAIL(thumbnail);
					FileSub.setFS_REGNM(REGNM);
					Component.createData("File.AFS_FileInfoInsert", FileSub);
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		
		return FileSub;
		
	}
	
	
	
	/**
 	 * DATA URI 데이터 기반으로 업로드 합니다
 	 * + 리사이즈 처리
 	 * @param imgInfo	해쉬맵으로 uri,title,ext 정보를 담고있음
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @throws Exception
 	 */
	@Override
	public FileSub FileUploadByDataURI(HashMap<String, String> imgInfo, String FS_FM_KEYNO, String REGNM) {
		
		FileMain FileMain = new FileMain();
		FileMain.setFM_KEYNO(FS_FM_KEYNO);
		FileMain.setFM_REGNM(REGNM);
		
		//메인코드 확인 및 등록 처리
		int result = Component.getCount("File.AFM_MainFileChecking", FileMain);
		if(result == 0){
			Component.createData("File.AFM_FileInfoInsert",FileMain);
		}
		
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		
		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
		FileSub.setFS_FM_KEYNO(FS_FM_KEYNO);
		
		String uri = imgInfo.get("uri");
		String title = imgInfo.get("title");
		String ext = imgInfo.get("ext");
		
		//확장자
		String FS_EXT = "";
		//파일사이즈
		String FS_SIZE = "";
		//변경 파일명
		String FS_CHANGENM = "";
		
		//썸네일 이름
		String thumbnail = "";
		
		FileSub.setFS_FOLDER(SaveFolder(propertiespath));
		
		/** 경로 설정 */
		String uploadPath = propertiespath + FileSub.getFS_FOLDER();
	
		
		/** 확장자 취득 */
		FS_EXT = ext;
		/** 파일명 변환 후 저장*/
		FS_CHANGENM = setfilename();
		String filePath = uploadPath + FilenameUtils.getName(FS_CHANGENM + "." + FS_EXT);
		try {
			 byte[] imagedata = DatatypeConverter.parseBase64Binary(uri.substring(uri.indexOf(",") + 1));
			 BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(imagedata));
			 File file = new File(filePath);
		     ImageIO.write(bufferedImage, FS_EXT, file);
			 /** 사이즈 취득 */
		     FS_SIZE = file.length()+"";
		     
		     /** 리사이즈 */
		     thumbnail = FS_CHANGENM +"_thumbnail";
		     String mobileFilePath = uploadPath + FilenameUtils.getName( thumbnail + "." + FS_EXT);
		     ImgResize(filePath, mobileFilePath, FS_EXT, SettingData.DEFAULT_IMG_RESIZE_WIDTH, SettingData.DEFAULT_IMG_RESIZE_HEIGHT);
		} catch (Exception e) {
			// TODO: handle exception
		}
		//파일 정보 저장
		FileSub.setFS_FILE_SIZE(FS_SIZE);
		FileSub.setFS_EXT(FS_EXT);
		FileSub.setFS_ORINM(title + "." + FS_EXT);
		FileSub.setFS_CHANGENM(FS_CHANGENM);
		FileSub.setFS_THUMBNAIL(thumbnail);
		FileSub.setFS_REGNM(REGNM);
		Component.createData("File.AFS_FileInfoInsert", FileSub);	
		
		
			
		return FileSub;
	}

	/**
	 * FS_FM_KEYNO를 통해 유무를 확인하고 없을 시 INSERT
	 * @param fs
	 * @param REGNM
	 * @return FM키 존재할 경우 true
	 */
	private String updateFileMain(String FS_FM_KEYNO, FileSub fs, String REGNM) {
		//FS_KEYNO가 있을 경우(수정프로세스) 부모키를 찾아 리턴
		if( StringUtils.isNotEmpty(fs.getFS_KEYNO()) ){
			HashMap<String,Object> fsResult = Component.getData("FileManage.AFS_FileSelectByKey", fs);
			if( fsResult != null ){
				return fsResult.get("FS_FM_KEYNO").toString();
			}
		}
		
		//FM키 실재 여부를 체크하고 없으면 생성
		FileMain FileMain = new FileMain();
		FileMain.setFM_KEYNO(FS_FM_KEYNO);
		FileMain.setFM_REGNM(REGNM);
		FileMain.setFM_WHERE_KEYS(fs.getFM_WHERE_KEYS());
		FileMain.setFM_COMMENTS(fs.getFM_COMMENTS());
		
		//메인코드 확인 및 등록 처리
		int result = Component.getCount("File.AFM_MainFileChecking", FileMain);
		if(result == 0){
			if( StringUtils.isEmpty(FileMain.getFM_KEYNO()) ){
				FileMain.setFM_KEYNO(CommonService.getTableKey("FM"));
			}
			Component.createData("File.AFM_FileInfoInsert", FileMain);
			
		}else{
			//이미 FM키가 있고 수정할 정보가 있다면 update - FM_WHERE_KEYS는 기존 data에 추가됨
			if( StringUtils.isNotEmpty(fs.getFM_WHERE_KEYS())
					|| StringUtils.isNotEmpty(fs.getFM_COMMENTS()) ){
				String ADD_PK = FileMain.getFM_WHERE_KEYS();
				//기존 FM_WHERE_KEYS에 KEY를 추가
				if( StringUtils.isNotEmpty(ADD_PK) ){
					FileMain oldFm = Component.getData("FileManage.AFM_FileManageDetail", FileMain);
					String FM_WHERE_KEYS = oldFm.getFM_WHERE_KEYS();
					if( StringUtils.isNotEmpty(FM_WHERE_KEYS) ){
						if( FM_WHERE_KEYS.indexOf(ADD_PK) == -1 ){
							FM_WHERE_KEYS = FM_WHERE_KEYS + "," + ADD_PK;
						}
					}else{
						FM_WHERE_KEYS = ADD_PK;
					}
					FileMain.setFM_WHERE_KEYS(FM_WHERE_KEYS);
					Component.updateData("FileManage.AFM_FileUpdateData", FileMain);
				}
			}
		}
		
		return FileMain.getFM_KEYNO();
	}
	
	
	/**
 	 * 이미지 파일 사이즈 변경
 	 * @param Filepath
 	 * @throws Exception
 	 */
 	private Image ImgResize(String Filepath, String newFilepath, String EXT, int width, int height)throws Exception{
 		
 		// 원본 이미지 가져오기
		Image imgSrc = null;
		try{
			imgSrc = ImageIO.read(new File(Filepath));
		}catch(Exception e){
			try{
				imgSrc =  CMYKConverter.readImage(new File(Filepath));
			}catch(Exception e2){
				System.out.println("리사이징을 위한 이미지 읽어오기 에러 : 파일 아님");
				return null;
			}
		}
		
		if( imgSrc == null ){
			System.out.println("리사이징을 위한 이미지 읽어오기 에러 : 이미지파일 아님");
			return null;
		}
		
		if(height == 0){
			height=width * imgSrc.getHeight(null) / imgSrc.getWidth(null);
		}
		
        // 이미지 리사이즈
        // Image.SCALE_DEFAULT : 기본 이미지 스케일링 알고리즘 사용
        // Image.SCALE_FAST    : 이미지 부드러움보다 속도 우선
        // Image.SCALE_SMOOTH  : 속도보다 이미지 부드러움을 우선
        // Image.SCALE_AREA_AVERAGING  : 평균 알고리즘 사용
        Image resizeImage = imgSrc.getScaledInstance(width, height, Image.SCALE_SMOOTH);

        // 새 이미지  저장하기
        BufferedImage newImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = newImage.getGraphics();
        g.drawImage(resizeImage, 0, 0, null);
        g.dispose();
        ImageIO.write(newImage, EXT, new File(newFilepath));
 		
        return resizeImage;
 	}
	
 	/**
 	 * 업로드시 폴더 여부 확인 및 생성
 	 * 2018-07-13 신강철
 	 * 날짜 분류 폴도 추가 
 	 * ex) upload/20180713/1... 2.... 3
 	 * @param Uploadpath
 	 */
	public String SaveFolder(String Uploadpath){
		String folderPath = "";
		String RtnValue = "";
 		File saveFolder = new File(Uploadpath);
		if (!saveFolder.exists() || saveFolder.isFile()) {
				saveFolder.mkdirs();
		}
		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); 
		folderPath = sdf.format(dt).toString()+"/";
		saveFolder = new File(Uploadpath + folderPath);
		if (!saveFolder.exists() || saveFolder.isFile()) {
				saveFolder.mkdirs();
		}
		
		
		File FilegetCnt = new File(Uploadpath + folderPath); 
		String Cntfiles[] = FilegetCnt.list();	
		if(Cntfiles.length == 0){
			File FilesaveFolder = new File(Uploadpath + folderPath + "1/"); 
			if (!FilesaveFolder.exists() || FilesaveFolder.isFile()) {
				FilesaveFolder.mkdirs();  
			}
			RtnValue = folderPath + "1/";
		}else if(Cntfiles.length > 0){
			boolean FolderCheck = false;
			Loop:
			for(int i = 1; i <= Cntfiles.length; i++){
				File CntToT = new File(Uploadpath + folderPath + i +"/"); 
				if(CntToT.list().length < FOLDER_FILE_CNT){
					RtnValue = folderPath + i + "/";
					FolderCheck = true;
					break Loop;
				}
			}
			if(FolderCheck == false){
				RtnValue = folderPath + (Cntfiles.length + 1) + "/";
				File NewFolderCreate = new File( Uploadpath + folderPath + (Cntfiles.length + 1) + "/"); 
				if (!NewFolderCreate.exists() || NewFolderCreate.isFile()) {
					NewFolderCreate.mkdirs();
				}
			}  
		}
		return RtnValue;
 	}
 	
	
	
	/**
	  * 파일 업로드 내부의 고유키 부여
	  * @comment
	  * 2016.04.08. SooAn
	  *  웹에디터에서 이미지의 원활한 수정을 위해서
	  *  100글자에서 10글자로 대폭 축소시킴.
	  *  예측 위험발생가능성 - 폴더 당 최대생성하는 파일갯수 50회 중 1/36^15 의 확률로 발생 추측
	  *  2018.07.12 신강철
	  *  파일명에 현재시간 추가
	  * @return
	  */
	@Override
	public String setfilename(){
		
		Date dt = new Date();
		System.out.println(dt.toString());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		
		String buf = sdf.format(dt).toString() + "_";
		
		SecureRandom rnd =new SecureRandom();
		
		for(int i=0 ; i < 10 ; i++){  
		    if(rnd.nextBoolean()){ 
		        buf +=((char)((int)(rnd.nextInt(26))+97)); 
		    }else{
		        buf+=((rnd.nextInt(10))); 
		    }
		}
       return buf;
	}
	
	/**
	 * 이미지 변경 메소드
	 * @param FS_KEYNO
	 * @param req - FS_KEYNO param 여부에 따라 신규/수정 분기처리, FS_FM_KEYNO, FS_ALT, FS_COMMENTS 등
	 * @param cnt 넘어온 파일 정보중 몇번째 파일인가
	 * @param resize 리사이즈 된 이미지 있는지 여부 
	 * @return
	 * @throws Exception
	 */
	@Override
	public FileSub imageChange(String FS_KEYNO, HttpServletRequest req, String regNm, int cnt, boolean resize, int width, int height, boolean isThumbnail) throws Exception{
		FileSub FileSub = new FileSub();
//		FileSub.setFS_KEYNO(FS_KEYNO);
//		FileSub=Component.getData("File.AFS_SubFileDetailselect", FileSub);
//		String FM_KEY = "";
//		
//		if(FileSub != null){
//			//기존의 이미지 삭제
//			UpdateFileDelete(FS_KEYNO);
//			FM_KEY = FileSub.getFS_FM_KEYNO();
//		}else{
//			FM_KEY = CommonService.getTableKey("FM");
//		}
		
		if(resize && width != 0){ // 리사이즈 한 파일만 저장
			FileSub = FileUploadNthFile(req, regNm, cnt, new FileSub(null, FS_KEYNO).IS_RESIZE()
					.RESIZE_WIDTH(width).RESIZE_HEIGHT(height), isThumbnail);
		}else{ // 리사이즈 안함
			FileSub = FileUploadNthFile(req, regNm, cnt, new FileSub(null, FS_KEYNO), isThumbnail);
		}
		
		return FileSub;
	}
	
	
	/**
	 * 이미지 변경 메소드
	 * @param FS_KEYNO
	 * @param file
	 * @param ID
	 * @return
	 * @throws Exception
	 */
	@Override
	public FileSub imageChange(String FS_KEYNO, MultipartFile file,String ID,boolean isResize) throws Exception{
		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(FS_KEYNO);
		FileSub=Component.getData("File.AFS_SubFileDetailselect", FileSub);
		String FM_KEY = "";
		
		if(FileSub != null){
			//기존의 이미지 삭제
			UpdateFileDelete(FS_KEYNO);
			FM_KEY = FileSub.getFS_FM_KEYNO();
		}else{
			FM_KEY = CommonService.getTableKey("FM");
			
		}
		//새로운 이미지 등록
		FileSub = FileUpload(file, FM_KEY, ID, isResize);
		
		return FileSub;
	}
	
	
	/**
 	 * QR-CODE 업로드
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @throws Exception
 	 */
	@Override
	public FileSub FileUploadByQrcode(BufferedImage bufferedImage, String FS_FM_KEYNO, String REGNM, String FILENAME) {
	
		
		FileMain FileMain = new FileMain();
		FileMain.setFM_KEYNO(FS_FM_KEYNO);
		FileMain.setFM_REGNM(REGNM);
		
		//메인코드 확인 및 등록 처리
		int result = Component.getCount("File.AFM_MainFileChecking", FileMain);
		if(result == 0){
			Component.createData("File.AFM_FileInfoInsert",FileMain);
		}
		
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		
		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
		FileSub.setFS_FM_KEYNO(FS_FM_KEYNO);
		
		String ext = "png";
		
		//확장자
		String FS_EXT = "";
		//파일사이즈
		String FS_SIZE = "";
		//변경 파일명
		String FS_CHANGENM = "";
		
		FileSub.setFS_FOLDER(SaveFolder(propertiespath));
		
		/** 경로 설정 */
		String uploadPath = propertiespath + FileSub.getFS_FOLDER();
	
//		System.out.println("저장처리");
		
		/** 확장자 취득 */
		FS_EXT = ext;
		/** 파일명 변환 후 저장*/
		FS_CHANGENM = setfilename();
		String filePath = uploadPath + FilenameUtils.getName(FS_CHANGENM + "." + FS_EXT);
		try {
			 File file = new File(filePath);
		     ImageIO.write(bufferedImage, FS_EXT, file);
		     
			 /** 사이즈 취득 */
		     FS_SIZE = file.length()+"";
		} catch (Exception e) {
			// TODO: handle exception
		}
		//파일 정보 저장
		FileSub.setFS_FILE_SIZE(FS_SIZE);
		FileSub.setFS_EXT(FS_EXT);
		FileSub.setFS_ORINM(FILENAME + "." + FS_EXT);
		FileSub.setFS_CHANGENM(FS_CHANGENM);
		FileSub.setFS_REGNM(REGNM);
		Component.createData("File.AFS_FileInfoInsert", FileSub);	
		
		
			
		return FileSub;
	}
	
	
	
	
	/**
	 * 업로드 파일 삭제 
	 */
	@Override
	public void UpdateFileDelete(String file) {
		String[] deletefile = file.split(",");
		UpdateFileDelete(deletefile);
		
	}
	
	/**
	 * 업로드 파일 삭제
	 * @param deletefile
	 */
	@Override
	public void UpdateFileDelete(String deletefile[]) {
		String uploadPath = propertiesService.getString("FilePath");
		for(int i=0; i<deletefile.length; i++) {
			FileSub fileSub = new FileSub();
			fileSub.setFS_KEYNO(deletefile[i]);
			//파일삭제처리
			fileSub = Component.getData("File.AFS_SubFileDetailselect", fileSub);
			
			if(fileSub != null){
				String fullPath = uploadPath+fileSub.getFS_FOLDER()+FilenameUtils.getName(fileSub.getFS_CHANGENM()+"."+fileSub.getFS_EXT());
				File dFile = new File(fullPath);
				if(dFile.exists()){
					dFile.delete();
				}
				//DB정보 삭제처리
				Component.deleteData("File.AFS_FileUploadDelete", fileSub);
				
				//썸네일 이미지 유무체크 후 물리삭제 진행
				if( StringUtils.isNotEmpty(fileSub.getFS_THUMBNAIL()) ){
					String thumbFullPath = uploadPath+fileSub.getFS_FOLDER()+FilenameUtils.getName(fileSub.getFS_CHANGENM()+"_thumbnail."+fileSub.getFS_EXT());
					File thumbDFile = new File(thumbFullPath);
					if(thumbDFile.exists()){
						thumbDFile.delete();
					}
					
				}
			}
		}
	}
	
	/**
	 * 업로드 파일 교체
	 * @param deletefile
	 * @return 
	 * jsa
	 */
	public FileSub UpdateFileSub( HttpServletRequest requeset
			, FileSub fileSubNew ) {
		String uploadPath = propertiesService.getString("FilePath");
			FileSub fileSubOld = Component.getData("File.AFS_SubFileDetailselect", fileSubNew);
			
			if(fileSubOld != null){
				String fullPath = uploadPath+fileSubOld.getFS_FOLDER()+FilenameUtils.getName(fileSubOld.getFS_CHANGENM()+"."+fileSubOld.getFS_EXT());
				File dFile = new File(fullPath);
				if(dFile.exists()){
					dFile.delete();
				}
				//DB정보 삭제처리
				Component.deleteData("File.AFS_FileUploadDelete", fileSubOld);
				
				//썸네일 이미지 유무체크 후 물리삭제 진행
				if( StringUtils.isNotEmpty(fileSubOld.getFS_THUMBNAIL()) ){
					String thumbFullPath = uploadPath+fileSubOld.getFS_FOLDER()+FilenameUtils.getName(fileSubOld.getFS_CHANGENM()+"_thumbnail."+fileSubOld.getFS_EXT());
					File thumbDFile = new File(thumbFullPath);
					if(thumbDFile.exists()){
						thumbDFile.delete();
					}
					
				}
			}
			
			return fileSubNew;
		}
	
	/**
	 * 이미지 파일 삭제 
	 * @param deletefile
	 */
	@Override
	public void UpdateFileDelete(List<FileSub> imgList) {
		String uploadPath = propertiesService.getString("FilePath");
		for(int i=0; i<imgList.size(); i++) {
			FileSub fileSub = new FileSub();
			fileSub.setFS_KEYNO(imgList.get(i).getFS_KEYNO());
			//파일삭제처리
			fileSub = Component.getData("File.AFS_SubFileDetailselect", fileSub);
			
			if(fileSub != null){
				String fullPath = uploadPath+fileSub.getFS_FOLDER()+FilenameUtils.getName(fileSub.getFS_CHANGENM()+"."+fileSub.getFS_EXT());
				File dFile = new File(fullPath);
				if(dFile.exists()){
					dFile.delete();
				}
				//DB정보 삭제처리
				Component.deleteData("File.AFS_FileUploadDelete", fileSub);
			}
		}
	}

	@Override
	public String getFileMimeType(File file) throws Exception {
		Tika tika = new Tika();
    String mimetype = "";
    try {
    	mimetype = tika.detect(file);
		} catch (Exception e) {
			mimetype = null;
		}
    
		return mimetype;
	}
	
	@Override
	public String getFileMimeType(String filePath) throws Exception {
		File file = new File(filePath);
		return getFileMimeType(file);
	}

	/**
	 * 넘어온 FS_KEYNO 로 새로운 파일 생성
	 * @param FS_KEYNO
	 * @param fM_KEYNO
	 * @param REGNM
	 * @return
	 * @throws Exception
	 */
	@Override
	public FileSub FileCopy(String FS_KEYNO, String FM_KEYNO, String REGNM) throws Exception {
		// TODO Auto-generated method stub
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
			
		FileSub FileSub = new FileSub();
		FileSub.setFS_KEYNO(FS_KEYNO);
		
		//기존 데이터 불러옴
		FileSub = Component.getData("File.AFS_SubFileDetailselect", FileSub);
		
		//확장자
		String FS_EXT = FileSub.getFS_EXT();
		
		String beforeFilePath = propertiespath + FileSub.getFS_FOLDER() + FilenameUtils.getName(FileSub.getFS_CHANGENM() + "." + FS_EXT); 
		
		//파일사이즈
		String FS_SIZE = "";
		//변경 파일명
		String FS_CHANGENM = "";
		
		//썸네일 이름
		String thumbnail = "";
		
		FileSub.setFS_FOLDER(SaveFolder(propertiespath));
		
		/** 경로 설정 */
		String uploadPath = propertiespath + FileSub.getFS_FOLDER();
	
		/** 파일명 변환 후 저장*/
		FS_CHANGENM = setfilename();
		String filePath = uploadPath + FilenameUtils.getName(FS_CHANGENM + "." + FS_EXT);
		
		File beforeFile = new File(beforeFilePath);
		
		File file = new File(filePath);
		
		FileUtils.copyFile(beforeFile, file);
		
		/** 사이즈 취득 */
		FS_SIZE = file.length()+"";
		 
		/** 리사이즈 */
		thumbnail = FS_CHANGENM +"_thumbnail";
		String mobileFilePath = uploadPath + FilenameUtils.getName( thumbnail + "." + FS_EXT);
		ImgResize(filePath, mobileFilePath, FS_EXT, SettingData.DEFAULT_IMG_RESIZE_WIDTH, SettingData.DEFAULT_IMG_RESIZE_HEIGHT);
		
		//파일 정보 저장
		FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
		FileSub.setFS_FM_KEYNO(FM_KEYNO);
		FileSub.setFS_REGNM(REGNM);
		FileSub.setFS_FILE_SIZE(FS_SIZE);
		FileSub.setFS_CHANGENM(FS_CHANGENM);
		FileSub.setFS_THUMBNAIL(thumbnail);
		Component.createData("File.AFS_FileInfoInsert", FileSub);	
		
		
			
		return FileSub;
	}

	/**
	 * FILE_MAIN 데이터 생성
	 * @return FM_KEYNO
	 */
	@Override
	public String makeFileMainData(String REGNM) throws Exception {
		// TODO Auto-generated method stub
		
		FileMain FileMain = new FileMain();
		FileMain.setFM_KEYNO(CommonService.getTableKey("FM"));
		FileMain.setFM_REGNM(REGNM);
		
		Component.createData("File.AFM_FileInfoInsert",FileMain);
		
		return FileMain.getFM_KEYNO();
	}
	
	
	public boolean isImageFile(File file) throws Exception {
		String mimeType = getFileMimeType(file);
		return mimeType.indexOf("image") > -1;
	}
	
	public boolean isImageFile(String filePath) throws Exception {
		String mimeType = getFileMimeType(filePath);
		return mimeType.indexOf("image") > -1;
	}
	
	
	/**
	 * @param req
	 * @return
	 * List<FileSub> 다중으로 넘어온 개별적인 FS_KEYNO(수정), FS_ALT, FS_COMMENTS
	 */
	@Override
	public List<FileSub> getFileSubInfoList(HttpServletRequest req) {
		List<FileSub> list = new ArrayList<FileSub>();	
		/* 파일 필수 컬럼 */
		String[] fS_ALT = req.getParameterValues("FS_ALT");
		String[] fS_COMMENTS = req.getParameterValues("FS_COMMENTS");
		String[] fS_ORDER = req.getParameterValues("FS_ORDER");
		/* 파일 필수 컬럼 끝 */
		if(fS_ORDER != null){
		int size = fS_ORDER.length;
			if(size > 0){
				//FS_KEYNO를 전송하여 수정을 시도할 경우
				String[] fS_KEYNO = new String[size];
				copyArrayValues( fS_KEYNO, req.getParameterValues("FS_KEYNO") );
				
				for( int i = 0; i < size; i++ ){
					FileSub fs = new FileSub();
					fs.setFS_ALT(fS_ALT[i]);
					fs.setFS_COMMENTS(fS_COMMENTS[i]);
					fs.setFS_KEYNO(fS_KEYNO[i]);
					fs.setFS_ORDER(Integer.parseInt(fS_ORDER[i]));
					list.add(fs);
				}
			}
		}
		
		return list;
	}
	
	/**
	 * 뷰 페이지에서 다중으로 넘어온 개별적인 FileSub 관련 request param을 List로 반환 
	 * @param req - 필수(!) : FS_ALT, FS_COMMENTS, 
	 * @param req - 옵션 : FS_FM_KEYNO, FS_KEYNO(수정), IS_RESIZE(RESIZE_WIDTH, RESIZE_HEIGHT),
	 *  IS_MAKE_THUMBNAIL(THUMB_WIDTH, THUMB_HEIGHT)
	 * @param count 
	 * @param fileLength 
	 * @return List<FileSub>
	 */
	@Override
	public List<FileSub> getFileSubList(HttpServletRequest req, int fileLength, int count, boolean isThumbnail) {

		List<FileSub> list = new ArrayList<FileSub>();		
		int size = 1;
		String[] fS_ALT = null;
		String[] fS_COMMENTS = null;
		if(!isThumbnail){
			/* 파일 필수 컬럼 */
			fS_ALT = req.getParameterValues("FS_ALT");
			fS_COMMENTS = req.getParameterValues("FS_COMMENTS");
			/* 파일 필수 컬럼 끝 */
		}
		
		if( fS_ALT != null && fS_COMMENTS != null ){
			
			//리스트 길이
			size = fS_ALT.length > fS_COMMENTS.length ? fS_ALT.length : fS_COMMENTS.length;
			
			//FileMain
			String[] fS_FM_KEYNO = new String[size];
			copyArrayValues( fS_FM_KEYNO, req.getParameterValues("FS_FM_KEYNO") );
			String[] fM_WHERE_KEYS = new String[size];
			copyArrayValues( fM_WHERE_KEYS, req.getParameterValues("FM_WHERE_KEYS") );
			String[] fM_COMMENTS = new String[size];
			copyArrayValues( fM_COMMENTS, req.getParameterValues("FM_COMMENTS") );
			
			//FS_KEYNO를 전송하여 파일 수정을 시도할 경우
			String[] fS_KEYNO = new String[size];
			copyArrayValues( fS_KEYNO, req.getParameterValues("FS_KEYNO") );
			
			//이미지 리사이징 정보
			String[] IS_RESIZE = new String[size];
			String[] RESIZE_WIDTH = new String[size];
			String[] RESIZE_HEIGHT = new String[size];
			copyArrayValues( IS_RESIZE, req.getParameterValues("IS_RESIZE") );
			copyArrayValues( RESIZE_WIDTH, req.getParameterValues("RESIZE_WIDTH") );
			copyArrayValues( RESIZE_HEIGHT, req.getParameterValues("RESIZE_HEIGHT") );
			
			//썸네일 생성 및 리사이징 정보
			String[] IS_MAKE_THUMBNAIL = new String[size];
			String[] THUMB_WIDTH = new String[size];
			String[] THUMB_HEIGHT = new String[size];
			copyArrayValues( IS_MAKE_THUMBNAIL, req.getParameterValues("IS_MAKE_THUMBNAIL") );
			copyArrayValues( THUMB_WIDTH, req.getParameterValues("THUMB_WIDTH") );
			copyArrayValues( THUMB_HEIGHT, req.getParameterValues("THUMB_HEIGHT") );
			
			
			for( int i = 0; i < size; i++ ){
				FileSub fs = new FileSub();
				fs.setFS_ALT(fS_ALT[i]);
				fs.setFS_COMMENTS(fS_COMMENTS[i]);
				
				fs.setFS_FM_KEYNO(CommonService.getKeyno(fS_FM_KEYNO[i], "FM")); //숫자 키로 넘어온 경우에 대비
				fs.setFS_KEYNO(CommonService.getKeyno(fS_KEYNO[i], "FS")); //숫자 키로 넘어온 경우에 대비
				
				boolean iS_RESIZE = StringUtils.isNotEmpty(IS_RESIZE[i]) ? Boolean.parseBoolean(IS_RESIZE[i]) : false;
				if( iS_RESIZE ){
					int rESIZE_WIDTH = StringUtils.isNotEmpty(RESIZE_WIDTH[i]) ? Integer.parseInt(RESIZE_WIDTH[i]) : SettingData.DEFAULT_IMG_RESIZE_WIDTH;
					int rESIZE_HEIGHT = StringUtils.isNotEmpty(RESIZE_HEIGHT[i]) ? Integer.parseInt(RESIZE_HEIGHT[i]) : SettingData.DEFAULT_IMG_RESIZE_HEIGHT;
					fs.IS_RESIZE().RESIZE_WIDTH(rESIZE_WIDTH).RESIZE_HEIGHT(rESIZE_HEIGHT);
				}
				
				boolean iS_MAKE_THUMBNAIL = StringUtils.isNotEmpty(IS_MAKE_THUMBNAIL[i]) ? Boolean.parseBoolean(IS_MAKE_THUMBNAIL[i]) : false;
				if( iS_MAKE_THUMBNAIL ){
					int tHUMB_WIDTH = StringUtils.isNotEmpty(THUMB_WIDTH[i]) ? Integer.parseInt(THUMB_WIDTH[i]) : SettingData.DEFAULT_IMG_THUMBNAIL_RESIZE_WIDTH;
					int tHUMB_HEIGHT = StringUtils.isNotEmpty(THUMB_HEIGHT[i]) ? Integer.parseInt(THUMB_HEIGHT[i]) : SettingData.DEFAULT_IMG_THUMBNAIL_RESIZE_HEIGHT;
					fs.IS_MAKE_THUMBNAIL().THUMB_WIDTH(tHUMB_WIDTH).THUMB_HEIGHT(tHUMB_HEIGHT);
				}
				list.add(fs);
			}
		}
		
		return list;
		
	}
	
	/**
	 * target배열의 최대 길이까지 source배열의 값을 주입 
	 * @param target
	 * @param source
	 * @return
	 */
	private String[] copyArrayValues( String[] target, String[] source ){
		int targetLen = target != null ? target.length : 0;
		int sourceLen = source != null ? source.length : 0;
		if( targetLen != sourceLen ){
			throw new NullPointerException("다중 파라미터 배열의 길이가 다름");
		}
		for( int i = 0; i < targetLen && i < sourceLen ; i++ ){
			target[i] = new String(source[i]);
		}
		
		return target;
	}
	
	
	/**
	 * 파일 업로드 시 FileMain 정보
	 * @param req
	 * @param fm - FM_KEYNO, FM_WHERE_KEYS(신규or추가), FM_COMMENTS 
	 * @return
	 * @throws Exception
	 */
	public FileMain addWhereKeyUpdateAction(HttpServletRequest req
			,FileMain fm
			) throws Exception{
		
		fm.setFM_REGNM(CommonService.getSessionUserKey(req));
		fm.setFM_KEYNO(CommonService.getKeyno(fm.getFM_KEYNO(), "FM"));
		
		String ADD_PK = fm.getFM_WHERE_KEYS();
		//기존 FM_WHERE_KEYS에 KEY를 추가
		if( StringUtils.isNotEmpty(ADD_PK) ){
			FileMain oldFm = Component.getData("FileManage.AFM_FileManageDetail", fm);
			String FM_WHERE_KEYS = oldFm.getFM_WHERE_KEYS();
			if( StringUtils.isNotEmpty(FM_WHERE_KEYS) ){
				if( FM_WHERE_KEYS.indexOf(ADD_PK) == -1 ){
					FM_WHERE_KEYS = FM_WHERE_KEYS + "," + ADD_PK;
				}
			}else{
				FM_WHERE_KEYS = ADD_PK;
			}
			fm.setFM_WHERE_KEYS(FM_WHERE_KEYS);
		}
		
		Component.updateData("FileManage.AFM_FileUpdateData", fm);
		
		return fm;
	}

	@Override
	public String SaveFolder(String Uploadpath, String uploadNamespace) {
		String folderPath = "";
		String RtnValue = "";
		
		//기능별 업로드폴더 지정 - ex) upload/1/ ==> upload/BIENNALE/1/
		if( StringUtils.isEmpty(uploadNamespace) ){
			uploadNamespace = "default";
		}
		Uploadpath += uploadNamespace + "/";
		
 		File saveFolder = new File(Uploadpath);
		if (!saveFolder.exists() || saveFolder.isFile()) {
				saveFolder.mkdirs();
		}
		
		File FilegetCnt = new File(Uploadpath); 
		String Cntfiles[] = FilegetCnt.list();	
		if(Cntfiles.length == 0){
			File FilesaveFolder = new File(Uploadpath +"1/"); 
			if (!FilesaveFolder.exists() || FilesaveFolder.isFile()) {
				FilesaveFolder.mkdirs();  
			}
			folderPath = Uploadpath +"1/";
			RtnValue = "1/";
		}else if(Cntfiles.length > 0){
			boolean FolderCheck = false;
			Loop:
			for(int i = 1; i <= Cntfiles.length; i++){
				File CntToT = new File(Uploadpath + i +"/");
				System.err.println("#a01 : "+ Uploadpath + i +"/");
				//숫자가 아닌 기타 파일 및 폴더가 있을 경우 예외처리
				if( !CntToT.isDirectory() ){
						CntToT.mkdirs();  
				}
				System.err.println("#a02 : "+ CntToT.list().toString() );
				System.err.println("#a03 : "+ CntToT.list().length );
				if( CntToT.list().length < FOLDER_FILE_CNT){
					
					folderPath = Uploadpath +  i + "/";
					RtnValue = i + "/";
					FolderCheck = true;
					break Loop;
				}
			}
			if(FolderCheck == false){
				folderPath = Uploadpath + (Cntfiles.length + 1) + "/";
				RtnValue = (Cntfiles.length + 1) + "/";
				File NewFolderCreate = new File(folderPath); 
				if (!NewFolderCreate.exists() || NewFolderCreate.isFile()) {
					NewFolderCreate.mkdirs();
				}
			}  
		}
		
		System.err.println("#a04 : uploadNamespace + RtnValue : " + uploadNamespace + RtnValue);
		
		return uploadNamespace + "/" + RtnValue;
	}

	@Override
	public String fileOverlapCheck(String filePath, String fileName) {
		String result = "";
		
		// Create a file object 
		File file = new File(filePath+fileName); 

		String ext =  fileName.substring(fileName.lastIndexOf(".")+1);
		
		String[] fileNameArr = fileName.split("\\.");
		
		int idx = 0; 
		String name = null;
		
		if(fileNameArr.length >= 2){
			idx = fileName.indexOf(ext)-1; 
			name = fileName.substring(0, idx);
		}else{
			name = fileName;
		}
		
		// 1. check if the file exists or not 
		boolean isExists = file.exists(); 
		
		if(isExists){
//			System.out.println("I find the existFile.txt");
			
			for(int i=1; i<=100; i++){
				fileName = name+"("+i+")."+ext;
				file = new File(filePath+fileName);
				isExists = file.exists();
				if(!isExists){
					result = name+"("+i+")";
					break;
				}
			}
		}else{ 
//			System.out.println("No, there is not a no file.");
			result = name;
		}

		return result;
	}
	
	/**
	 * 파일 압축
	 * @param List<FileSub>
	 * @param String
	 * @throws Exception
	 */
	@Override
	@Transactional
	public HashMap<String,Object> FileZip2(ArrayList<String> keylist, String filename)throws Exception {
		byte[] buf = new byte[1024];
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		//압축파일 이름
		String zip_name = filename;
		String uploadPath = "pdf/zip/";
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("filename", filename+".zip");
		map.put("filepath", "pdf/zip/"+filename+".zip");
		
		File saveFolder = new File(propertiespath + uploadPath);
		//경로가 없으면 생성한다.
        if (!saveFolder.exists() || saveFolder.isFile()) {
            saveFolder.mkdirs();
        }
        
		//**알집 하나만**//
		String attachments = propertiespath + uploadPath + zip_name + ".zip";
		
		File ZipFile = new File(attachments);
        //파일이 있으면 삭제(같은 이름으로 만들 때마다 새로 쓰기 위해서)
        if (ZipFile.isFile()) {
        	ZipFile.delete();
         	}
        List<FileSub> files = new ArrayList<>();
        
        for(String FS_KEYNO : keylist) {
			files.add(Component.getData("File.AFS_SubFileDetailselect",FS_KEYNO));
		}
        
		try( ZipOutputStream out = new ZipOutputStream(new FileOutputStream(attachments));) {
			if(files != null) {
				for(FileSub f : files) {
					if(f.getFS_FILE_SIZE() != null) {
						String Path = f.getFS_FOLDER() + f.getFS_CHANGENM() +"." + f.getFS_EXT();
						try( FileInputStream in = new FileInputStream(propertiespath + Path);) {
							ZipEntry ze = new ZipEntry(f.getFS_ORINM());
							out.putNextEntry(ze);
							int len;
							while ((len = in.read(buf)) > 0) {
								out.write(buf, 0, len);
							}
							out.closeEntry();
						} catch (Exception e) {
							e.printStackTrace();
							System.out.println("압축파일에러");
						}
					}
				}
			}
		} catch (IOException e) {
			System.out.println("ZipOutputStream 에러");
		}
		
		return map;	
	}
	
	
	/**
	 * 
	 * @param file
	 * @param REGNM
	 * @param 채용관련 파일 업로드 이름 변경을 위한 처리
	 * @return
	 */
	@Override
	public FileSub FileUpload(MultipartFile file, String REGNM, FileSub fsVO, String type) {
		
		if( fsVO == null ) fsVO = new FileSub();
		
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		
		FileSub FileSub = new FileSub();
		boolean isUpdate = false; 
		/* 수정or신규 여부 확인 */
		if( fsVO != null && StringUtils.isNotEmpty(fsVO.getFS_KEYNO()) ){
			FileSub = Component.getData("File.AFS_SubFileDetailselect", fsVO);
			if( FileSub != null ){
				isUpdate = true;
			}
		}
		
		//확장자
		String FS_EXT = "";
		//원본파일명
		String FS_ORINM = "";
		//파일사이즈
		String FS_SIZE = "";
		//변경 파일명
		String FS_CHANGENM = "";
		
		//경로 설정
		String uploadPath = "";
		String filePath = "";
		
		FileSub.setFS_FM_KEYNO(fsVO.getFS_FM_KEYNO());
		
		//파일 처리
		if( file != null && file.getOriginalFilename() != null && !file.getOriginalFilename().equals("") ){
			/** 원본파일명 취득 */
			FS_ORINM = type + file.getOriginalFilename();
			/** 확장자 취득 */
			FS_EXT = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1, file.getOriginalFilename().length());
			if(StringUtils.isNotEmpty(FS_EXT)){
				FS_EXT = FS_EXT.toLowerCase();
			}
			/** 사이즈 취득 */
			FS_SIZE = Long.toString(file.getSize());
			
			
			try {
				
					//수정
				if( isUpdate ){
					//수정 프로세스1 : 기존 경로와 파일명, 확장자를 사용한다.
					/*FS_CHANGENM = FileSub.getFS_CHANGENM();
					uploadPath = propertiespath + FileSub.getFS_FOLDER();
					FS_EXT = FileSub.getFS_EXT();*/
					FileSub.setFS_FOLDER(SaveFolder(propertiespath));
					/** 파일명 변환 후 저장*/
					FS_CHANGENM = setfilename();
					uploadPath = propertiespath + FileSub.getFS_FOLDER();
					//신규등록
				}else{
					FileSub.setFS_FOLDER(SaveFolder(propertiespath));
					/** 파일명 변환 후 저장*/
					FS_CHANGENM = setfilename();
					uploadPath = propertiespath + FileSub.getFS_FOLDER();
					
				}
				
				/** 원본 업로드 */
				filePath = uploadPath + FilenameUtils.getName(FS_CHANGENM + "." + FS_EXT);
				File newFile = new File(filePath);
				file.transferTo(newFile);

				if( isImageFile(newFile) ){
					
					Image imgSrc;
					try {
						imgSrc = ImageIO.read(newFile);
					} catch (Exception e) {
						System.out.println("#51 파일 저장중 에러!!  >> 나던거 처리 ");
						imgSrc = com.tx.migration.controller.CMYKConverter.readImage(newFile);
					}
					
					FileSub.setFS_ORIWIDTH(imgSrc.getWidth(null));
					FileSub.setFS_ORIHEIGHT(imgSrc.getHeight(null));
					
					/** 이미지 리사이즈  */
					if( fsVO.getIS_RESIZE() ){
						ImgResize(filePath, filePath, FS_EXT, fsVO.getRESIZE_WIDTH(), fsVO.getRESIZE_HEIGHT() );
					}
					
					/** 이미지 썸네일 생성(리사이즈 기본)  */
					if( fsVO.getIS_MAKE_THUMBNAIL() ){
						String thumbFileName = FS_CHANGENM +"_thumbnail";
						String thumbFilePath = uploadPath + FilenameUtils.getName( thumbFileName + "." + FS_EXT);
						int thumbWidth = fsVO.getTHUMB_WIDTH();
						int thumbHeight = fsVO.getTHUMB_HEIGHT();
						
						//수정 프로세스2 : 기존 썸네일의 width/height를 사용한다.
						/*if( thumbWidth == 0 && thumbHeight == 0 ){
							if( isUpdate && StringUtils.isNotEmpty(fsVO.getFS_THUMBNAIL()) ){
								Image thumbImgSrc = ImageIO.read(new File(thumbFilePath));
								thumbWidth = thumbImgSrc.getWidth(null);
								thumbHeight = thumbImgSrc.getHeight(null);
							}
						}*/
						
						Image resizedImg = ImgResize(filePath, thumbFilePath, FS_EXT, thumbWidth, thumbHeight);
						if( resizedImg != null ){
							FileSub.setFS_THUMBNAIL(thumbFileName);
						}
						
					}
					
				}else{
					FileSub.setFS_ORIWIDTH(0);
					FileSub.setFS_ORIHEIGHT(0);
					FileSub.setFS_THUMBNAIL(null);
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("#51 파일 저장중 에러!!");
				e.printStackTrace();
			}
			//파일 정보 저장
			FileSub.setFS_FILE_SIZE(FS_SIZE);
			FileSub.setFS_EXT(FS_EXT);
			FileSub.setFS_ORINM(FS_ORINM);
			FileSub.setFS_CHANGENM(FS_CHANGENM);
		}
		FileSub.setFS_REGNM(REGNM);
		
		
		/* 뷰페이지에서 넘어온 FileSub 데이터 세팅 - FS_ALT, FS_COMMENTS */
		if( StringUtils.isNotEmpty(fsVO.getFS_ALT()) ){
			FileSub.setFS_ALT(fsVO.getFS_ALT());
		}
		if( StringUtils.isNotEmpty(fsVO.getFS_COMMENTS()) ){
			FileSub.setFS_COMMENTS(fsVO.getFS_COMMENTS());
		}
		
		/*
		 * 신규 등록이 아닌 기존파일 교체를 위한 프로세스 3. - DB데이터 갱신 : 등록자, 파일용량, 원본파일명 등
		 */
		if( isUpdate ){ //수정
			Component.updateData("FileManage.AFS_FileUpdateData", FileSub);
			
		}else{ //신규
			FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
			Component.createData("File.AFS_FileInfoInsert", FileSub);
		}
		
		return FileSub;
		
	}
	
}
