<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<!-- 본문 시작 -->
<div class="subContentInner">
	
    <div class="boardTopWrap">
    	<div class="boardCountBox">
        	<p class="board_count">총 <span><fmt:formatNumber value="${paginationInfo.totalRecordCount }" pattern="#,###" /></span>개의 게시물이 있습니다.</p>
        	
        </div>
        
        <div class="searchBox">
        	<label for="searchCondition" class="labelSearch">검색</label>
            <select class="selectDefault searchSelect" title="검색 할 내용 선택" id="searchCondition" name="searchCondition"  >
            	<c:forEach items="${BoardColumnList }" var="model">
	           		<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}">
						<c:if test="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE }">
							<c:set var="colTitle" value="${model.BL_COLUMN_NAME }"/>
							<option value="title" selected>${model.BL_COLUMN_NAME }</option>
						</c:if>
						<c:if test="${model.BL_TYPE ne BOARD_COLUMN_TYPE_TITLE }">
							<option value="${model.BL_KEYNO }">${model.BL_COLUMN_NAME }</option>
						</c:if>
					</c:if>	
				</c:forEach>
				<c:if test="${Menu.MN_KEYNO ne COSTOMER_PRIVATE && Menu.MN_KEYNO ne COSTOMER_CONTRACT }">
				<option value="contents">${colTitle}+내용</option>
				</c:if>
				<c:if test="${Menu.MN_KEYNO ne COSTOMER_CONTRACT}">
				<option value="writer">작성자</option>
				</c:if>
				<option value="all">모두</option>
            </select>
            <label for="searchKeyword" class="blind">검색어를 입력해주세요</label>
            <input type="text" class=" txtDefault txtSearch" id="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어를 입력해주세요" name="searchKeyword" onkeydown="if(event.keyCode == 13) pf_boardSearch();">
            <button type="button" class="btnDefault btnSizeSearch btnBgBlue"  onclick="pf_boardSearch()">검색</button>
        </div>
    </div>
	
    <div class="tblBoardBox">
        <table class="tbl_Board_01 tbl_Board_notice" summary="${currentMenu.MN_NAME } 게시판">
            <caption>${currentMenu.MN_NAME } 게시판</caption>
            <thead>
                <tr>
                    <th class="number" scope="col">No</th>
                    <c:forEach items="${BoardColumnList }" var="model">
	            		<c:if test="${model.BL_LISTVIEW_YN eq 'Y'}">
							<th scope="col" class="${model.BL_TYPE eq BOARD_COLUMN_TYPE_TITLE ? 'boardSubject':'' }" width="${model.BL_TYPE eq  BOARD_COLUMN_TYPE_TITLE ? '43%' :  ''}">
								<c:out value="${model.BL_COLUMN_NAME }" />
							</th>
						</c:if>	
					</c:forEach>
					
					<c:if test="${Menu.MN_KEYNO eq BOARD_BUSI || Menu.MN_KEYNO eq BOARD_TENDER || Menu.MN_KEYNO eq BOARD_EMPLOY}">
						 <th scope="col"class="state" width="6%">상태</th>
					</c:if>
					<c:if test="${Menu.MN_KEYNO ne COSTOMER_CONTRACT && Menu.MN_KEYNO ne COSTOMER_PRIVATE}">
	                    <th scope="col" class="name">작성자</th>
		            	<th scope="col" class="date">작성일</th>
	                    <th scope="col" class="count">조회</th>
                    </c:if>
                </tr>
            </thead>
            <tbody>
            	<c:set var="noticeCount" value="0"/>
				<c:forEach items="${BoardNoticeDataList }" var="model" varStatus="status">
					<c:set var="stdt" value=""/>
					<c:set var="endt" value=""/>
					<fmt:parseNumber value="${fn:substring(model.BN_KEYNO, 4, 20)}" var="BN_KEYNO_NUMBERTYPE" />
					<c:choose>
						<c:when test="${model.BN_DEL_YN eq 'Y' }">
							<c:set var="detailFunction" value="alert('삭제된 게시물입니다.')"/>
						</c:when>
						<c:when test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y'}">
							<c:choose>
								<c:when test="${userInfo.isAdmin eq 'Y' || model.BN_REGNM eq userInfo.UI_KEYNO }">
									<c:set var="detailFunction" value="pf_DetailMove('${BN_KEYNO_NUMBERTYPE }')"/>
								</c:when>
								<c:when test="${not empty model.BN_PWD }">
									<c:set var="detailFunction" value="pf_openPWD('${BN_KEYNO_NUMBERTYPE}')"/>
								</c:when>
								<c:otherwise>
									<c:set var="detailFunction" value="pf_NotMyContents()"/>
								</c:otherwise>
							</c:choose>								 
						</c:when>
						<c:otherwise>
							<c:set var="detailFunction" value="pf_DetailMove('${BN_KEYNO_NUMBERTYPE }')"/>
						</c:otherwise>
					</c:choose>
					
					<tr class="${model.BOARD_TYPE eq 'NOTICE' ? 'boardNotice_Row':''}">
						<td class="number">
							<c:choose>
								<c:when test="${model.BOARD_TYPE eq 'NOTICE'}">
									<span class="notice">공지</span>
									<c:set var="noticeCount" value="${noticeCount + 1 }"/>
								</c:when>
								<c:otherwise>
									${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage  + status.index - noticeCount) }
								</c:otherwise>
							</c:choose>
						</td>
						<c:forEach items="${BoardColumnList }" var="bcl">
						
						<c:if test="${bcl.BL_LISTVIEW_YN eq 'Y'}">
							<c:set var="columnView" value="false"/>
							<c:forEach items="${BoardColumnDataList }" var="bcdl" varStatus="data_status">
			            		<c:if test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
				            		<c:set var="columnView" value="true"/>
				            		<c:choose>
				            			<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_TITLE}">
				            				<!-- 제목일 경우 -->
				            				<td class="boardSubject">
				            					<a href="javascript:;" onclick="${detailFunction}">
													<c:forEach begin="1" end="${model.BN_DEPTH }"></c:forEach>
													<c:if test="${BoardType.BT_SECRET_YN eq 'Y' && model.BN_SECRET_YN eq 'Y' }">
														<img src="/resources/img/icon/icon_lock.gif" alt="비밀글입니다.">
													</c:if>
													<c:if test="${model.BN_DEPTH gt 0 }">
														<span class="reply">답변</span>
													</c:if>
													
													<c:if test="${model.BN_DEL_YN eq 'N' }">
													<c:out value="${model.BN_TITLE}" escapeXml="true"/>
													</c:if>
													<c:if test="${model.BN_DEL_YN eq 'Y' }">
													<span style="color: #c8c8c8;font-size: 13px;">삭제된 게시물입니다.</span>
													</c:if>
													<c:if test="${BoardType.BT_COMMENT_YN eq 'Y' }">
														(${model.BN_BC_COUNT})
													</c:if>
													<c:if test="${model.BN_NEW eq '1' }">
														<img src="/resources/img/icon/icon_new.gif" alt="새글 이미지">
													</c:if>
													<c:if test="${model.BN_LINK gt 0 }">
														<img src="/resources/img/icon/icon_link.gif" alt="링크입니다.">
													</c:if>
													<c:if test="${BoardType.BT_UPLOAD_YN eq 'Y' && not empty model.BN_FM_KEYNO}">
														<img src="/resources/img/icon/icon_file.gif" alt="첨부파일 이미지">
													</c:if>
												</a>
											</td>
				            			</c:when>
				            			<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK || bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_CHECK_CODE }">
				            				<td>${fn:replace(bcdl.BD_DATA,'|',',' ) }</td>
				            			</c:when>
				            			<c:when test="${bcdl.BD_BL_TYPE eq BOARD_COLUMN_TYPE_LINK}">
				            				<td><a href="${bcdl.BD_DATA }" target="_blank"><c:out value="${bcdl.BD_DATA }" escapeXml="true"/></a></td>
				            			</c:when>
				            			<c:otherwise>
				            				<td>
				            					<c:out value="${bcdl.BD_DATA }" escapeXml="true"/>
			            					</td>
				            			</c:otherwise>
				            		</c:choose>
								</c:if>	
							</c:forEach>
							<c:if test="${columnView eq 'false' }">
		            				<!-- 데이터가 없을경우 공백 뿌려줌 -->
		            				<td></td>
							</c:if>
						</c:if>
						<c:if test="${(Menu.MN_KEYNO eq BOARD_BUSI || Menu.MN_KEYNO eq BOARD_TENDER || Menu.MN_KEYNO eq BOARD_EMPLOY) && bcl.BL_LISTVIEW_YN eq 'N'}">
							<c:forEach items="${BoardColumnDataList }" var="bcdl">
			            		<c:if test="${model.BN_KEYNO eq bcdl.BD_BN_KEYNO && bcdl.BD_BL_KEYNO eq bcl.BL_KEYNO}">
			            			<c:if test="${bcdl.BD_BL_KEYNO eq STDAT_BUSI || bcdl.BD_BL_KEYNO eq STDAT_TENDER || bcdl.BD_BL_KEYNO eq STDAT_EMPLOY}">
			            				<fmt:parseDate value="${bcdl.BD_DATA }" pattern="yyyy-MM-dd" var="BD_DATA" />
			            				<fmt:formatDate value="${BD_DATA}" pattern="yyyy-MM-dd" var="stdt" />
									</c:if>
									<c:if test="${bcdl.BD_BL_KEYNO eq ENDAT_BUSI || bcdl.BD_BL_KEYNO eq ENDAT_TENDER || bcdl.BD_BL_KEYNO eq ENDAT_EMPLOY}">
										<fmt:parseDate value="${bcdl.BD_DATA }" pattern="yyyy-MM-dd" var="BD_DATA" />
			            				<fmt:formatDate value="${BD_DATA}" pattern="yyyy-MM-dd" var="endt" />
									</c:if>
			            		</c:if>
							</c:forEach>
						</c:if>
						</c:forEach>
						<c:if test="${Menu.MN_KEYNO eq BOARD_BUSI || Menu.MN_KEYNO eq BOARD_TENDER || Menu.MN_KEYNO eq BOARD_EMPLOY}">
							<td class="state">
								<c:if test="${not empty stdt || not empty endt}">
									<c:choose>
										<c:when test="${nowDate < stdt }">
								 			<font color="gray">진행예정</font>
								 		</c:when>
								 		<c:when test="${stdt <= nowDate && nowDate <= endt }">
								 			<font color="blue">진행중</font>
								 		</c:when>
								 		<c:when test="${nowDate > endt }">
								 			<font color="red">진행마감</font>
								 		</c:when>
								 	</c:choose>
								</c:if>
								<c:if test="${stdt == null && endt == null}">
									
								</c:if>
							</td>
						</c:if>
						
						
						<c:if test="${Menu.MN_KEYNO ne COSTOMER_CONTRACT && Menu.MN_KEYNO ne COSTOMER_PRIVATE }">
							<td class="name"><c:out value="${model.BN_UI_NAME}"></c:out></td>
							<td class="date">
								<c:out value="${fn:substring(model.BN_REGDT,0,10) }"></c:out>
							</td>
							<td class="count"><c:out value="${model.BN_HITS}"></c:out></td>
						</c:if>
					</tr>
				</c:forEach>
				
            	<c:if test="${paginationInfo.totalRecordCount eq 0}">
					<tr>
						<td class="tbl_board_nodata" colspan="5" style="color: #777; text-align: center; padding: 2%;">내용없음</td>
					</tr>
					<script>
					$(function(){
						$('.tbl_board_nodata').attr('colspan',$('.tbl_Board_01 th').length);
					})
					</script>
				</c:if>
            </tbody>
            <tfoot></tfoot>
    	</table>
    </div>
   
    <c:if test="${Menu.MN_KEYNO eq BOARD_INQUIRE || (userInfo.isAdmin eq 'Y' && userInfo.MN_KEYNO ne BUSIMANAGE_KEY)}">
	    <div class="boardBtnBox"> <!-- 문의하기 글쓰기 버튼 -->
	        <button type="button" class="btnBoard_01" onclick="pf_RegistMove()">글쓰기</button>
	    </div>
    </c:if>
    <div class="pageNumberBox">
        <ul class="pageNumberUl">
           <ui:pagination paginationInfo="${paginationInfo }" type="normal_board" jsFunction="pf_LinkPage" />
        </ul>
    </div>
    
    
    
</div>
<!-- 본문 끝 -->