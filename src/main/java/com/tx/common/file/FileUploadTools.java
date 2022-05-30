package com.tx.common.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.tx.common.file.dto.FileSub;

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
public interface FileUploadTools{
	
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
	public FileSub FileUploadWithFile(File beforeFile, String REGNM, String FM_KEYNO) throws Exception;	
		   
	
	/**
	 * 네이버 스마트에디터2 용 파일 업로드
	 * @param request
	 * @param filename
	 * @return
	 * @throws Exception
	 */
	public String FileUploadWithSMARTEDITOR(HttpServletRequest request, String filename) throws Exception;
	
	/**
 	 * 하나의 파일을 업로드 한다.
 	 * + 기본크기 리사이즈
	 * @param file
	 * @param FS_FM_KEYNO 메인코드 키
	 * @param REGNM
	 * @return
	 */
	public FileSub FileUpload(MultipartFile file, String FS_FM_KEYNO, String REGNM,boolean isResize);

	/**
	 * 하나의 파일을 업로드 한다.
	 * + 입력값에 의한 리사이즈
	 * @param file
	 * @param FS_FM_KEYNO 메인코드 키
	 * @param REGNM
	 * @param width
	 * @param height
	 * @return
	 */
	public FileSub FileUpload(MultipartFile file, String FS_FM_KEYNO, String REGNM, int width, int height);
	
	/**
	 * 하나의 파일을 업로드 한다.
	 * @param file
	 * @param REGNM
	 * @param FileSub 파일키, ALT값, 리사이징/썸네일 생성 여부 등 파일정보 전반
	 * @return
	 */
	public FileSub FileUpload(MultipartFile file, String REGNM, FileSub FileSub);
	
	/**
 	 * 다중 파일을 업로드 한다.
 	 * + 리사이즈
 	 * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @param fileOpt 리사이즈/썸네일 생성 여부, 가로세로 크기 등 전달 DTO
 	 * @throws Exception
 	 */
	public FileSub FileUpload(HttpServletRequest request, String REGNM, FileSub fileOpt);
	
	/**
 	 * cnt번째 파일을 업로드 한다.
 	 * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @param cnt 업로드할 파일 번호 (1~)
 	 * @throws Exception
 	 */
	public FileSub imageUploadNthFileWithDefaultResizing(HttpServletRequest request, String REGNM, int cnt) throws Exception;
	
	/**
	 * 파일들을 업로드하고 이미지는 기본 썸네일을 생성한다.
	 * @param request
	 * @param FS_FM_KEYNO
	 * @param REGNM
	 * @return
	 * @throws Exception
	 */
	public FileSub FileUploadWithDefaultThumb(HttpServletRequest request, String FS_FM_KEYNO, String REGNM) throws Exception;
	
	/**
	 * 다중 파일을 업로드 하며 request로 함께 전달된 FileSub 리스트의 내용을 주입한다.
   * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
   * @param REGNM 등록자
   * @param count 업로드할 파일 번호(1~) / -1일 경우 다중파일 업로드
   * @param fileOpt FS_KEYNO, FS_FM_KEYNO, 리사이징/썸네일 생성 여부 및 가로세로 크기 값 저장 DTO
   * @return
   * @throws Exception
   */
  public FileSub FileUploadNthFile(HttpServletRequest request, String REGNM, int count, FileSub fileOpt, boolean isThumbnail) throws Exception;
	
