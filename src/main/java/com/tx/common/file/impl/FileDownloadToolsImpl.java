package com.tx.common.file.impl;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.tika.Tika;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.tx.common.component.ComponentService;
import com.tx.common.file.FileDownloadTools;
import com.tx.common.file.dto.FileSub;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @FileDownloadTools
 * @Service : FileDownloadTools
 * 공통기능의 다운로드를 관리 하는 툴 클래스 
 * @author 신희원 
 * @version 1.0
 * @since 2014-11-12
 */
@Service("FileDownloadTools")
public class FileDownloadToolsImpl extends EgovAbstractServiceImpl implements FileDownloadTools{
	
	private static final Logger logger = LoggerFactory.getLogger(FileDownloadToolsImpl.class);
	/** 프로퍼티 정보 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /** 공통 컴포넌트 */
	@Autowired ComponentService Component;
    
    /**
     * 브라우저 구분 얻기.
     * 
     * @param request
     * @return
     */
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }  

    /**
     * Disposition 지정하기.
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String browser = getBrowser(request);
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;
	
	if (browser.equals("MSIE")) {
	    encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
	} else if (browser.equals("Firefox")) {
	    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
	} else if (browser.equals("Opera")) {
	    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
	} else if (browser.equals("Chrome")) {
	    StringBuffer sb = new StringBuffer();
	    for (int i = 0; i < filename.length(); i++) {
		char c = filename.charAt(i);
		if (c > '~') {
		    sb.append(URLEncoder.encode("" + c, "UTF-8"));
		} else {
		    sb.append(c);
		}
	    }
	    //크롬 , 있을 시 다운로드 안되는 문제 작업 ""으로 파일명 감싸기
	    encodedFilename = "\"" + sb.toString() + "\"";
	} else {
	    //throw new RuntimeException("Not supported browser");
	    throw new IOException("Not supported browser");
	}
	dispositionPrefix=dispositionPrefix.replaceAll("\r", "").replaceAll("\n", "");
	encodedFilename=encodedFilename.replaceAll("\r", "").replaceAll("\n", "");
	response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)){
		    response.setContentType("application/octet-stream;charset=UTF-8");
		}
    }

    
    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @Override
    public void FileDownload(FileSub FileSub, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	//여긴 파일 다운 횟수
    	Component.updateData("File.AFS_FileDownCouting", FileSub);
    	/** 경로 설정 */
		String uploadPath = propertiesService.getString("FilePath")+ FileSub.getFS_FOLDER(); 
		
	    File uFile = new File(uploadPath, FilenameUtils.getName(FileSub.getFS_CHANGENM() + "." + FileSub.getFS_EXT()));
	    
	    if(uFile.isFile()){
	    	FileDownload(uFile,FileSub.getFS_ORINM(),request,response);
	    }else {
	    	response.setContentType("text/html; charset=UTF-8");
	    	PrintWriter out = response.getWriter();
	    	out.println("<script>alert('파일이 없습니다.'); history.go(-1);</script>");
	    	out.flush();
	    }
    }
    
    /**
     * 파일 다운로드
     * @param file
     * @param name
     * @param request
     * @param response
     * @throws Exception
     */
    @Override
    public void FileDownload(String filepath, String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	/** 경로 설정 */
		String uploadPath = propertiesService.getString("FilePath") + filepath;
	    File uFile = new File(uploadPath);
	    System.out.println(filename);
	    System.out.println(uploadPath);
	    FileDownload(uFile,filename,request,response);
    }
    
    private void FileDownload(File file,String name, HttpServletRequest request, HttpServletResponse response) throws Exception{
    	int fSize = (int)file.length();
    	
    	System.out.println("file :::" + file);
	    
    	if (fSize > 0) {
			String mimetype = "application/x-msdownload";
			setDisposition(name, request, response);
			response.setContentLength(fSize);
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
			    in = new BufferedInputStream(new FileInputStream(file));
			    out = new BufferedOutputStream(response.getOutputStream());
			    // MAC Safari브라우져에서 확장자exe 추가되는 문제로 Tika로 mime-type 선언
			    Tika tika = new Tika();
			    mimetype = tika.detect(in);
			    response.setContentType(mimetype);
			    FileCopyUtils.copy(in, out);
			    out.flush();
			} catch (IOException ex) {
				logger.debug("IO 에러");
			} finally {
				if (in != null) {
					in.close();
				}
				if (out != null) {
					out.close();
				}
			}  
	    }
    }
    
}
