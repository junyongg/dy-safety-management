<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<form:form id="form" action="" method="post">
<input type="hidden" id="TH_KEYNO" name="TH_KEYNO" value="${hire.TH_KEYNO }" >
<input type="hidden" id="BN_TITLE" name="BN_TITLE" value="${bnData.BN_TITLE }" >
<input type="hidden" id="BN_DATE" name="BN_DATE" value="${bnData.BN_REGDT }" >
<section id="sub-content">
        <div class="inner1200"> <!--inner 시작 -->
            
            <!-- 서브 타이틀부분 -->
            <div class="sub-title-box">
                <h2>입사지원현황</h2>
                <ul class="list_ul">
                    <li class="home"><i class="xi-home"></i></li>
                    <li>열린광장</li>
                    <li>채용공고</li>
                    <li>입사지원현황</li>
                </ul>
            </div>


			<!-- 서브컨텐츠 시작 -->
			<div id="sub-con-start">

                <div class="board-s-box">
                    <div class="row t-bb">
                        <div class="left">
<!--                             <p><span class="icon"><i class="xi-file-o"></i></span> 총 85건, 1/15페이지</p> -->
                        </div>
                    </div>
                </div>

                <div class="info_table">
                    <table class="tbl_join_list">
                        <caption>입사지원현황</caption>
                        <colgroup>
                            <col style="width: 10%;">
                            <col style="width: 90%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>채용공고</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty hire.TH_BNKEYNO2 || hire.TH_PASS_YN eq 'N'}">
                            <tr>
                                <td>1</td>
                                <td class="content">
                                    <a href="javascript:;" class="a1">
                                    	<c:if test="${hire.THC_USE_YN eq 'N' }">
                                    		[임시저장]
                                    	</c:if>
                                    	${bnData.BN_TITLE }
                                    </a>
                                    <div class="date">최초등록일 ${hire.THC_INSERT_DATE }<span class="bord_line"></span> 수정등록일 ${hire.THC_UPDATE_DATE }</div>
                                    <div class="btn_box">
                                        <button type="button" class="btn_jo purple" onclick="UpdatePage();" title="지원서 수정">지원서 수정</button>
                                        <button type="button" class="btn_jo purple" onclick="PrintPage();" title="응시표출력">응시표출력</button>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                            <c:if test="${not empty hire.TH_BNKEYNO2 && hire.TH_PASS_YN eq 'Y'}">
                            <tr>
                                <td>1</td>
                                <td class="content">
                                    <a href="javascript:;" class="a1">
                                    	<span class="caNo">2차 공고</span>
                                    	${bnData.BN_TITLE }
                                    </a>
                                    <div class="date"></div>
                                    <div class="btn_box">
                                        <button type="button" class="btn_jo purple" onclick="fileInsert();" title="파일 등록">파일 등록</button>
                                        <button type="button" class="btn_jo purple" onclick="PrintPage();" title="응시표출력">응시표출력</button>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>


                <div class="gab70"></div>
			

			</div>

		</div> <!--inner 끝 -->
	</section>
</form:form>

<script>
function UpdatePage(){
	$("#form").attr('action','/hire/update.do');
	$("#form").submit();
}
function PrintPage(){
	$("#form").attr('action','/jact/hire/printPage.do');
	$("#form").submit();
}
function fileInsert(){
	$("#form").attr('action','/jact/hire/fileInsert.do');
	$("#form").submit();
}
</script>