<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>
<link type="text/css" rel="stylesheet" href="/resources/css/common/board.css">

<article id="container" class="container_sub clearfix">
	<div class="inner">
		<div class="conSub01_bottomBox">
			<div class="innerContainer clearfix">
				<form:form id="Form" name="Form" method="post" action="/${tiles}/Board/move.do">
					<fmt:parseNumber value="${fn:substring(BoardNotice.BN_KEYNO, 4, 20)}" var="BN_KEYNO_NUMBERTYPE" />
					<input type="hidden" name="BN_KEYNO" value="${BoardNotice.BN_KEYNO }">
					<input type="hidden" name="BT_KEYNO" value="${BoardType.BT_KEYNO }">
					<input type="hidden" name="BN_TITLE" value="${BoardNotice.BN_TITLE }">
					<div class="boardUploadWrap">
					   	<div class="row lineheightBox">
					    	<p class="titleBox">
					        	<label>제목</label>
					        </p>
					        <p class="formBox">
					        	${BoardNotice.BN_TITLE }
					        </p>
					    </div>
					    <div class="row lineheightBox">
					    	<p class="titleBox">
					        	<label>게시판 타입</label>
					        </p>
					        <p class="formBox">
					        	${BoardType.BT_TYPE_NAME }
					        </p>
					    </div>
					    <div class="row">
					    	<p class="titleBox">
					        	<label for="MN_KEYNO">이동할 게시판</label>
					        </p>
					        <div class="formBox">
					        	<select name="MN_KEYNO" id="MN_KEYNO" class="txtDefault txtWlong_1">
									<option value="">선택하세요</option>
									<c:forEach items="${boardList }" var="model">
										<option value="${model.MN_KEYNO }">${model.MN_NAME }(${model.BT_TYPE_NAME })</option>
									</c:forEach>
								</select>
								<p class="thumbnailNote">괄호() 안은 게시판 타입 이름<br>게시판 타입이 다를경우 제목,본문,첨부파일을 제외한 데이터는 사라질수있습니다.</p>
					        </div>
					    </div>
					</div>
					<div class="btnBox textC">
						<button type="submit" class="btn btnBig_02" onclick="return pf_boardMove()">이동</button>
						<button type="button" class="btn btnBig_02" onclick="location.href='/${tiles}/Board/${BN_KEYNO_NUMBERTYPE}/detailView.do'">취소</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</article>

<script>

function pf_boardMove(){
	
	if(!$('#MN_KEYNO').val()){
		alert('이동할 게시판을 선택하여주세요.');
		$('#MN_KEYNO').focus();
		return false;
	}
	return true;
}

</script>