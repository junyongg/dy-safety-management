package com.tx.common.file.impl;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.tx.common.file.FileManageTools;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @FileManageTools
 * @Service : FileManageTools
 * 파일 생성 및 삭제 관리 하는 툴 클래스 
 * @author 주지은
 * @version 1.0
 * @since 2019-06-05
 */

@Service("FileManageTools")
public class FileManageToolsImpl extends EgovAbstractServiceImpl implements FileManageTools{
	
	private static final Logger logger = LoggerFactory.getLogger(FileManageToolsImpl.class);
	
	/**
	 * 파일 생성
	 * @param filePath 
	 * @param fileName 
	 * @throws Exception
	 */
	@Override
	public boolean create_File(String filePath, String fileName, String data) throws Exception {
		
		boolean state = true;
	  
		// 해당경로에 폴더 없을 시 생성
		File file = new File(filePath);     
		if(!file.isDirectory()) {      
		  file.mkdirs();     
		}
		
		BufferedOutputStream bs = null;
		
		try {
			bs = new BufferedOutputStream(new FileOutputStream(filePath + fileName));
			bs.write(data.getBytes());
		} catch (IOException e) {
		  System.out.println("파일을 생성하는 과정에서 오류가 발생했습니다.");
		  state = false;
		}finally {
			if(bs != null){
				bs.close(); //반드시 닫는다.
			}
		}
	  
	  return state;
	}
	
	/**
	 * 파일 복사
	 * @param oriFile 
	 * @param newFile 
	 * @throws Exception
	 */
	@Override
	public boolean file_copy(String oriFilePath, String newFilePath, String fileName) throws Exception {
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		boolean state = true;
		
		// 해당경로에 폴더 없을 시 생성
		File file = new File(newFilePath);     
		if(!file.isDirectory()) {      
		  file.mkdirs();     
		}
		
		try {
		   fis = new FileInputStream(oriFilePath + fileName);
		   fos = new FileOutputStream(newFilePath + fileName);
   
		   int data = 0;
		   while((data=fis.read())!=-1) {
			   fos.write(data);
		   }
		   
		} catch (IOException e) {
			System.out.println("파일을 복사하는 과정에서 오류가 발생했습니다.");
			state = false;
		} finally {
			if(fis != null){
				fis.close();
			}
			if(fos != null){
				fos.close();
			}
		}
		
		return state;
	}
	
	/**
	 * 파일 읽기
	 * @param filePath 
	 * @param fileName 
	 * @throws Exception
	 */
	@Override
	public String read_file(String filePath, String fileName) throws Exception {
		String content = "";
		
	    try {
	        content = new String (Files.readAllBytes(Paths.get(filePath + fileName)));
	    }
	    catch (IOException e)
	    {
	        System.out.println("파일을 읽는하는 과정에서 오류가 발생했습니다.");
	    }
	    return content;
		
	}
	
	/**
	 * 파일 및 폴더 삭제
	 * @param filePath 
	 * @throws Exception
	 */
	@Override
	public void delete_Folder(String filePath) throws Exception {
	  
	  File folder = new File(filePath);
	    try {
		if(folder.exists()){
              File[] folder_list = folder.listFiles(); //파일리스트 얻어오기
				
		for (int i = 0; i < folder_list.length; i++) {
		    if(folder_list[i].isFile()) {
		    	folder_list[i].delete();
		    }else {
		    	delete_Folder(folder_list[i].getPath()); //재귀함수호출
		    }
		    folder_list[i].delete();
		 }
		 folder.delete(); //폴더 삭제
	       }
	   } catch (Exception e) {
		   System.out.println("파일을 삭제하는 과정에서 오류가 발생했습니다.");
	   }
	}

	@Override
	public boolean create_File(String filePath, String fileName, String data, boolean b) {
		// TODO Auto-generated method stub
				checkFolder(new File(filePath));
				try (BufferedOutputStream bs = new BufferedOutputStream(new FileOutputStream(filePath + fileName))){
					if(b) data = compression(data);
					bs.write(data.getBytes()); //Byte형으로만 넣을 수 있음
				} catch (IOException e) {
					System.out.println("파일을 생성하는 과정에서 오류가 발생했습니다.");
					return false;
				}
				return true;
	}
	private void checkFolder(File folder) {
		// TODO Auto-generated method stub
		if (!folder.exists() || folder.isFile()) {
			folder.mkdirs();
		}
	}
	
	/**
	 * 파일 압축하기( 현재는 js,css 만 가능)
	 * 2019-07-03 신강철
	 * 버그 있을 수 있음 테스트 좀더 해야됨
	 * @param data
	 * @return
	 */
	private String compression(String str) {
		// TODO Auto-generated method stub
		
		String lines[] = str.split(System.getProperty("line.separator"));
		StringBuilder builder = new StringBuilder();
		for(String line: lines){
			line = line.trim();
			
			if(StringUtils.isBlank(line)) continue;
			
			if(line.startsWith("//")) continue;
			
			/**
			 * window.open("https://twitter.com/intent/tweet?url="+url); // text 파라미터 삭제함
			 * 위와 같은경우 // 주석 처리가 제대로 되지 않아서 "" 나 '' 로 감싸여 있는 부분 삭제후 // 포함하고 있는지 판단함.
			 * 포함되어 있으면 원래 데이터에서 lastIndexOf 로 뒤쪽 잘라줌
			*/
			String line2 = line.replaceAll("\"(.*?)\"", "");
			line2 = line2.replaceAll("'(.*?)'", "");
			if(line2.indexOf("//") != -1) line = line.substring(0,line.lastIndexOf("//"));
			
			
			/**
			 *  var aa = test 나  alert() 같은 경우 마지막에 ; 포함시키는 처리
			*/
			int lastChar = (int)line.toCharArray()[line.length()-1];
			if(
				(lastChar >= 65 && lastChar <=90) 	||	// A ~ Z
				(lastChar >= 97 && lastChar <=122) 	||	// a ~ z
				(lastChar >= 48 && lastChar <=57) 	||	// 0 ~ 9
				lastChar == 41							// )
			){
				line += ";";
			}
			
			builder.append(line);
		}
		
		str = builder.toString();
		
		str = str.replaceAll("/\\*(.*?)\\*/", ""); 	//   /* 주석 */ 제거
		str = str.replaceAll("<!--(.*?)-->", "");	//		<!-- 주석 --> 제거
		str = str.replaceAll("\t", "");

		
		return str;
	}
}
