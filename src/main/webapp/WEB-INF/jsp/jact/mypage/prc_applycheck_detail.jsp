<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<link rel="stylesheet" type="text/css" href="/resources/cf/css/program.css">
<style>
	.subRightContentsBottomWrap{
		width: 60%;
		margin: 0 auto;
	}
	.tbl_last_txtL tr th {
	    font-weight: normal;
		text-align: center;
		padding: 10px;
		border-bottom: 1px solid #dddddd !important;
		border-top: 1px solid #dddddd !important;
	}
	.tbl_01 td{
		text-align: left;
		padding-left: 15px;
		border-bottom: 1px solid #dddddd !important;
		border-top: 1px solid #dddddd !important;
	}
</style>
<section id="widget-grid" class="">
	<div class="receipt_pop_header"> 
		<div class="contents_pop_title" >투어 신청 내역</div> 
	</div>
	<!-- row -->
	<div class="row subRightContentsBottomWrap">
		<div class="row subImgFirstDiviceBox">
			<div class="centerBox" >	
				<div class="subRealTitleBox">
					<h1>기본내역</h1>
				</div>	
			</div>
		</div>
		
		<div class="subTableBox table_wrap_mobile">
			<table class="tbl_01 tbl_last_txtL">
				<colgroup>
					<col width="10%">
					<col width="25%">
				</colgroup>
				<caption>기본정보</caption>
				<tbody>
					<tr>
						<th>성명</th>	
						<td>${userInfo.UI_NAME }</td>	
					</tr>
					<tr>
						<th>휴대폰 번호</th>
						<td>${userInfo.UI_PHONE }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${userInfo.UI_EMAIL }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- row -->
	<div class="row subRightContentsBottomWrap">
		<div class="row subImgFirstDiviceBox">
			<div class="centerBox" >	
				<div class="subRealTitleBox">
					<h1>투어 신청 내역</h1>
				</div>	
			</div>
		</div>
		
		<div class="subTableBox table_wrap_mobile">
			<table class="tbl_01 tbl_last_txtL">
				<colgroup>
					<col width="10%">
					<col width="25%">
				</colgroup>
				<caption>기본정보</caption>
				<tbody>
					<tr>
						<th>구분</th>	
						<td>${applyData.GM_DIVISION } 코스</td>	
					</tr>
					<tr>
						<th>투어일시</th>
						<td>${applyData.GP_DATE } / ${applyData.GP_TIME }</td>
					</tr>
					<tr>
						<th>단체명</th>
						<td>${applyData.GP_GROUPNAME }</td>
					</tr>
					<tr>
						<th>참가인원</th>
						<td>${applyData.GP_HEADCOUNT }명</td>
					</tr>
					<tr>
						<th>인솔자</th>
						<td>${applyData.GP_NAME }</td>
					</tr>
					<tr>
						<th>인솔자 연락처</th>
						<td>${applyData.GP_PHONE }</td>
					</tr>
					<tr>
						<th>유모차/휠체어</th>
						<td>${applyData.GP_YUMOCAR } / ${applyData.GP_WHEELCHAIR } 개</td>
					</tr>
					<tr>
						<th>교통편</th>
						<td>
						<c:choose>
							<c:when test="${applyData.GP_TRAFFIC == 'C'}">
								대중교통
							</c:when>
							<c:when test="${applyData.GP_TRAFFIC == 'B'}">
								버스
							</c:when>
							<c:when test="${applyData.GP_TRAFFIC == 'E'}">
								${applyData.GP_TRAFFIC_EXP}
							</c:when>
						</c:choose>
						</td>
					</tr>
					<tr>
						<th>온라인 신청일자</th>
						<td>${applyData.GP_REGDT }</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 등록 박스 -->
		<div class="textR pdT15 " style="margin-bottom: 15px;">
			<input type="hidden" value="${applyData.GP_KEYNO }" id="GP_KEYNO" name="GP_KEYNO">
			<button type="button" class="btn btnSmall_red btn-default" onclick="pf_reservation_Cancel();">취소</button>
			<button type="button" class="btn btnSmall_blue btn-default" onclick="pf_reservation_Update();">수정</button>
			<button type="button" class="btn btnSmall_write btn-default" onclick="pf_close();">닫기</button>
		</div>
	</div>

</section>

<script>
function pf_close(){
	window.close();
}

var key = $('#GP_KEYNO').val();
function pf_reservation_Cancel(){
	if(confirm("예약을 취소하시겠습니까?")){
		$.ajax({
			url: '/cf/mypage/applycheck/applyCancel.do',
	        type: 'POST',
	        data:  {
	        	'GP_KEYNO' : key,
	        },
	        async: false,  
	        success: function() {
	        	alert("예약이 취소되었습니다.");
	        	opener.parent.location.reload();
	        	window.close();
	        },
	        error: function(){
	        	alert("에러, 관리자에게 문의하세요.");
	        }
		});
	}
}

function pf_reservation_Update(){
	key = cf_setKeyno(key);
	location.href='/cf/mypage/applycheck/applyUpdate.do?k='+key;
}
</script>