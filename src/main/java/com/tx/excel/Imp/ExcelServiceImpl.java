package com.tx.excel.Imp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tx.excel.ExcelService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("ExcelService")
public class ExcelServiceImpl extends EgovAbstractServiceImpl implements ExcelService {
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	//하나의 폴더당 내부 파일의 개수
	final private int FOLDER_FILE_CNT = 100;
	
	public ArrayList<ArrayList<String>> readFilter_And_Insert(MultipartFile file) throws IOException {
		
		int cells = 15;	// 셀의 수
		
		//프로퍼티 경로 불러오기
		String propertiespath = propertiesService.getString("FilePath");
		
		String filePath = propertiespath + file.getOriginalFilename();
		
		File saveFile = new File(filePath);  // 적용 후
		try {
			file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		FileInputStream fis = new FileInputStream(filePath);
		
		@SuppressWarnings("resource")
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		int rowindex = 0;
		int columnindex = 0;		
		ArrayList<ArrayList<String>> filters = new ArrayList<ArrayList<String>>();		
		
		int sheetCn = workbook.getNumberOfSheets();	// 시트 수
		for(int sheetnum=0; sheetnum<sheetCn; sheetnum++) {	// 시트 수만큼 반복
			
			int sheetnum2=sheetnum+1;
			System.out.println("sheet = " + sheetnum2);
			
			XSSFSheet sheet = workbook.getSheetAt(sheetnum);	// 읽어올 시트 선택
			int rows = sheet.getPhysicalNumberOfRows();    // 행의 수
			XSSFRow row = null;
			
			for (rowindex = 1; rowindex < rows; rowindex++) {	// 행의 수만큼 반복

				row = sheet.getRow(rowindex);	// rowindex 에 해당하는 행을 읽는다
				ArrayList<String> filter = new ArrayList<String>();	// 한 행을 읽어서 저장할 변수 선언

				if (row != null) {
					cells = row.getPhysicalNumberOfCells();    // 열의 수
					for (columnindex = 0; columnindex <= cells; columnindex++) {	// 열의 수만큼 반복
						XSSFCell cell_filter = row.getCell(columnindex);	// 셀값을 읽는다
						String value = "";
						
						// 셀이 빈값일경우를 위한 널체크
						if (cell_filter == null) {
							value = " ";
						} else {
							// 타입별로 내용 읽기
							switch (cell_filter.getCellType()) {
							case FORMULA:
								value = cell_filter.getCellFormula();
								break;
							case NUMERIC:
								value = cell_filter.getNumericCellValue() + "";
								break;
							case STRING:
								value = cell_filter.getStringCellValue() + "";
								break;
							case BLANK:
								value = cell_filter.getBooleanCellValue() + "";
								break;
							case ERROR:
								value = cell_filter.getErrorCellValue() + "";
								break;
							}
						}
						filter.add(value);	//읽은 셀들을 filter에 추가 (행)
					}
				}
				filters.add(filter); //filter(행)을 filters(열)에 추가
			}
		}
		fis.close();	//파일 읽기 종료
		return filters;	//리스트 반환
	}
	
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
	
}
