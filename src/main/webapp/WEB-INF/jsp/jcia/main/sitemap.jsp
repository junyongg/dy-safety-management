<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<!-- 본문 시작 -->
<div class="subContentInner">

	<div class="subTitle_SiteMap">
    	전남정보문화산업진흥원은 고객만족을 위해 더욱 노력하겠습니다.
    </div>

	<div class="siteMapWrap"> <!-- 사이트맵 시작 -->
    	
	   	<c:forEach items="${ menuList}" var="model">
	        <div class="col"> <!-- col Start-->
        		<c:if test="${model.MN_LEV eq '1' }">
	        		<a href="javascript:;" onclick="pf_moveMenu('${model.MN_URL}','${model.MN_PAGEDIV_C }')" title="${model.MN_NAME }"><h2><c:out value="${model.MN_NAME }"/></h2></a> 
	         	</c:if>
	            <ul class="mainSiteMap">
	            	<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU}">
			        	<c:forEach items="${ menuList}" var="model2">
				        	<c:if test="${(model.MN_KEYNO eq model2.MN_MAINKEY) && (model2.MN_LEV eq '2' ) }">
				        		<%-- <c:choose>
				        			<c:when test="${model2.MN_NAME eq '소개 및 연혁'}">
				        				<li>
				        					<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }"><c:out value="${model2.MN_NAME }"/></a>
				        					<ul class="subSiteMap">
			                                	<li><a href="javascript:;">현재~2015</a></li>
			                                	<li><a href="javascript:;">2014~2011</a></li>
			                                	<li><a href="javascript:;">2010~2007</a></li>
			                                </ul>
				        				</li>
				        			</c:when>
				        			<c:when test="${model2.MN_NAME eq '찾아오시는 길'}">
				        				<li>
				        					<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }"><c:out value="${model2.MN_NAME }"/></a>
				        					<ul class="subSiteMap">
			                                	<li><a href="javascript:;">전남정보진흥원</a></li>
			                                	<li><a href="javascript:;">전남실감미디어 산업지원센터</a></li>
			                                	<li><a href="javascript:;">전남콘텐츠기업 육성센터</a></li>
			                                	<li><a href="javascript:;">전남음악 창작소</a></li>
			                                	<li><a href="javascript:;">전남콘텐츠 코리아랩</a></li>
			                                	<li><a href="javascript:;">목포벤처문화사업 지원센터</a></li>
			                                </ul>
				        				</li>
				        			</c:when>
				        			<c:when test="${model2.MN_NAME eq '고객만족경영'}">
				        				<li>
				        					<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }"><c:out value="${model2.MN_NAME }"/></a>
				        					<ul class="subSiteMap">
			                                	<li><a href="javascript:;">전남정보문화산업 진흥원 고객서비스 헌장</a></li>
                                				<li><a href="javascript:;">전남정보문화산업 진흥원 고객서비스 이행표준</a></li>
			                                </ul>
				        				</li>
				        			</c:when>
				        			<c:when test="${model2.MN_NAME eq '계약정보공개'}">
				        				<li>
				        					<a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }"><c:out value="${model2.MN_NAME }"/></a>
				        					<ul class="subSiteMap">
			                    	            <li><a href="javascript:;">계약현황</a></li>
                                				<li><a href="javascript:;">수의계약현황</a></li>
			                                </ul>
				        				</li>
				        			</c:when>
				        			<c:otherwise> --%>
						        		<li><a href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')" title="${model2.MN_NAME }"><c:out value="${model2.MN_NAME }"/></a></li>
				        			<%-- </c:otherwise>
				        		</c:choose> --%>
				        	</c:if>
			       		</c:forEach>	
					</c:if>
	            	
	            </ul>
	        </div> <!-- col End-->
	   	</c:forEach>
    </div> <!-- 사이트맵 끝 -->
</div>
<!-- 본문 끝 -->
            