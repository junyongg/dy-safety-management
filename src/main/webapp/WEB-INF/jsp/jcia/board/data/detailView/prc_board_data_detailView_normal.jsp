<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
	 <!-- 본문 시작 -->
            <div class="subContentInner">
            	
                <div class="detailViewWrap"> <!-- 상세보기 시작 -->
                	
                    <div class="detail_titleBox" style="border-bottom: none; background-color: #ffffff;" ><!-- 타이틀 제목 -->
                    	<h2>
                    	<c:set var="now" value="<%=new java.util.Date() %>"/>
                    	<c:set  var="today"><fmt:formatDate value='${now}' pattern='yyyy-MM-dd' /></c:set>
                    	<c:if test="${BoardNotice.BN_IMPORTANT eq 'Y' && BoardNotice.BN_IMPORTANT_DATE >= today}">
	                    	<span class="notice">공지</span>
                    	</c:if>
                    	
                    	<c:out value="${BoardNotice.BN_TITLE}" escapeXml="true"/></h2>
                    </div>
                    
                    <div class="detail_infoBox_contract"> <!-- 게시판 정보 -->
                    	<table class="tbl_contractInfo" summary="${currentMenu.MN_NAME } 테이블 상세보기">
                        	<colgroup>
                            	<col width="15%">
                            	<col width="35%">
                            	<col width="15%">
                            	<col width="35%">
                            </colgroup>
                            <caption>${currentMenu.MN_NAME } 테이블</caption>
                            <thead></thead>
                            <tbody>
                           		<tr>
                                	<th scope="row">등록자</th>
                                	<td>${BoardNotice.BN_UI_NAME }</td>
                                	<th scope="row">등록일</th>
                                	<td>${fn:substring(BoardNotice.BN_REGDT,0,10) }</td>
                                </tr>
                      	        <c:set value="0" var="count"/>
                            	<c:forEach items="${BoardColumnList }" var="bcl">
							        <c:if test="${bcl.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE}">
									
								        <c:forEach items="${BoardColumnDataList }" var="model" varStatus="status">
								        <c:if test="${not empty model.BD_DATA && bcl.BL_KEYNO eq model.BD_BL_KEYNO}">	
								        	<c:set value="${count + 1 }" var="count"/>
								        	<c:if test="${(count mod 2 eq 1 )}">
		                            			<tr>
		                            		</c:if>
												<th scope="col">${model.COLUMN_NAME }</th>
												<c:choose>
													<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK }"><td>${fn:replace(model.BD_DATA,'|',',' ) }</td></c:when>
													<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }"><td>${fn:replace(model.BD_DATA,'|',',' ) }</td></c:when>
													<c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_LINK}">
								           				<td><a href="${model.BD_DATA }" target="_blank"><c:out value="${model.BD_DATA }" escapeXml="true"/></td></a>
								           			</c:when>
													<%-- <c:when test="${model.BD_BL_TYPE eq BOARD_COLUMN_TYPE_NOTICE_NUMBER}">
														<td><c:out value="${model.BD_DATA }" escapeXml="true"/></td>
														<th>조회수</th>
                                						<td>${BoardNotice.BN_HITS }</td>
                                						<c:set value="${count + 1 }" var="count"/>
													</c:when> --%>								           			
													<c:otherwise><td><c:out value="${model.BD_DATA } " escapeXml="true"/></td></c:otherwise>
												</c:choose>
											<c:if test="${count mod 2 eq 0 }">
		                            			</tr>
		                            		</c:if>	
										</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
								<c:if test="${count mod 2 eq 1 }">
