<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <!-- 사이트맵 -->
    <section id="site-map-wrap">
        <div class="inner1200">
        <c:forEach items="${menuList}" var="model" >
        	<c:if test="${model.MN_LEV eq '1' }">
        	<div class="row">
				<div class="tit-b">
						<h2><c:out value="${model.MN_NAME }"/></h2>	
				</div>			
				<div class="menu-b">
					<c:if test="${model.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU}">
					<ul class="menu-ul">						
						<c:forEach items="${ menuList}" var="model2">
							<c:if test="${(model.MN_KEYNO eq model2.MN_MAINKEY) && (model2.MN_LEV eq '2' ) }">
								<li>
								<a class="sbj1" href="javascript:;" onclick="pf_moveMenu('${model2.MN_URL}','${model2.MN_PAGEDIV_C }')"><c:out value="${model2.MN_NAME }"/></a>
								<c:if test="${model2.MN_PAGEDIV_C eq MENU_TYPE_SUBMENU}">
								<ul class="subMenu-ul">
									<c:forEach items="${ menuList}" var="model3">
										<c:if test="${(model2.MN_KEYNO eq model3.MN_MAINKEY) && (model3.MN_LEV eq '3' ) }">
											<li><a href="javascript:;" onclick="pf_moveMenu('${model3.MN_URL}','${model3.MN_PAGEDIV_C }')"><c:out value="${model3.MN_NAME }"/></a></li>
										</c:if>
									</c:forEach>
								</ul>
								</c:if>
								</li>							
							</c:if>
						</c:forEach>
					</ul>
					</c:if>
				</div>
             </div>       	
        </c:if>
        </c:forEach>
        </div>
    </section>
    <!-- 사이트맵 끝 -->