	/**
 	 * ckeditor 이미지 업로드
 	 * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 */
	public FileSub ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile file, String REGNM);
	
	/**
 	 * DATA URI 데이터 기반으로 업로드 합니다
 	 * + 리사이즈 처리
 	 * @param imgInfo	해쉬맵으로 uri,title,ext 정보를 담고있음
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @throws Exception
 	 */
	public FileSub FileUploadByDataURI(HashMap<String, String> imgInfo, String FS_FM_KEYNO, String REGNM) throws Exception;
	
	
	/**
	 * 리사이즈 
 	 * 순번에 따른 리사이징 이미지를 업로드 한다.
 	 * height 0 일때는 height값 autoSizing
 	 * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
   * @param REGNM 등록자
   * @param cnt 파일번호
   * @param width 리사이즈 가로크기
   * @param height 리사이즈 높이
   * @return
   * @throws Exception
   */
  public FileSub resizeFileUpload(HttpServletRequest request, String FS_FM_KEYNO, String REGNM, int cnt, int width, int height) throws Exception;

  /**
	 * 리사이즈 
 	 * 순번에 따른 리사이징 이미지를 업로드 한다.
 	 * height 0 일때는 height값 autoSizing
 	 * @param request 요청
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param addFM_WHERE_KEY 호출하는 컨텐츠의 PK (참조용)
   * @param FM_COMMENTS 파일의 용도 및 목적 등
   * @param REGNM 등록자
   * @param cnt 파일번호
   * @param width 리사이즈 가로크기
   * @param height 리사이즈 높이
   * @return
   * @throws Exception
   */
  public FileSub resizeFileUpload(HttpServletRequest request, String FS_FM_KEYNO,
			String addFM_WHERE_KEY, String FM_COMMENTS, String REGNM, int cnt,
			int width, int height, boolean isThumbnail) throws Exception;

	/**
 	 * 업로드시 폴더 여부 확인 및 생성
 	 * @param Uploadpath
 	 */
	public String SaveFolder(String Uploadpath);
	
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
	public String setfilename();
	
	
	/**
	 * 이미지 변경 메소드
	 * @param FS_KEYNO
	 * @param req
	 * @param cnt 넘어온 파일 정보중 몇번째 파일인가
	 * @param resize 리사이즈 된 이미지 있는지 여부 
	 * @return
	 * @throws Exception
	 */
	public FileSub imageChange(String FS_KEYNO, HttpServletRequest req,String ID,int cnt,boolean resize,int width,int height, boolean isThumbnail) throws Exception;
	
	/**
	 * 이미지 변경 메소드
	 * @param FS_KEYNO
	 * @param file
	 * @param ID
	 * @return
	 * @throws Exception
	 */
	public FileSub imageChange(String FS_KEYNO, MultipartFile file,String ID,boolean resize) throws Exception;
	
	
	/**
 	 * QR-CODE 업로드
 	 * @param FS_FM_KEYNO 메인코드 키
 	 * @param REGNM 등록자
 	 * @throws Exception
 	 */
	public FileSub FileUploadByQrcode(BufferedImage bufferedImage, String FS_FM_KEYNO, String REGNM, String FILENAME);
	
	/**
 	 * XML 업로드
 	 * @param filename 파일이름
 	 * @param filepath 파일경로
 	 * @param REGNM 등록자
 	 * @throws Exception
 	 */
	public FileSub FileUploadByXML(String filename, String filepath, String REGNM) throws Exception;
	
	/**
	 * 업로드 파일 삭제 
	 */
	public void UpdateFileDelete(String file);
	
	/**
	 * 업로드 파일 삭제
	 * @param deletefile
	 */
	public void UpdateFileDelete(String deletefile[]);
	
	/**
	 * 이미지 파일 삭제 
	 * @param deletefile
	 */
	public void UpdateFileDelete(List<FileSub> imgList);

	/**
	 * favicon.ico 업로드
	 * @param thumbnail
	 * @param hm_TILES
	 * @return
	 */
	public String FaviconUpload(MultipartFile thumbnail, String hm_TILES) throws Exception;
	
	/**
	 * file의 mime type 리턴
	 * @param file
	 * @return mime-type or null
	 * @throws Exception
	 */
	public String getFileMimeType(File file) throws Exception;
	
	/**
	 * filePath에 존재하는 file의 mime type 리턴
	 * @param file
	 * @param filePath
	 * @return mime-type or null
	 * @throws Exception
	 */
	public String getFileMimeType(String filePath) throws Exception;


	public FileSub UpdateFileSub(HttpServletRequest requeset, FileSub fileSubNew);

	/**
	 * @param req
	 * @return
	 * List<FileSub> 다중으로 넘어온 FS_KEYNO(수정), FS_ALT, FS_COMMENTS
	 */
	public List<FileSub> getFileSubInfoList(HttpServletRequest req);
	
	/**
	 * 뷰 페이지에서 다중으로 넘어온 개별적인 FileSub 관련 request param을 List로 반환 
	 * @param req - 필수(!) : FS_ALT, FS_COMMENTS, 
	 * @param req - 옵션 : FS_FM_KEYNO, FS_KEYNO(수정), IS_RESIZE(RESIZE_WIDTH, RESIZE_HEIGHT),
	 *  IS_MAKE_THUMBNAIL(THUMB_WIDTH, THUMB_HEIGHT)
	 * @param fileLength 총 파일 개수
	 * @param count - 파일번호 (-1일 경우 req 파일 전체) 
	 * @return List<FileSub>
	 */
	public List<FileSub> getFileSubList(HttpServletRequest req, int fileLength, int count, boolean isThumbnail);


	/**
	 * 넘어온 FS_KEYNO 로 새로운 파일 생성
	 * @param FS_KEYNO
	 * @param fM_KEYNO
	 * @param REGNM
	 * @return
	 * @throws Exception
	 */
	public FileSub FileCopy(String FS_KEYNO, String FM_KEYNO, String REGNM) throws Exception;

	/**
	 * FILE_MAIN 데이터 생성
	 * @return FM_KEYNO
	 */
	public String makeFileMainData(String REGNM) throws Exception;


	public  String SaveFolder(String propertiespath, String pathDivision);


	public  String fileOverlapCheck(String uploadPath, String filename) ;


	public HashMap<String,Object> FileZip2(ArrayList<String> keylist, String filename) throws Exception;

	//채용관련 처리
	public FileSub FileUpload(MultipartFile file, String REGNM, FileSub fsVO, String type);


}