<!-- 									<td colspan="2" style="border-left: none;"></td> -->
										<th scope="col">조회수</th>
                                		<td>${BoardNotice.BN_HITS }</td>
									</tr>
								</c:if>
                            
                            
                            <c:if test="${BoardType.BT_UPLOAD_YN eq 'Y' && fn:length(FileSub) gt 0 }">
                            <tr>
                               	<th scope="row">첨부파일</th>
                               	<td colspan="3">
			                    	<ul class="detailAttachUl">
			                    		<c:forEach items="${FileSub}" var="fs">
			                    			<c:if test="${BoardNotice.BN_THUMBNAIL ne fs.FS_KEYNO  }">
		                        				<c:choose>
				                    				<c:when test="${fs.FS_EXT eq 'hwp'}">
				                    					<c:set value="icon_hangeul_file.jpg" var="icon"/>
				                    					<c:set value="한글파일" var="icon_name"/>
				                    				</c:when>
				                    				<c:when test="${fs.FS_EXT eq 'pdf'}">
				                    					<c:set value="icon_pdf_file.jpg" var="icon"/>
				                    					<c:set value="pdf파일" var="icon_name"/>
				                    				</c:when>
				                    				<c:otherwise>
				                    					<c:set value="icon_normal_file.jpg" var="icon"/>
				                    					<c:set value="파일" var="icon_name"/>
				                    				</c:otherwise>
				                    			</c:choose>
		               						<a href="javascript:;" onclick="cf_download('${fs.FS_KEYNO }')"> 
												<li>
												<span class="icon"><img src="/resources/jcia/img/icon/${icon }"  alt="${icon_name }"></span>
												<span class="subject">${fs.FS_ORINM }</span>
												<c:if test="${fs.FS_FILE_SIZE / 1024  gt 1000}">
												(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 / 1024 }" pattern=".0"/>M)
												</c:if>
												<c:if test="${fs.FS_FILE_SIZE / 1000  le 1000}">
												(<fmt:formatNumber value="${fs.FS_FILE_SIZE / 1024 }" pattern=".0"/>K)
												</c:if> 
												</li>
											</a>
	                        				</c:if>
										</c:forEach>
			                        </ul>
			                    </td>
		                    </tr>
		                    </c:if>
                            </tbody>
                            <tfoot></tfoot>
                        </table>
                    </div>
                    
                    <div class="printBox">
			         	<ul class="text_size clearfix">
			             	<!-- <li class="text_print">
			                 	<a href="javascript:;" onclick="cf_print()"><img src="/resources/img/sub/img_subTopPrintFont_02_print.jpg" alt="인쇄"></a>
			                 </li> -->
			                 <li class="text_name">
			                 	<img src="/resources/img/sub/img_subTopPrintFont_02_fontSize.jpg" alt="폰트크기 글자">
			                 </li>
			             	<li class="text_increase">
			                 	<a href="javascript:;" onclick="pf_resizeFont('Pcontent','increase')" title="폰트크기 증가"><img src="/resources/img/sub/img_subTopPrintFont_02_fontSize_Plus.jpg" alt="폰트크기 증가 아이콘"></a>
			                 </li>
			             	<li class="text_decrease">
			                 	<a href="javascript:;" onclick="pf_resizeFont('Pcontent','decrease')" title="폰트크기 감소"><img src="/resources/img/sub/img_subTopPrintFont_02_fontSize_Minus.jpg" alt="폰트크기 감소 아이콘"></a>
			                 </li>
			             	<li class="text_reset">
			                 	<a href="javascript:;" onclick="pf_resizeFont('Pcontent','initial')" title="폰트크기 원상태로 되돌리기"><img src="/resources/img/sub/img_subTopPrintFont_02_fontSize_Reset.jpg" alt="폰트크기 되돌리기 아이콘"></a>
			                 </li>
			             </ul>
			         </div>
				         
                    <div class="datail_ContentBox"> <!-- 컨텐츠 내용 -->
                        <div>
                        	<c:if test="${currentMenu.MN_KEYNO eq BOARD_PROMOTE }">
	                        	<c:if test="${not empty FileSub }">
	                        		<c:forEach items="${FileSub }" var="model">
	                        			<img alt="${model.FS_ORINM }" src="${model.FS_PATH }">
	                        		</c:forEach>
	                        	</c:if>
                        	</c:if>
                        	<div class="Pcontent">
                            	<c:out value="${BoardNotice.BN_CONTENTS }" escapeXml="false"/>
                            </div>
                        </div>
                    </div>
                        
                   	<c:if test="${(userInfo.isAdmin eq 'Y') || (currentMenu.MN_KEYNO eq BOARD_INQUIRE && empty BoardNotice.BN_PARENTKEY)}">
                     <div class="btnUploadBox no_resize_font">
                     	<fmt:parseNumber value="${fn:substring(BoardNotice.BN_KEYNO, 4, 20)}" var="BN_KEYNO_NUMBERTYPE" />
	                     	<c:if test="${BoardNotice.BN_USE_YN eq 'Y' && ( not empty BoardNotice.BN_PWD || BoardNotice.BN_REGNM == userInfo.UI_KEYNO || userInfo.isAdmin eq 'Y') }">
								<button class="btnDefault bg_gray_01 btnSizeM_3 no_resize_font" type="button" onclick="pf_UpdateView('${BN_KEYNO_NUMBERTYPE}')">
							 		수정
								</button>
								<button class="btnDefault bg_gray_01 btnSizeM_3 no_resize_font" type="button" onclick="pf_deleteMove('${BN_KEYNO_NUMBERTYPE}')">
									삭제
								</button>
							</c:if>
	                    	
	                    	<c:if test="${userInfo.isAdmin eq 'Y' }">
	                     	<c:if test="${BoardType.BT_REPLY_YN eq 'Y' && BoardNotice.BN_IMPORTANT ne 'Y' && empty BoardNotice.BN_PARENTKEY}">
							<button class="btnDefault bg_gray_01 btnSizeM_3 no_resize_font" type="button" onclick="pf_replyWrite()">
								답글
							</button>
							</c:if>
							</c:if>
                    </div>
               		</c:if>
                	
                    <div class="detial_middleBtnBox"> <!-- 중간 목록보기 박스 -->
                    	<button type="button" class="btnBoardList" onclick="pf_back()">목록보기 <i class="fal fa-bars"></i></button>
                    </div>
                    
                    <div class="detail_nextPostBox"> <!-- 이전글 다음글 박스 -->
                    	<table class="tbl_next_Prev" summary="이전글 다음글 테이블">
                        	<colgroup>
                            	<col width="15%">
                            	<col width="85%">
                            </colgroup>
                            <caption>이전글 다음글</caption>
                            <thead></thead>
                            <tbody>
                            	<tr>
                                	<c:if test="${not empty nextBoardNotice }">
						    		<fmt:parseNumber value="${fn:substring(nextBoardNotice.BN_KEYNO,5,20)}" var="numberType" />
						    		<th scope="col">다음글</th>
						    		<td><a href="${tilesUrl}/Board/${numberType }/detailView.do"><c:out value="${nextBoardNotice.BN_TITLE }" escapeXml="true" ></c:out></a></td>
						            </c:if>
                                	<c:if test="${empty nextBoardNotice }">
						    		<th scope="col">다음글</th>
						    		<td><a href="javascript:;">다음글이 없습니다.</a></td>
						            </c:if>
						        </tr>
						        <tr>
						            <c:if test="${not empty prevBoardNotice }">
						            <fmt:parseNumber value="${fn:substring(prevBoardNotice.BN_KEYNO,5,20)}" var="numberType" />
						            <th scope="col">이전글</th>
						            <td><a href="${tilesUrl}/Board/${numberType }/detailView.do"><c:out value="${prevBoardNotice.BN_TITLE }" escapeXml="true" ></c:out></a></td>
						            </c:if>
						            <c:if test="${ empty prevBoardNotice }">
						            <th scope="col">이전글</th>
						            <td><a href="javascript:;">이전글이 없습니다.</a></td>
						            </c:if>
                                </tr>
                            </tbody>
                            <tfoot></tfoot>
                        </table>
                    </div>
                    
                
                </div> <!-- 상세보기 끝 -->
                
                
            </div>
            <!-- 본문 끝 -->