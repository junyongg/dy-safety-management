package com.tx.common.file;

import org.springframework.stereotype.Service;

/**
 * @FileUploadTools
 * 공통기능의 파일 업로드를 관리 하는 툴 클래스 
 * @author 신희원
 * @version 1.0
 * @since 2014-11-12
 */

/**
 * @author admin
 *
 */

public interface FileManageTools{
	
	/**
	 * 파일 생성 
	 * @param filePath 
	 * @param fileName 
	 * @throws Exception
	 */
	public boolean create_File(String filePath, String fileName, String data) throws Exception;
	
	
	/**
	 * 파일 복사
	 * @param oriFilePath 
	 * @param newFilePath 
	 * @param fileName 
	 * @throws Exception
	 */
	public boolean file_copy(String oriFilePath, String newFilePath, String fileName) throws Exception;
	
	
	/**
	 * 파일 읽기
	 * @param filePath 
	 * @param fileName 
	 * @throws Exception
	 */
	public String read_file(String filePath, String fileName) throws Exception;
	
	/**
	 * 파일 및 폴더 삭제
	 * @param filePath 
	 * @throws Exception
	 */
	public void delete_Folder(String filePath) throws Exception;


	public boolean create_File(String filePath, String fileName, String data, boolean b);
	

}
