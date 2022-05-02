<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<script>
var beforeText = null;
var afterText = null;
$(function(){
	$(".beforeText").each(function(i){
		beforeText = $(this).text();
		afterText = beforeText.replace(/(<([^>]+)>)/gi, "");	//리스트에 태그제거
		$(this).text( afterText );
	});
});
</script>
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
				<option value="contents">${colTitle}+내용</option>
				<option value="writer">작성자</option>
				<option value="all">모두</option>
            </select>
            <label for="searchKeyword" class="blind">검색어를 입력해주세요</label>
            <input type="text" class=" txtDefault txtSearch" id="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어를 입력해주세요" name="searchKeyword" onkeydown="if(event.keyCode == 13) pf_boardSearch();">
            <button type="button" class="btnDefault btnSizeSearch btnBgBlue"  onclick="pf_boardSearch()">검색</button>
        </div>
    </div>
	
    <div class="tblBoardBox">
    	
    	<div class="reportListWrap">
            <c:set var="noticeCount" value="0"/>
			<c:forEach items="${BoardNoticeDataList }" var="model" varStatus="status">  
			
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
			   
        	<div class="row"> <!-- 한줄 -->                        	
                <div class="imgBox">
                	<a href="javascript:;" onclick="${detailFunction}">
                	<div class="innerImgBox">
                		<c:set value="${model.THUMBNAIL_PATH }" var="imgPath"/>
                    	<img src="/resources/img/upload/${imgPath }" alt="보고서 이미지">
                    </div>
                    </a>
                </div>
                
                <div class="contentBox">
                	<a href="javascript:;" onclick="${detailFunction}">
                		<h2><c:out value="${model.BN_TITLE }"/></h2>
                	</a> 
                    <h5 class="beforeText" style="visibility: visible;">
                    	<c:out value="${model.BN_CONTENTS }"/>
                    </h5>
                    <div class="bottomBox">
                    	<p class="dateBox"><c:out value="${fn:substring(model.BN_REGDT,0,10) }"></c:out></p>
                        <p class="departMentBox">
                        	<c:forEach items="${REPORT_BUSEO }" var="buseo">
	                        	<c:if test="${model.BN_KEYNO eq  buseo.BD_BN_KEYNO}">
	                        		<c:out value="${buseo.BD_DATA}"></c:out>
	                        	</c:if>
                        	</c:forEach>
                        </p>
                    </div>
                </div> 
                                          
            </div> <!-- 한줄 끝-->
            </c:forEach>
            
            <c:if test="${paginationInfo.totalRecordCount eq 0}">
            <div class="row"> <!-- 한줄 -->  
				 <div class="contentBox" style="width: 100%; padding: 0;">
					<p class="tbl_board_nodata" style="color: #777; text-align: center; padding: 2%;">내용없음</p>
				</div>
			</div>
			</c:if>
        </div>
    	
    	
    	
       <%--  <table class="tbl_Board_01 tbl_Board_notice">
            <caption>게시판</caption>
            <tbody>
            	<c:set var="noticeCount" value="0"/>
				<c:forEach items="${BoardNoticeDataList }" var="model" varStatus="status">
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
							<c:forEach items="${BoardColumnDataList }" var="bcdl">
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
			            			<td><c:out value="${bcdl.BD_DATA }" escapeXml="true"/></td>
			            			</c:otherwise>
			            		</c:choose>
								</c:if>	
							</c:forEach>
							<c:if test="${columnView eq 'false' }">
		            				<!-- 데이터가 없을경우 공백 뿌려줌 -->
		            				<td></td>
							</c:if>
						</c:if>
						</c:forEach>
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
    	</table> --%>
    </div>
    <c:if test="${userInfo.isAdmin eq 'Y'}">
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