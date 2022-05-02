package com.tx.migration.controller;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.apache.cxf.common.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tx.admin.board.dto.BoardColumnData;
import com.tx.admin.board.dto.BoardNotice;
import com.tx.admin.member.dto.UserDTO;
import com.tx.common.common.CommonFunction;
import com.tx.common.component.CommonService;
import com.tx.common.component.ComponentService;
import com.tx.common.file.CMYKConverter;
import com.tx.common.file.FileUploadTools;
import com.tx.common.file.dto.FileMain;
import com.tx.common.file.dto.FileSub;

import egovframework.rte.fdl.property.EgovPropertyService;



/**
 * @author 권원필
 *
 */
@Service
public class MigrationService {
	
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	@Autowired CommonService CommonService;
	/** CMYKConverter */
	@Autowired CMYKConverter CMYKConverter;
	/** 공통함수 */
	CommonFunction cf = new CommonFunction();
	
	/** 파일업로드 툴*/
	@Autowired private FileUploadTools FileUploadTools;
	
	/** 프로퍼티 정보 읽기 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	int imageGalWidth = 288;
	int imageGalheight = 172;
	
	int rndGalWidth = 288;
	int rndGalHeight = 374;
	private String SourcePath_upload         = "D:/jact/upload/";
	//private String SourcePath_uploadArtistDB = "E:/workspace/asp/biennale_ASP";
	private String SourcePath_file           = "D:/org/file/";
	
	String edit = "D:/jact/jnact_1906171734/public_html/";
	
//	private String SourcePath_upload = "D:/src/biennale_asp/upload";
//	private String SourcePath_uploadArtistDB = "D:/src/biennale_asp";
//	private String SourcePath_file = "D:/src/biennale_asp/";
	
	
	// 게시판 마이그레이션
	public void board_migration(String CateID) throws Exception {
		// TODO Auto-generated method stub
		
		
		
		System.out.println("게시판 "+CateID + " 마이그레이션 시작!!!!!");
		
		BoardNotice boardNotice = null;
		FileSub FileSub = null;
		FileSub FileSub_file = null;
		 
		// 메뉴키 가져오기
		String MN_KEYNO = getMenuKey(CateID);
		if(MN_KEYNO.equals("")){
			System.err.println(">>>>>메뉴키 없음");
			return;
		}
		
		//해당 메뉴 게시판 정보 초기화
		Component.deleteData("migration.delete_board", MN_KEYNO);
		Component.deleteData("migration.delete_column", MN_KEYNO);
		
		String tableN = getTableName(CateID);  // 5_5 같은 테이블 마지막
		
		String tableNameString = "jnact.rain_write_"+ tableN;
		
		//작업중
		TableName tableName = new TableName();
		tableName.setNAME(tableNameString);
	
		
		List<Board_5_5> PHP_List = Component.getList("migration.select_BBS_DATA_free" , tableName);
		
		if(PHP_List != null && PHP_List.size() > 0) {
			System.out.println(PHP_List.size()+"개");
		}
		
		
		UserDTO userD;
		for(Board_5_5 m : PHP_List){//게시물 처리 시작
			
			boardNotice = new BoardNotice();
			
			//아이디로 KEYNO  가져와야 한다 SQL 만듬
			// 여기서 시작
			
		
			
			String BN_KEYNO =  CommonService.getTableKey("BN"); //키 새로 생성
			//유저 아이디로  유저 keyno 가져오기
			userD = new UserDTO();
			userD.setUI_ID(m.getMb_id());
			UserDTO user = Component.getData("migration.select_user_keyno", userD);
			
			String MEMBER_ID = user.getUI_KEYNO();
			System.out.println(user.getUI_KEYNO()+"의 id 는 "+ user.getUI_ID());
			
			boardFileDto boardSearch = new boardFileDto();
			boardSearch.setTableN(tableN);
			boardSearch.setWr_id(m.getWr_id());
			
			
			// 첨부파일 불러오기
			List<boardFileDto> fileList = Component.getList("migration.get_free_file", boardSearch); 
			
			String FileMainKey = null;
			
			if(fileList != null && fileList.size() > 0) {
				System.out.println(fileList.size()+"개 의 파일 처리");
				
				 FileMainKey = CommonService.getTableKey("FM");
				 if(FileMainKey == null) {
					 System.out.println("널이나오면 안되는데 나옴");
					 return;
				 }
				if(CateID.equals("photo") || CateID.equals("지역사회공헌") || CateID.equals("학술보고서") || CateID.equals("학술세미나")   || CateID.equals("학술논문집")  ) {//이미지 게시판 일때 썸네일 처리     //Academic Library  처리 안해도 되는지 확인필요??
					firstImageThumb(boardNotice, tableN, fileList);
				}// 포토 게시판 썸네일 처리 끝
					
				 
				 
				 
				
				//파일 복사해주고 파일 메인 파일 서브 처리한다 여기서 처리한 파일 파일 관리자에서 볼수있는지 확인
				String bf_source, FS_EXT, FS_ORINN;
				for(boardFileDto bDto : fileList) {
					//원본 파일명
					bf_source = bDto.getBf_source(); 
					//확장자
					FS_EXT = bf_source.substring(bf_source.lastIndexOf(".")+1); 
					//원본파일명
					FS_ORINN = bf_source;
					
					String upPath = FileUploadTools.SaveFolder(SourcePath_upload);
					System.out.println(upPath+"에 저장한다");
					String newFileName = FileUploadTools.setfilename();
					
					//실제 파일 복사
					File origfile = new File(SourcePath_file + tableN + File.separator + bDto.getBf_file());
					File copyFile = new File(SourcePath_upload + upPath + File.separator + newFileName +"."+ FS_EXT);
					
					if(origfile.isFile()) {
						Path resultPsth = Files.copy(origfile.toPath(), copyFile.toPath());
						System.out.println(resultPsth+" 파일 생성됨");
					}else {
						String fileName = tableN+"_filecopy.log";
				         
				         File file = new File(SourcePath_upload + fileName);
				         
				         try(FileWriter fw = new FileWriter(file, true)){
				        	 String msg = tableN+ "게시판 " +  m.getWr_subject() + "제목의  게시글(" + bDto.getWr_id() +  ") 번 글 확인 "+ bDto.getBf_no()+"번째 파일" ;
				            fw.write(msg + "\r\n");
				            fw.flush();
				            
				         }catch (Exception e) {
				            // TODO: handle exception
				            System.out.println("로그 에러 : " + e.getMessage());
				         }
					}
					
					
					FileSub = new FileSub();
					FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
					FileSub.setFS_FM_KEYNO(FileMainKey);
					FileSub.setFS_FILE_SIZE(bDto.getBf_filesize());
					FileSub.setFS_ORINM(FS_ORINN);
					FileSub.setFS_CHANGENM(newFileName);
					FileSub.setFS_EXT(FS_EXT);
					FileSub.setFS_DOWNCNT(Integer.parseInt(bDto.getBf_download()));
					FileSub.setFS_FOLDER(upPath);
					FileSub.setFS_REGNM(MEMBER_ID);
					FileSub.setFS_REGDT(bDto.getBf_datetime());
					FileSub.setFS_ALT(FS_ORINN);
					FileSub.setFS_ORIWIDTH(bDto.getBf_width() == null? 0: Integer.parseInt(bDto.getBf_width()));
					FileSub.setFS_ORIHEIGHT(bDto.getBf_height() ==null ? 0 : Integer.parseInt(bDto.getBf_height()));
					System.out.println("1");
					Component.createData("migration.FileSubInsert", FileSub);
				}
				
				
				
			}//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=첨부파일 처리 끝
			
				
			//첨부파일 처리후 썸네일 없으면 본문 내용에서 이미지 찾아서 넣어준다.	
			// 이미지 게시판  ,  학술자효실
			if(CateID.equals("photo") || CateID.equals("Academic Library") || CateID.equals("지역사회공헌")) {
			thumbFile(CateID, boardNotice, m);
			}
			//oldFileExe(CateID, MEMBER_ID);  예전 파일 처리 로직
			
			

			//T_BOARD_COLUMN_DATA   예전 추가 컬럼 로직
			String result = insertBoardColumnData(CateID, BN_KEYNO, MN_KEYNO, m);
			if(StringUtils.isEmpty(result)){
				System.err.println(">>>>>T_BOARD_COLUMN_DATA 없음");
				return;
			}
			
			
			//T_BOARD_NOTICE
			boardNotice.setBN_KEYNO(BN_KEYNO);
			boardNotice.setBN_MN_KEYNO(MN_KEYNO);
			boardNotice.setBN_FM_KEYNO(FileMainKey);
			boardNotice.setBN_TITLE(m.getWr_subject());
			
			if(CateID.equals("movie")) {//동영상 마이그레이션 옵션
				if(m.getWr_link2() != null && !m.getWr_link2().equals("")) { //2번링크가 유튜브일때 
					System.out.println("link2 유튜브로 등록");
					boardNotice.setBN_CONTENTS(m.getWr_link2());
				}else {
					boardNotice.setBN_CONTENTS(m.getWr_link1());
				}
			}else {// 기본형
				boardNotice.setBN_CONTENTS(m.getWr_content());
			}
			boardNotice.setBN_REGNM(MEMBER_ID);
//			boardNotice.setBN_PWD("");
			boardNotice.setBN_REGDT(m.getWr_datetime());
			boardNotice.setBN_USE_YN("Y");
			boardNotice.setBN_SECRET_YN("N");
			/*if(THUMNAILEZFILE != null){  //섬네일 주석 ㅡㅡ;
				boardNotice.setBN_THUMBNAIL(FileSub.getFS_KEYNO());
			}*/
			boardNotice.setBN_IMPORTANT("N");
			boardNotice.setBN_MAINKEY(BN_KEYNO);
			/*if(Integer.parseInt(m.get("RE_STEP")+"") > 0){
				boardNotice.setBN_PARENTKEY(CommonService.getKeyno(m.get("REF").toString().replaceAll(",", ""), "BN"));
			}else{
				boardNotice.setBN_PARENTKEY("");
			}*/
			boardNotice.setBN_PARENTKEY(""); //답글부모키?
			//  답글있으면 수정해야할수도있슴
			boardNotice.setBN_SEQ(1);
			boardNotice.setBN_DEPTH(0);
			boardNotice.setBN_MODDT(m.getWr_last());
			boardNotice.setBN_HITS(Integer.parseInt(m.getWr_hit()));
			/*if(m.get("STATUS").toString().equals("6")){
				boardNotice.setBN_USE_YN("N");
			}else{
				boardNotice.setBN_USE_YN("Y");
			}*/
			
