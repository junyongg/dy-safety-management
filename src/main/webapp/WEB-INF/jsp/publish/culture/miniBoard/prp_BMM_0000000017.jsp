<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
				<div class="col gallery">
					<div class="title-box">
						<h2>갤러리</h2>
						<button type="button" class="more"><i class="xi-plus-thin"></i></button>
					</div>
					
					<div class="main_gallery_board1">
						<ul class="main_gallery_ul">
						<c:forEach items="${resultList }" var="model">
                          <li>
                            <a href="javascript:;">
                              <div class="img_box"><img src="${model.BN_THUMBNAIL_SRC}" alt=""></div>
                              <div class="txt_box">${model.COLUMN77}</div>
                            </a>
                         </li>
                    </c:forEach>
						</ul>
					</div>
				</div>