			System.err.println(">>>>>getBN_KEYNO: "+boardNotice.getBN_KEYNO());
			if(!boardNotice.getBN_TITLE().equals("")) {//이미지 게시판 제목없는 것 때문에 추가함 
				Component.createData("migration.BN_insert", boardNotice);
			}
		}// 게시물 처리 끝
		
		//FILE_SUB_SEQ_UPDATE();
		//SEQ_UPDATE_TXCMS("T_BOARD_NOTICE", "BN_KEYNO");
		System.out.println("게시판 "+CateID + " 마이그레이션 끝!!!!!");
		
		
	}





	private void firstImageThumb(BoardNotice boardNotice, String tableN, List<boardFileDto> fileList) {
		//첫번째 첨부파일이 이미지이면 썸네일로 사용
		if(fileList.get(0).getBf_source() != null && !fileList.get(0).getBf_source().equals("")){
			System.out.println("첨부파일로 섬네일 생성 ");
			// File 경로
			String fileName =(String)fileList.get(0).getBf_file();
			File file = new File(SourcePath_file + ""+tableN+"/" + fileName);
			if(file.exists() && file.length() != 0){
				FileSub FileSub5 = null;
				String filename = (String)fileList.get(0).getBf_source();
				//확장자
				String FS_EXT =  filename.substring(filename.lastIndexOf(".")+1).toLowerCase();
				if("png,jpg.gif".contains(FS_EXT)){
					
					try {
						if(tableN.equals("k_5_1") || tableN.equals("k_5_2") || tableN.equals("k_5_3")) {// 문화재연구소 싸이즈
							FileSub5 = FileUploadWithMigration(file, fileList.get(0), CommonService.getTableKey("FM"),"admin",356,471);
						}else {// 이미지 겔러리 등등
							FileSub5 = FileUploadWithMigration(file, fileList.get(0), CommonService.getTableKey("FM"),"admin",288,172);
						}
						if(!FileSub5.getFS_KEYNO().equals("")){
							System.out.println("첨푸바일로 썸네일 만들어짐");
							Component.createData("migration.FileSubInsert", FileSub5);
							//여기서 파일 처리 되는지 확인
							boardNotice.setBN_THUMBNAIL(FileSub5.getFS_KEYNO());
						}else {
							System.out.println("첨푸바일로 썸네일 만들기 실패");
						}
					} catch (Exception e) {
						System.out.println("firstImageThumb"+ e.getMessage());
					}
					
				}
			}
		}//첫번째 첨부파일 처리 끝
	}





	private void thumbFile(String CateID, BoardNotice boardNotice, Board_5_5 m)  {
		
			//System.out.println("포터처리 들어옴"+ boardNotice.getBN_THUMBNAIL());
			if(boardNotice.getBN_THUMBNAIL() == null || boardNotice.getBN_THUMBNAIL().equals("")) {
				//System.out.println(" 널 처리 들어옴");
				// 이미지 태그를 추출하기 위한 정규식.
				Pattern pattern  =  Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");

				// 추출할 내용.
				String contents = m.getWr_content();
				System.out.println(contents);
				//소문자로 변환
				//contents = contents.toLowerCase();
				
				// 내용 중에서 이미지 태그를 찾아라!
				Matcher match = pattern.matcher(contents);
				 
				String imgTag = null;
				if(match.find()){ // 이미지 태그를 찾았다면,,
				    imgTag = match.group(1); // 글 내용 중에 첫번째 이미지 태그를 뽑아옴.
				    System.out.println(imgTag);
				    
				    imgTag = imgTag.replaceAll("http://www.jact.or.kr/", "");
				    imgTag = imgTag.replaceAll("http://jact.or.kr/", "");
				    System.out.println(imgTag);
				    
				    //에디터 위치
				   
				    File File = new File(edit+imgTag);
				    if(File.exists()){
				    	FileSub FileSub2;
						try {
							
							FileSub2 = FileUploadWithFile(File,"admin",true,imageGalWidth,
										CateID.equals("photo")?	imageGalheight : rndGalHeight);
							System.out.println("3");
					    	Component.createData("migration.FileSubInsert", FileSub2);
					    	boardNotice.setBN_THUMBNAIL(FileSub2.getFS_KEYNO());
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							System.out.println("thumbFile 에서 문제됨");
						}
				    	
				    }else{
				    	System.out.println("ㅜㅜ");
				    }
				}
			}
		
	}


	


	private void oldFileExe(String CateID, String MEMBER_ID) throws Exception {
		//파일 체크
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("CateID", CateID);
		//paramMap.put("IDX", BBS_DATA_IDX);
		
		String attach_fm_key = null;
		String THUMBNAIL = null;
		Map<String,Object> THUMNAILEZFILE = null;
		//List<Map<String,Object>> fileList = null;
		if(CateID.equals("VIDEO")){// VIDEO 예외처리 (일부 썸네일 첨부파일 형태로 등록되어 있어서..
			
			fileVideo(MEMBER_ID, paramMap);
			
		}else if(CateID.equals("EVENT")){
			
			fileEvent(MEMBER_ID, paramMap);
			
		}else{
			fileElse(MEMBER_ID, paramMap);
		}
	}


	private void fileElse(String MEMBER_ID, HashMap<String, Object> paramMap) throws Exception {
		FileSub FileSub;
		FileSub FileSub_file;
		String attach_fm_key;
		String THUMBNAIL;
		Map<String, Object> THUMNAILEZFILE;
		List<Map<String, Object>> fileList;
		//첨부파일 정보
		fileList = Component.getList("migration.select_BBS_DATA_FILE", paramMap);
		if(fileList.size() > 0){
			FileSub_file = new FileSub();
			attach_fm_key = CommonService.getTableKey("FM");
			for(Map<String,Object> f : fileList){
				File file_attach = null;
				String fileUrl = f.get("FileUrl")+"";
				if(fileUrl.contains("files")){
					file_attach = new File(SourcePath_file +f.get("FileUrl"));
				}else{
					file_attach = new File(SourcePath_upload +f.get("FileUrl"));
				}
				if(file_attach.exists()){
					
					String FileGubun = cf.checkColumnData(f.get("FileGubun"));
					if(StringUtils.isEmpty(FileGubun)){FileGubun = "BBS_DATA";}
					
					FileSub_file = FileUploadWithMigration(file_attach, f, attach_fm_key, MEMBER_ID, FileGubun);
					Component.createData("migration.AFS_FileInfoInsert", FileSub_file);
				}
			}
		}
		
		//썸네일 정보
		THUMNAILEZFILE = Component.getData("migration.select_BBS_DATA_THUMNAILEZFILE", paramMap);
		if(THUMNAILEZFILE != null){
			FileSub = new FileSub();
			THUMBNAIL = CommonService.getKeyno(THUMNAILEZFILE.get("AIdx")+"", "FS");
			File file_thum = null;
			String fileUrl_thum = THUMNAILEZFILE.get("FileUrl")+"";
			if(fileUrl_thum.contains("files")){
				file_thum = new File(SourcePath_file +THUMNAILEZFILE.get("FileUrl"));
			}else{
				file_thum = new File(SourcePath_upload +THUMNAILEZFILE.get("FileUrl"));
			}
			if(file_thum.exists()){
				
				String FileGubun = cf.checkColumnData(THUMNAILEZFILE.get("FileGubun"));
				if(StringUtils.isEmpty(FileGubun)){FileGubun = "BBS_DATA";}
				
				FileSub = FileUploadWithMigration(file_thum, THUMNAILEZFILE, CommonService.getTableKey("FM"), MEMBER_ID, FileGubun);
				Component.createData("migration.AFS_FileInfoInsert", FileSub);
			}
		}else{
			THUMBNAIL = null;
		}
	}


	private void fileEvent(String MEMBER_ID, HashMap<String, Object> paramMap) throws Exception {
		FileSub FileSub;
		String THUMBNAIL;
		Map<String, Object> THUMNAILEZFILE;
		//첨부파일 정보
		THUMNAILEZFILE = Component.getData("migration.select_BBS_DATA_FILE", paramMap);
		if(THUMNAILEZFILE != null){
			FileSub = new FileSub();
			THUMBNAIL = CommonService.getKeyno(THUMNAILEZFILE.get("AIdx")+"", "FS");
			File file_thum = null;
			String fileUrl_thum = THUMNAILEZFILE.get("FileUrl")+"";
			if(fileUrl_thum.contains("files")){
				file_thum = new File(SourcePath_file +THUMNAILEZFILE.get("FileUrl"));
			}else{
				file_thum = new File(SourcePath_upload +THUMNAILEZFILE.get("FileUrl"));
			}
			if(file_thum.exists()){
				
				String FileGubun = cf.checkColumnData(THUMNAILEZFILE.get("FileGubun"));
				if(StringUtils.isEmpty(FileGubun)){FileGubun = "BBS_DATA";}
				
				FileSub = FileUploadWithMigration(file_thum, THUMNAILEZFILE, CommonService.getTableKey("FM"), MEMBER_ID, FileGubun);
				Component.createData("migration.AFS_FileInfoInsert", FileSub);
			}
		}else{
			THUMBNAIL = null;
		}
	}


private void fileVideo(String MEMBER_ID, HashMap<String, Object> paramMap) throws Exception {
	FileSub FileSub;
	String THUMBNAIL;
	Map<String, Object> THUMNAILEZFILE;
	List<Map<String, Object>> fileList;
	//썸네일 정보
	THUMNAILEZFILE = Component.getData("migration.select_BBS_DATA_THUMNAILEZFILE", paramMap);
	if(THUMNAILEZFILE != null){
		FileSub = new FileSub();
		THUMBNAIL = CommonService.getKeyno(THUMNAILEZFILE.get("AIdx")+"", "FS");
		File file_thum = null;
		String fileUrl_thum = THUMNAILEZFILE.get("FileUrl")+"";
		if(fileUrl_thum.contains("files")){
			file_thum = new File(SourcePath_file +THUMNAILEZFILE.get("FileUrl"));
		}else{
			file_thum = new File(SourcePath_upload +THUMNAILEZFILE.get("FileUrl"));
		}
		if(file_thum.exists()){
			
			String FileGubun = cf.checkColumnData(THUMNAILEZFILE.get("FileGubun"));
			if(StringUtils.isEmpty(FileGubun)){FileGubun = "BBS_DATA";}
			
			FileSub = FileUploadWithMigration(file_thum, THUMNAILEZFILE, CommonService.getTableKey("FM"), MEMBER_ID, FileGubun);
			Component.createData("migration.AFS_FileInfoInsert", FileSub);
		}
	}else{
		
		//첨부파일 썸네일
		fileList = Component.getList("migration.select_BBS_DATA_FILE", paramMap);
		if(fileList.size() > 0){
			FileSub = new FileSub();
			THUMNAILEZFILE = fileList.get(0);
			THUMBNAIL = CommonService.getKeyno(THUMNAILEZFILE.get("AIdx")+"", "FS");
			File file_thum = null;
			String fileUrl_thum = THUMNAILEZFILE.get("FileUrl")+"";
			if(fileUrl_thum.contains("files")){
				file_thum = new File(SourcePath_file +THUMNAILEZFILE.get("FileUrl"));
			}else{
				file_thum = new File(SourcePath_upload +THUMNAILEZFILE.get("FileUrl"));
			}
			if(file_thum.exists()){
				
				String FileGubun = cf.checkColumnData(THUMNAILEZFILE.get("FileGubun"));
				if(StringUtils.isEmpty(FileGubun)){FileGubun = "BBS_DATA";}
				
				FileSub = FileUploadWithMigration(file_thum, THUMNAILEZFILE, CommonService.getTableKey("FM"), MEMBER_ID, FileGubun);
				Component.createData("migration.AFS_FileInfoInsert", FileSub);
			}
		}
	}
}
	
	



	//FILE_SUB 관련 갱신
		public long FILE_SUB_SEQ_UPDATE(){
			return SEQ_UPDATE_TXCMS("T_COMMON_FILE_SUB", "FS_KEYNO");
		}
		
		
		
		/**
		 * @param asIsTableName AS-IS 테이블명(기존)
		 * @param asIsTablePKColName (int형만 가능) AS-IS 테이블의 PK 컬럼명
		 * @param toBeTableName TO-BE 테이블명(신규)
		 * @return
		 * T_COMMON_SEQ_CNT 테이블에 해당 테이블 정보없으면 INSERT
		 * AS-IS 테이블PK MAX값으로 SQ_CNT값 갱신함
		 */
		public long SEQ_UPDATE_TXCMS(String toBeTableName, String asIsTablePKColName ){
			
			String tableName2 = toBeTableName;
			//테이블 시퀀스 유무 체크 및 신규생성, SEQ 수정
			int cntTableSEQ2 = Component.getData("Common.countTableKey", tableName2);
			if( cntTableSEQ2 == 0 ){
				Component.createData("Common.insertTableKey_NumberType", tableName2);
			}
			
			//FS SEQ 갱신
			String queryForSEQ2 = "select IFNULL(MAX("+asIsTablePKColName+"),0) as maximum from " + toBeTableName;
			HashMap<String,Object> map = Component.getData("migration.SELECT", queryForSEQ2);
			String maxKeyno = map.get("maximum")+"";
			maxKeyno = maxKeyno.replaceAll("[^0-9]+", "");
			long maxKeyNumber2 = Long.parseLong(maxKeyno);
			
			System.err.println("#0101 : "+ maxKeyNumber2);
//					int maxKeyNumber = Integer.parseInt(maxKeynoStr.replace(colPrefix+"_", ""));
			String updateForSEQ2 = "UPDATE T_COMMON_SEQ_CNT SET	SQ_CNT =	'" + maxKeyNumber2 + "' WHERE		 SQ_TABLE_NM 	= 	'" + tableName2 + "'";
			Component.updateData("migration.UPDATE", updateForSEQ2);
			
			return maxKeyNumber2;
		}
		
		
	
	// 게시판 메뉴 KEY get
		private String getMenuKey(String CateID) {
			// TODO Auto-generated method stub
			
			String MN_KEYNO = "";
			switch (CateID) {
			/*case "NEWS": //뉴스(비엔날레_asp) 
				MN_KEYNO = "MN_0000001119";
				break;
			
			case "PROMOTE": //홍보자료(비엔날레_asp) 
				MN_KEYNO = "MN_0000001146";
				break;*/
			
			case "FREE":// 자유게시판
				MN_KEYNO ="MN_0000001558";
				break;
				
			case "NOTI"://공지사항
				MN_KEYNO="MN_0000001509";
				break;
				
			case "BODO"://보도자료
				MN_KEYNO="MN_0000001556";
				break;
				
			case "biddannouncement"://입찰공고
				MN_KEYNO="MN_0000001525";
				break;
				
			case "Careers"://채용공고
				MN_KEYNO="MN_0000001510";
				break;
				
			case "movie"://동영상
				MN_KEYNO="MN_0000001536";
				break;
				
			case "photo"://이미지
				MN_KEYNO="MN_0000001540";
				break;

			case "pdf": //pdf
				MN_KEYNO="MN_0000001538";
				break;
				
			case "Academic Library": //학술자효실
				MN_KEYNO="MN_0000001537";
				break;
				
			case "people": //임원현황
				MN_KEYNO="MN_0000001546";
				break;
				
			case "AuditResult": //감사현황
				MN_KEYNO="MN_0000001561";
				break;
				
			case "Board of Directors": //이사회
				MN_KEYNO="MN_0000001562";
				break;
				
			case "Union": //이사회
				MN_KEYNO="MN_0000001563";
				break;
				
			case "조달계약실적": //예산관리
				MN_KEYNO="MN_0000001565";
				break;
				
			case "업무추진비": //예산관리
				MN_KEYNO="MN_0000001545";
				break;
				
			case "복리후생비": //예산관리
				MN_KEYNO="MN_0000001566";
				break;
				
			case "지역사회공헌": //예산관리
				MN_KEYNO="MN_0000001567";
				break;
				
			case "지표조사": //지표조사
				MN_KEYNO="MN_0000001581";
				break;
				
			case "시발굴조사": //지표조사
				MN_KEYNO="MN_0000001582";
				break;
				
			case "연구소소식": //연구소소식
				MN_KEYNO="MN_0000001570";
				break;
				
			case "학술보고서": //학술보고서
				MN_KEYNO="MN_0000001589";
				break;
				
			case "학술세미나": //학술세미나
				MN_KEYNO="MN_0000001590";
				break;
				
			case "학술논문집": //학술논문집
				MN_KEYNO="MN_0000001591";
				break;
				
			case "무형문화재": //무형문화재
				MN_KEYNO="MN_0000001592";
				break;
				
			default:
				break;
			}
			
			return MN_KEYNO;
		}
		
		private String getTableName(String cateID) {
				String defult ="jnact.rain_write_";
				String result = null;
				switch (cateID) {
				
				
				case "BODO": //보도자료
					result = "5_1";
					break;
					
				case "NOTI": //공지사항
					result = "5_2";
					break;
					
				case "Careers": //채용공고
					result =  "5_3";
					break;
					
				case "FREE":
					result =  "5_5";
					break;
				
				case "biddannouncement": //입찰공고
					result =  "5_6";
					break;

				case "movie": //입찰공고
					result =  "4_1movie";
					break;
				
				case "photo": //입찰공고
					result =  "4_3photo";
					break;
					
				case "pdf": //pdf
					result =  "4_4publication";
					break;
					
				case "Academic Library": //학술자료실
					result = "4_2library";
					break;
					
				case "people": //임원현황
					result = "6_2_3";
					break;
				
				case "AuditResult": //감사결과
					result = "6_2_8";
					break;
					
				case "Board of Directors": //이사회 개최 현황
					result = "6_2_7";
					break;
					
				case "Union": //노동조합
					result = "6_2_9";
					break;
					
				case "조달계약실적": //노동조합
					result = "6_2_ac";
					break;
					
				case "업무추진비": //예산관리
					result = "6_2_a";
					break;
					
				case "복리후생비": //예산관리
					result = "6_2_ab";
					break;
					
				case "지역사회공헌": //지역사회공헌
					result = "6_4_2";
					break;
					
					
				case "지표조사": //지표조사
					result = "k_4_1";
					break;
					
				case "시발굴조사": //시발굴조사
					result = "k_4_2";
					break;
					
				case "연구소소식": //연구소소식
					result = "k_2_1";
					break;
				//자료실=--------------------------------------------------	
				case "학술보고서": //학술보고서
					result = "k_5_1";
					break;
					
				case "학술세미나": //학술보고서
					result = "k_5_2";
					break;
					
				case "학술논문집": //학술논문집
					result = "k_5_3";
					break;
					
				case "무형문화재": //무형문화재
					result = "k_5_4";
					break;
					
				default:
					break;  
				}
			return result;
		}





		/**
		 * 파일 옮기기
		 * @param file
		 * @param fileInfo
		 * @param height 
		 * @param width 
		 * @param resize 
		 * @param fM_KEYNO
		 * @param rEGNM
		 * @throws Exception 
		 */
		
		//FileSub = FileUploadWithMigration(file_thum, THUMNAILEZFILE, CommonService.getTableKey("FM"), MEMBER_ID, FileGubun);
		
		public FileSub FileUploadWithMigration(File beforeFile, Map<String, Object> fileInfo, String FM_KEYNO, String REGNM, String pathDivision) throws Exception {
			// TODO Auto-generated method stub
			
			FileMain FileMain = new FileMain();
			FileMain.setFM_KEYNO(FM_KEYNO);
			FileMain.setFM_REGNM(REGNM);
			
			//메인코드 확인 및 등록 처리
			int result = Component.getCount("File.AFM_MainFileChecking", FileMain);
			if(result == 0){
				Component.createData("File.AFM_FileInfoInsert",FileMain);
			}
			
			
			
			 //프로퍼티 경로 불러오기
			   String propertiespath = propertiesService.getString("FilePath");
			   
			   FileSub FileSub = new FileSub();
				
			   String filename = cf.replaceAllForFileName(fileInfo.get("FileName")+"");
			   System.err.println(">>>>>filename: "+filename);
			   
			   String[] fileNameArr = filename.split("\\.");
				
				//확장자
				String FS_EXT = null;
				if(fileNameArr.length >= 2){
					FS_EXT =  filename.substring(filename.lastIndexOf(".")+1);
				}
			   
				//원본파일명
				String FS_ORINM = filename;
				//파일사이즈
				String FS_SIZE  = beforeFile.length() +"";
				
				//변경 파일명 없이 진행
				String FS_CHANGENM = filename;
				
				FileSub.setFS_FM_KEYNO(FM_KEYNO);
//				FileSub.setFS_KEYNO(Component.getTableKey("FS"));
				
				String FS_KEYNO = CommonService.getKeyno(fileInfo.get("AIdx")+"", "FS")+"";
				Component.deleteData("migration.delete_filesub", FS_KEYNO);
				FileSub.setFS_KEYNO(FS_KEYNO);
				FileSub.setFS_FOLDER(FileUploadTools.SaveFolder(propertiespath, pathDivision));
				
				//** 경로 설정 *//
				String uploadPath = propertiespath + FileSub.getFS_FOLDER();
				FS_CHANGENM = FileUploadTools.fileOverlapCheck(uploadPath, filename);
				
			   //파일 기본경로     
			   //파일 기본경로 _ 상세경로     
			   File file = new File(uploadPath);     
			   if(!file.exists()) {      
				   file.mkdirs();     
			   }     
			   String rlFileNm = uploadPath + FS_CHANGENM+"."+FS_EXT;     
			   ///////////////// 서버에 파일쓰기 /////////////////      
			   InputStream is = new FileInputStream(beforeFile);     
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
			   
			   
			 //파일 정보 저장
				FileSub.setFS_FILE_SIZE(FS_SIZE);
				FileSub.setFS_EXT(FS_EXT);
				FileSub.setFS_ORINM(FS_ORINM);
				FileSub.setFS_CHANGENM(FS_CHANGENM);
				FileSub.setFS_REGNM(REGNM);
				FileSub.setFS_REGDT(fileInfo.get("RegDate")+"");
				FileSub.setFS_DOWNCNT(0);
				
				return FileSub;
				
			   
		}
		
		
		// 게시판 T_BOARD_COLUMN_DATA 등록
		private String insertBoardColumnData(String CateID, String BN_KEYNO, String MN_KEYNO, Board_5_5 m){
			
			
			String result = "success";
			
			BoardColumnData BoardColumnData = null;
			
			String BD_DATA_TITLE = m.getWr_subject();
			//String BD_DATA_FOREWORD = map.get("FOREWORD")+"";
			//String IN_START_DATE = map.get("IN_START_DATE")+"";
			//String IN_END_DATE = map.get("IN_END_DATE")+"";
			//String MAKE_DATE = map.get("MAKE_DATE")+"";
		//	String YOUTUBE_URL = map.get("YOUTUBE_URL")+"";
			System.out.println("카테"+CateID + " BNKEY "+ BN_KEYNO +" NMKEY "+ MN_KEYNO);
			// 초기화
			switch (CateID) {
			

				
		
				
			case "FREE": 
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000001");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000001");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
			
			
			
			
			case "NOTI": //자유게시판, 공지사항 
					
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000024");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000068");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
			case "BODO": //자유게시판, 공지사항 
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000025");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000069");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
			case "biddannouncement": //입찰공고
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000028");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000072");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
			case "Careers": // 채용공고
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000024");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000068");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
			case "movie": // 동영상
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000029");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000073");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
			case "photo": // 동영상
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000033");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000077");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
					
				
				
			case "pdf": // pdf

				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000031");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000075");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				 
				break;
			case "Academic Library": // 학술자료실
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000030");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000074");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
				
			case "people": // 임원현황
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000041");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000085");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
				
			case "AuditResult": // 감사결과
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000042");//게시판 타입(자유게시판)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000086");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;

			case "Board of Directors": //이사회 개최 현황
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000043");//게시판 타입(자주묻는 질문)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000087");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
				
			case "Union": //노동조합
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000044");//게시판 타입(자주묻는 질문)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000088");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
				
			case "지역사회공헌": //지역사회공헌
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000050");//게시판 타입(자주묻는 질문)
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000123");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
				
			case "업무추진비":  case "복리후생비":
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000040");//
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000084");//사용자컬럼 메인키(제목)
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
						
			case "조달계약실적": //조달
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000049");//게시판 타입
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000099");// 계약명
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				//나머지 23개의 데이터 넣우줘야 한다
				//bt키는 49로 통일 bl 키로 구분
				
				callAdd23(m, BoardColumnData);
				
				
				break;
			case "지표조사":  case "시발굴조사": //지표조사  //시발굴조사
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000052");//게시판 타입
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000127");// 계약명
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				
				//조사기간
				String BL_0000000128 = m.getWr_1(); 
				String bl_key = "BL_0000000128";
				String bl_type ="SC_VEBHI";
				
				add23Cloumn(BoardColumnData, BL_0000000128, bl_key, bl_type);
				
				
				
				break;
			case "연구소소식": //연구소소식
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000051");//게시판 타입
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000126");// 계약명
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				
				//링크
				 BL_0000000128 = m.getWr_link1(); 
				 bl_key = "BL_0000000129";
				 bl_type ="SC_PJDGH";
				
				add23Cloumn(BoardColumnData, BL_0000000128, bl_key, bl_type);
				
				
				
				break;
			case "학술보고서": //학술보고서
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000054");//게시판 타입
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000132");// 계약명
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				
				//링크
				BL_0000000128 = m.getWr_1(); 
				bl_key = "BL_0000000133";
				bl_type ="SC_VEBHI";
				
				add23Cloumn(BoardColumnData, BL_0000000128, bl_key, bl_type);
				
				
				
				break;
				
			
			case "학술세미나":  case "학술논문집" :  //학술보고서 학술논문집
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000054");//게시판 타입
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000132");// 계약명
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				
				//링크
				BL_0000000128 = m.getWr_1(); 
				bl_key = "BL_0000000133";
				bl_type ="SC_VEBHI";
				
				add23Cloumn(BoardColumnData, BL_0000000128, bl_key, bl_type);
				
				
				
				break;
			case "무형문화재":   //무형문화재
				
				// 제목 
				BoardColumnData = new BoardColumnData();
				BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
				BoardColumnData.setBD_BT_KEYNO("BT_0000000055");//게시판 타입
				BoardColumnData.setBD_BN_KEYNO(BN_KEYNO);
				BoardColumnData.setBD_BL_KEYNO("BL_0000000134");// 계약명
				BoardColumnData.setBD_MN_KEYNO(MN_KEYNO);
				BoardColumnData.setBD_BL_TYPE("SC_HBHNH");//사용자컬럼 타입 (제목)
				BoardColumnData.setBD_DATA(BD_DATA_TITLE);
				Component.createData("BoardColumnData.BD_insert", BoardColumnData);
				
				break;
				
				
			default:
				result = null;
				break;
			}
			
			return result;
		 }





		/**  조달계약실적 데이터 
		 * @param m
		 * @param BoardColumnData
		 */
		private void callAdd23(Board_5_5 m, BoardColumnData BoardColumnData) {  
			String BL_0000000100 = m.getCa_name(); //계약구분
			String bl_key = "BL_0000000100";
			String bl_type = "SC_SACUX";
			
			add23Cloumn(BoardColumnData, BL_0000000100, "BL_0000000100", "SC_SACUX");
			
			
			String BL_0000000101 = m.getWr_link1(); //  계약 //전자,  수의  등
			bl_key = "BL_0000000101";
			bl_type ="SC_VEBHI";
			
			add23Cloumn(BoardColumnData, BL_0000000101, bl_key, bl_type);
			
			String data =""; // 배열 버퍼용
			
			String wr_1 = m.getWr_1();           //계약일자  @       계약기간 
			String[] wr1 = wr_1.split("@", 2);//BL_0000000106    BL_0000000107
			
			bl_key ="BL_0000000106";  //계약일자
			bl_type ="SC_NYMMH";
			data = wr1[0];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000107";  //계약기간
			bl_type ="SC_VEBHI";
			data = wr1[1];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			
			
			String wr_2 = m.getWr_2();  //       최초계약금액@       예정금액@       계 약금액
			String[] wr2 = wr_2.split("@",3); // BL_0000000103  BL_0000000102  BL_0000000105
			
			bl_key="BL_0000000103";// 최초계약금액 
			bl_type ="SC_VEBHI";
			data = wr2[0];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key="BL_0000000102";// 예정금액 
			bl_type ="SC_VEBHI";
			data = wr2[1];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key="BL_0000000105";// 계약금액 
			bl_type ="SC_VEBHI";
			data = wr2[2];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			String wr4 = m.getWr_4();//낙찰율  BL_0000000104
			bl_key ="BL_0000000104";
			bl_type ="SC_VEBHI";
			data = wr4;
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			String wr_5 = m.getWr_5(); //사업장 위치   @             면허 종류
			String[] wr5 = wr_5.split("@",2);//BL_0000000112      BL_0000000124
			
			bl_key ="BL_0000000112";//사업장 위치
			bl_type ="SC_VEBHI";
			data = wr5[0];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000124";//면허 종류
			bl_type ="SC_VEBHI";
			data = wr5[1];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			String wr6 = m.getWr_6(); //수의계약사유 BL_0000000113
			bl_key ="BL_0000000113";
			bl_type ="SC_VEBHI";
			data = wr6;
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			String wr_7 = m.getWr_7(); //           도급업체   @         대표자
			String[]  wr7 = wr_7.split("@", 2); //BL_0000000114   BL_0000000115
			
			bl_key ="BL_0000000114"; //도급업체
			bl_type ="SC_VEBHI";
			data = wr7[0];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000115"; //대표자
			bl_type ="SC_VEBHI";
			data = wr7[1];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000116"; //도급업체주소
			bl_type ="SC_VEBHI";
			data = m.getWr_content();
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			
			
			
			String wr_8 = m.getWr_8();         // 경쟁방법@         준공일자 @            게약유형@           경쟁방법상세
			String[] wr8 = wr_8.split("@", 4);//BL_0000000108     BL_0000000109      BL_0000000110     BL_0000000111
			
			bl_key ="BL_0000000108"; //경쟁방법
			bl_type ="SC_VEBHI";
			data = wr8[0];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000109"; //준공일자
			bl_type ="SC_NYMMH";
			data = wr8[1];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000110"; //계약유형
			bl_type ="SC_VEBHI";
			data = wr8[2];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000111"; //경쟁방법상세
			bl_type ="SC_VEBHI";
			data = wr8[3];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			String wr_9 = m.getWr_9();          //감독관@                계약관서@               계약부서
			String[] wr9 = wr_9.split("@", 3); //BL_0000000120         BL_0000000121      BL_0000000122
			
			bl_key ="BL_0000000120"; //감독관
			bl_type ="SC_VEBHI";
			data = wr9[0];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000121"; //감독관
			bl_type ="SC_VEBHI";
			data = wr9[1];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000122"; //감독관
			bl_type ="SC_VEBHI";
			data = wr9[2];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			String wr_10 = m.getWr_10(); 	//  	선금지급누계액@			기성금지급누계액@		준공금지급액@		 노무비지급누계액
			String[] wr10 = wr_10.split("@", 4);// BL_0000000117  		BL_0000000125		BL_0000000118	 BL_0000000119
			
			bl_key ="BL_0000000117"; //선금지급누계액
			bl_type ="SC_VEBHI";
			data = wr10[0];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000125"; //기성금지급누계액
			bl_type ="SC_VEBHI";
			data = wr10[1];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000118"; //준공금지급액
			bl_type ="SC_VEBHI";
			data = wr10[2];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
			
			bl_key ="BL_0000000119"; //노무비지급누계액
			bl_type ="SC_VEBHI";
			data = wr10[3];
			add23Cloumn(BoardColumnData, data, bl_key, bl_type);
		}





		/**  조달계약 실적에서 추가 데이터 넣을때 사용
		 * @param BoardColumnData
		 * @param BD_DATA
		 * @param bl_key
		 * @param bl_type
		 */
		private void add23Cloumn(BoardColumnData BoardColumnData, String BD_DATA , String bl_key, String bl_type) {
			BoardColumnData.setBD_KEYNO(CommonService.getTableKey("BD"));
			BoardColumnData.setBD_BL_KEYNO(bl_key);
			BoardColumnData.setBD_BL_TYPE(bl_type);
			BoardColumnData.setBD_DATA(BD_DATA);
			Component.createData("BoardColumnData.BD_insert", BoardColumnData);
		}
		
		/** 
		 * @param boardType 받아서 첨부파일 검색후 upload폴더에  원본파일이름으 파일 생성
		 */
		public void fileCopyOroriginal(String boardType) {
			//TODO  path 5_5 받아서 처리하게 수정
			String originalPath = "D:/jact/jnact_1906171734/public_html/data/file/"+ boardType +"/";
			String reaultPath = "D:/jact/upload/" + boardType + "/";
			String catchbf = null;
			File file = null;
			File fileToMove = null;
			File folder = null;
			boardFileDto dtos = new boardFileDto();
			dtos.setTableN(boardType);
			List<boardFileDto> list = Component.getList("migration.get_free_file", dtos);
			
			
			if(list != null && list.size()>0) {
				
				folder = new File(reaultPath);
				if(!folder.exists()){ //디렉토리 생성 메서드
				folder.mkdirs();
					System.out.println("created directory successfully!");
				}else {
					System.out.println(folder.toPath()+ "폴더있습.");
				}
				
				
				//원본파일명으로 복사 시작
				for(boardFileDto  dto : list) {
					
					 file = new File(originalPath + dto.getBf_file());
					 fileToMove = new File(reaultPath +  dto.getBf_source());
					 
					 try {
						 Path rpath = Files.copy(file.toPath(),fileToMove.toPath());
						 System.out.println(rpath);
						 
					 } catch(Exception e){
							// TODO Auto-generated catch block
							e.printStackTrace();
						catchbf = dto.getTableN() + " 게시판 " +   dto.getWr_id()+ " 번"+ dto.getBf_no() +"파일 샐패";
							System.out.println(catchbf);
					 }
					 
				}
				
			}
			
			

			


			//출처: https://pandorica.tistory.com/38 [판도리카의 꿈]
		}
		
		
	
		 
		/**  첫번째 이미지 파일로 썸네일 제작하게 수정
		 * @param beforeFile
		 * @param fileInfo
		 * @param FM_KEYNO
		 * @param REGNM
		 * @param width
		 * @param height
		 * @return
		 * @throws Exception
		 */
		public FileSub FileUploadWithMigration(File beforeFile, boardFileDto fileInfo, String FM_KEYNO, String REGNM,int width,int height) {
			// TODO Auto-generated method stub
			FileMain FileMain = new FileMain();
			FileMain.setFM_KEYNO(FM_KEYNO);
			FileMain.setFM_REGNM(REGNM);
			
			//메인코드 확인 및 등록 처리
			int result = Component.getCount("File.AFM_MainFileChecking", FileMain);
			if(result == 0){
				Component.createData("File.AFM_FileInfoInsert",FileMain);
			}
			 //프로퍼티 경로 불러오기
			   String propertiespath = propertiesService.getString("FilePath");
			   
			   FileSub FileSub = new FileSub();
				
			   String filename = (String)fileInfo.getBf_source();
			   
				//확장자
				String FS_EXT =  filename.substring(filename.lastIndexOf(".")+1);
				//원본파일명
				String FS_ORINM = filename;
				//파일사이즈
				String FS_SIZE  = beforeFile.length() +"";
				
				
				//변경 파일명
				String FS_CHANGENM = FileUploadTools.setfilename();
				
				FileSub.setFS_FM_KEYNO(FM_KEYNO);
				FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
				FileSub.setFS_FOLDER(FileUploadTools.SaveFolder(SourcePath_upload));
				
				//** 경로 설정 *//*
				String uploadPath = propertiespath + FileSub.getFS_FOLDER();
				
			   //파일 기본경로     
			   //파일 기본경로 _ 상세경로     
			   File file = new File(uploadPath);     
			   if(!file.exists()) {      
				   file.mkdirs();     
			   }     
			   String rlFileNm = uploadPath + FS_CHANGENM+"."+FS_EXT;
			   
			   //** 리사이즈 *
			 
			   try{
				
					   ImgResize(beforeFile.getPath(), rlFileNm, FS_EXT, width, height);
					  
				 
			   }catch(Exception e){
				   FileSub.setFS_KEYNO("");
				   return FileSub;
			   }finally {
				   
			   }
			
			   
			 //파일 정보 저장
				FileSub.setFS_FILE_SIZE(FS_SIZE);
				FileSub.setFS_EXT(FS_EXT);
				FileSub.setFS_ORINM(FS_ORINM);
				FileSub.setFS_CHANGENM(FS_CHANGENM);
				FileSub.setFS_REGNM(REGNM);
				FileSub.setFS_REGDT((String) fileInfo.getBf_datetime());
				FileSub.setFS_DOWNCNT(Integer.parseInt( fileInfo.getBf_download()));
				return FileSub;
		}
		
		
		/**
		 * 파일 업로드 + 리사이즈
		 * @param beforeFile
		 * @param REGNM
		 * @param width
		 * @param height
		 * @return
		 * @throws Exception
		 */
		public FileSub FileUploadWithFile(File beforeFile, String REGNM,boolean resize,int width,int height) throws Exception {
			// TODO Auto-generated method stub
			
			FileMain FileMain = new FileMain();
			FileMain.setFM_KEYNO(CommonService.getTableKey("FM"));
			FileMain.setFM_REGNM(REGNM);
			
			Component.createData("File.AFM_FileInfoInsert",FileMain);
			
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
				String FS_CHANGENM = FileUploadTools.setfilename();
				
				FileSub.setFS_FM_KEYNO(FileMain.getFM_KEYNO());
				FileSub.setFS_KEYNO(CommonService.getTableKey("FS"));
				FileSub.setFS_FOLDER(FileUploadTools.SaveFolder(propertiespath));
				
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
				   if(resize){
					   ImgResize(beforeFile.getPath(), rlFileNm, FS_EXT, width, height);
					  
				   }else{
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
					   
				   }
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
				FileSub.setFS_REGNM(REGNM);
				//Component.createData("File.AFS_FileInfoInsert", FileSub);
				return FileSub;
				
			   
		}
		
		/**
	 	 * 이미지 파일 사이즈 변경
	 	 * @param Filepath
	 	 * @throws Exception
	 	 */
	 	private void ImgResize(String Filepath,String newFilepath,String EXT, int width,int height)throws Exception{
	 		
	 		// 원본 이미지 가져오기
			Image imgSrc = null;
			try{
				System.out.println("일단 rgb로 생각하도 처리");
				imgSrc = ImageIO.read(new File(Filepath));
			}catch(Exception e){
				System.out.println(" cmyk 로  처리");
				try {
					imgSrc =  CMYKConverter.readImage(new File(Filepath));
					
				} catch (Exception e2) {
					//e2.printStackTrace();
					System.out.println("tt-======================================================================================-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
					imgSrc = com.tx.migration.controller.CMYKConverter.readImage(new File(Filepath));
				} 
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
	 		
	 	}

}
