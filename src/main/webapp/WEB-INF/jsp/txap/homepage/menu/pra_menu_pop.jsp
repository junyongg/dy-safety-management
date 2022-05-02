<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<style>
div .dl-horizontal {margin-top:5px}
.dl-horizontal dt, .dl-horizontal dd {line-height: 30px;}
.dl-horizontal dt span{color:red;}
.url-input-span {float: left;display: block;line-height: 32px;padding-left:10px;color:#3276b1}
.url-input input{border: 0px !important;float: left;padding-left:0 !important;}


.authorityTable {max-height:300px;overflow-y:scroll}
.smart-form .radio:first-of-type {margin-left:0}
.checkbox-inline, .radio-inline {display:inline-block !important;}
.smart-form .checkbox:last-child, .smart-form .radio:last-child {margin-bottom:4px;}

.select2-selection__rendered {padding-left:5px !important;}
.pageRating, .pageRatingInfo, .gonggnogType{display:none;}
.menuPopWrap{overflow-y: scroll; max-height: 800px;}
.gonggongUL li{position:relative;margin:0;margin-bottom:2px;padding:0;min-height:60px;border-top:1px solid #dbdbdb;border-bottom:1px solid #dbdbdb;background:#f7f7f7;}
.gonggongUL li label{display:block;position:relative;margin:0;padding:20px 10px 20px 0;padding-left:280px;font-size:12px;color:#231f20;font-weight:bold;line-height:130%;cursor:pointer;}
.gonggongUL li input{position:absolute;left:10px;top:22px;z-index:10;}
.gonggongUL li:last-child label{display:inline-block;padding:20px 10px 20px 0;padding-left:45px;font-size:12px;color:#231f20;font-weight:bold;line-height:130%;cursor:pointer;}
</style>

<!-- 대메뉴 생성화면 레이어창 --> 
<div id="Mainmenu-insert" title="메뉴 추가">
	<div class="widget-body no-padding smart-form menuPopWrap">
		<br/>
		<fieldset>
			<div class="necessT">
		         <span class="colorR fs12">* 표시는 필수 입력 항목입니다.</span>
		     </div>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt><span>*</span> 메뉴명</dt>
					<dd>
					  <label class="input"> 
              			<i class="icon-append fa fa-question-circle"></i>
						    <input type="text" id="Mainmenu-insert-NAME" placeholder="메뉴명을 입력하세요" maxlength="50"/>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt><span>*</span> 정렬순서</dt>
					<dd>
<!-- 					<label class="input">  -->
<!-- 						<i class="icon-append fa fa-question-circle"></i> -->
						<select class="form-control input-sm" id="Mainmenu-insert-ORDER">
							<%-- <c:forEach begin="1" end="${fn:length(resultList)}" var="level">
								<option value="${level }" >${level }</option>
							</c:forEach> --%>
						</select>
						<!-- <input	type="text" placeholder="예시) 1" maxlength="2" id="Mainmenu-insert-ORDER"	onKeyDown="return cf_only_Num(event);">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 정렬순서는 반드시 숫자로 입력하셔야합니다.</b>
						</label> -->
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>영문메뉴명</dt>
					<dd>
					  <label class="input"> 
              			<i class="icon-append fa fa-question-circle"></i>
						    <input type="text" id="Mainmenu-insert-ENG-NAME" placeholder="영문메뉴명을 입력하세요" maxlength="50"/>
						    <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>담당자부서</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당자부서를 입력하세요" id="Mainmenu-insert-DEP" maxlength="50">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>컬러</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="컬러를 입력하세요" id="Mainmenu-insert-COLOR" maxlength="20">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>기타1</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="기타 컬럼1" id="Mainmenu-insert-DATA1"  maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>기타2</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="기타 컬럼2" id="Mainmenu-insert-DATA2" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>기타3</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="기타 컬럼3" id="Mainmenu-insert-DATA3" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
		</fieldset>
		<fieldset>
			<section class="col col-12">	
				<dl class="dl-horizontal">
					<dt><span>*</span> 페이지 형태</dt>
					<dd>
						<select class="form-control input-sm" id="Mainmenu-insert-PAGEDIV_C" onchange="pf_checkShowAndHide(this.value,'insert','0');">
						<c:forEach items="${menuList }" var="model">
							<option value="${model.SC_KEYNO }">${model.SC_CODENM }</option>
						</c:forEach>
						</select>
					</dd>
				</dl>
			</section>
			<section class="col col-12 Mainmenu-insert-SUBMENUBOX">
				<dl class="dl-horizontal">
		          <dt>소개 페이지</dt>
		          <dd>
					<label class="input" for="Mainmenu-insert-INTRO_URL">
						<i class="icon-append fa fa-question-circle"></i>
						<input type='text' id="Mainmenu-insert-INTRO_URL" maxlength="150">
					    <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 띄어쓰기 없이 영문과 숫자만으로 작성되어야되고, 마지막은 .do로 끝나야됩니다.</b>
					</label>
				  </dd>
		        </dl>
		        <dl class="dl-horizontal">
					<dd>
					* 소메뉴 클릭시 <br>
					&nbsp;&nbsp;소개 페이지 있을 경우 : 소메뉴 url + / + 소개페이지 url 로 연결 <br>
					&nbsp;&nbsp;소개 페이지 없을 경우 : 하위 첫번째 메뉴로 연결 
					</dd>
				</dl>
			</section>
			<section class="col col-12" id="Mainmenu-insert-BOARDTYPEBOX" style="display:none;">
				<dl class="dl-horizontal">
		          <dt>게시판 형태</dt>
		          <dd>
		            <select class="form-control input-sm" id="Mainmenu-insert-BOARDTYPE">
		              <option value="">게시판 선택</option>
		            <c:forEach items="${boardTypeList }" var="boardType">
		              <option value="${boardType.BT_KEYNO }">${boardType.BT_TYPE_NAME }</option>
		            </c:forEach>
		            </select>
		          </dd>
		        </dl>
		    </section>
			<section class="col col-12" id="Mainmenu-insert-URLBOX" name="Mainmenu-insert-URLBOX">
				<dl class="dl-horizontal">
					<dt><span>*</span> URL 입력</dt>
					<dd>
					<label class="input" for="Mainmenu-insert-URL">
						<div class="url-input" style="    border: 1px solid #BDBDBD;">
							<span class="url-input-span" id="Mainmenu-insert-preURL">/test/aaa/bbb</span>
							<i class="icon-append fa fa-question-circle"></i>
							<input type='text' id="Mainmenu-insert-URL" maxlength="150">
						    <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 소메뉴형은 띄어쓰기 없이 영문으로 작성되어야되고, 소메뉴형이 아닐경우 마지막은 .do로 끝나야됩니다.</b>
							<div class="clear"></div>
						</div>
					</label>
					</dd>
				</dl>
			</section>
				<!-- <dl class="dl-horizontal" style="display:none;">
					<dt>포워딩 URL 입력</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input type="text" placeholder="예시) /contents"  id="Mainmenu-insert-FWURL" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> URL은 /로 시작되어야 하고, 영문으로 작성되어야 합니다. 기존에 존재하는 메뉴 URL이어야됩니다.</b>
						</label>
					</dd>
				</dl> -->
			<section class="col col-12" id="Mainmenu-insert-LINKBOX" name="Mainmenu-insert-LINKBOX">
				<dl class="dl-horizontal">
					<dt><span>*</span> 링크 URL 입력</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="http://" id="Mainmenu-insert-LINKURL" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i>  http:// or https://를 붙여주세요</b>
						</label>
					</dd>
				</dl>
			</section>
		</fieldset>
		<c:if test="${menu.MN_HOMEDIV_C eq HOMEDIV_ADMIN }">
		<fieldset class="iconFiledset">
			<section class="col col-12"> 
						<input type="hidden" placeholder="font-awesome class 이름" maxlength="100" id="Mainmenu-insert-ICONBOX" name="Mainmenu-insert-ICONBOX">
	          <dl class="dl-horizontal">
	            <dt>
	              <div>메뉴 아이콘</div>
	              <div><i id="menuIconView_insert" class="fa fa-automobile"></i></div>
	            </dt>
	            <dd id="menuIconBox_insert">
	              <%@ include file="/WEB-INF/jsp/txap/homepage/menu/font_awesome_list_insert.jsp" %>
	            </dd>
	          </dl>
	      </section>
	    </fieldset>
	    </c:if>
	    <c:if test="${menu.MN_HOMEDIV_C ne HOMEDIV_ADMIN }">
    	<fieldset class="pageFiledset" style="padding: 25px 10px;">
    		<section class="col col-12">	
				<dl class="dl-horizontal">
					<dt>페이지평가 사용여부</dt>
					<dd>
						<label class="radio radio-inline">
							<input type="radio" class="RESEARCH" name="Mainmenu-insert-RESEARCH" value="Y">
							<i></i>사용</label>
						<label class="radio radio-inline">
							<input type="radio" class="RESEARCH" name="Mainmenu-insert-RESEARCH" value="N" checked="checked">
							<i></i>미사용</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRating">	
				<dl class="dl-horizontal">
					<dt>QR-CODE 표시여부</dt>
					<dd>
						<label class="radio radio-inline">
							<input type="radio" name="Mainmenu-insert-QRCODE" value="Y">
							<i></i>표시</label>
						<label class="radio radio-inline">
							<input type="radio" name="Mainmenu-insert-QRCODE" value="N" checked="checked">
							<i></i>숨김</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRating Mainmenu-insert-DEPARTMENTBOX">
		        <dl class="dl-horizontal">
		          <dt>담당자 선택</dt>
		          <dd>
		            <select class="form-control input-sm" id="Mainmenu-insert-DEPARTMENT" onchange="pf_chageDepartMentCategory('insert',this.value)">
		              <option value="">선택하세요.</option>
		            <c:forEach items="${homeDivList }" var="homeDivInfo">
		              <option value="${homeDivInfo.MN_KEYNO}">${homeDivInfo.MN_NAME}</option>
		            </c:forEach>
		            </select>
		          </dd>
		        </dl>
			</section>
			<section class="col col-6 pageRating Mainmenu-insert-DEPARTMENTBOX">
		        <dl class="dl-horizontal">
		          <dd style="margin-left:15px; width:220px;display: inline-block;">
		            <select class="form-control input-sm select2" id="Mainmenu-insert-DEPARTMENTUSER">
		              	<option value="">선택하세요.</option>
		            </select>
		          </dd>
	            <label class="checkbox radio-inline" style="float: right;">
				<input type="checkbox" class="Mainmenu-insert-DirectSelect" value="DU_0000000000" onclick="pf_directSelectForm('insert');">
				<i></i>직접입력</label>
		        </dl>
			</section>
			<section class="col col-12 pageRatingInfo">	
				<dl class="dl-horizontal">
					<dt>콘텐츠 담당부서</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당부서를 입력하세요." id="Mainmenu-insert-MANAGERDEP" maxlength="50">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRatingInfo">	
				<dl class="dl-horizontal">
					<dt>콘텐츠 담당자</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당자 이름을 입력하세요." id="Mainmenu-insert-MANAGER"  maxlength="50">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRatingInfo">	
				<dl class="dl-horizontal">
					<dt>담당자 연락처</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당자 연락처를 입력하세요." id="Mainmenu-insert-MANAGERTEL"  maxlength="20">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
		</fieldset>
		
		<fieldset class="pageFiledset">
    		<section class="col col-12">	
				<dl class="dl-horizontal">
					<dt>공공누리 사용여부</dt>
					<dd>
						<label class="radio radio-inline">
							<input type="radio" class="GONGGONGNULI" name="Mainmenu-insert-GONGNULI_YN" value="Y">
							<i></i>사용</label>
						<label class="radio radio-inline">
							<input type="radio" class="GONGGONGNULI" name="Mainmenu-insert-GONGNULI_YN" value="N" checked="checked">
							<i></i>미사용</label>
					</dd>
				</dl>
			</section>
			<section class="col col-12 gonggnogType">
		        <dl class="dl-horizontal">
		          <dt>공공누리 타입 선택</dt>
		          <dd>
		            <ul class="gonggongUL">
						<li>
							<input type="radio" name="Mainmenu-insert-GONGNULI_TYPE" class="Mainmenu-insert-koglType1" value="1" id="insert-koglType1"/>
							<label for="insert-koglType1">
							<img src="/resources/img/codetype/new_img_opencode1.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:149px;height:54px;" /> 
							1유형 : 출처표시 (상업적 이용 및 변경 가능)
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-insert-GONGNULI_TYPE" class="Mainmenu-insert-koglType2" value="2" id="insert-koglType2"/>
							<label for="insert-koglType2">
							<img src="/resources/img/codetype/new_img_opencode2.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:183px;height:54px;" />  
							2유형 : 출처표시 + 상업적이용금지
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-insert-GONGNULI_TYPE" class="Mainmenu-insert-koglType3" value="3" id="insert-koglType3" />
							<label for="insert-koglType3">
							<img src="/resources/img/codetype/new_img_opencode3.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:183px;height:54px;" />  
							3유형 : 출처표시 + 변경금지
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-insert-GONGNULI_TYPE" class="Mainmenu-insert-koglType4" value="4" id="insert-koglType4" />
							<label for="insert-koglType4">
							<img src="/resources/img/codetype/new_img_opencode4.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:219px;height:54px;" />  
							4유형 : 출처표시 + 상업적이용금지 + 변경금지
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-insert-GONGNULI_TYPE" class="Mainmenu-insert-koglType5" value="5" id="insert-koglType5" />
							<label for="insert-koglType5">
							<img src="/resources/img/codetype/new_img_opencode0.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:219px;height:54px;" />  
							자유이용 불가 (저작권법 제24조의2 제1항 제1호 ~ 4호 중 어느 하나에 해당됨)
							</label>
							<a href="http://www.law.go.kr/법령/저작권법" target="_blank" style="margin-left:10px;font-size:11px;color:#595959;font-family:'돋움', dotum;"> 
							<span style="font-size:10px;color:#595959;">▶</span> 해당사항 확인 (국가법령정보센터)</a>
						</li>
						<li class="gonggongBoard">
							<input type="radio" name="Mainmenu-insert-GONGNULI_TYPE" class="Mainmenu-insert-koglType6" value="0" id="insert-koglType6" />
							<label for="insert-koglType6">
							게시글 작성 시 직접선택
							</label>
						</li>
					</ul>
		          </dd>
		        </dl>
			</section>
		</fieldset>
		</c:if>
		
	</div>
</div>			
			
<!-- 대메뉴 수정화면 레이어창 -->
<div id="Mainmenu-update" title="메뉴 수정">
	<div class="widget-body no-padding smart-form">
		<input type="hidden" id="Mainmenu-update-MAINKEY" value="" maxlength="50">
		<input type="hidden" id="Mainmenu-update-BEFORE" value="" maxlength="50">
		<br/>
			<div class="necessT" style="margin-right: 3%;">
				 <span class="colorB fs12"><div>최종 수정자: <span id="Mainmenu-update-lastREGNM"></span></div> <div>최종 수정일: <span id="Mainmenu-update-lastREGDT"></span></div></span>
		    </div>
		<fieldset>
			<div class="necessT">
		         <span class="colorR fs12">*표시는 필수 입력 항목입니다.</span>
		    </div>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt><span>*</span> 메뉴명</dt>
					<dd>
						<label class="input"> 
	            			<i class="icon-append fa fa-question-circle"></i>
							<input  type="text" id="Mainmenu-update-NAME" value="" maxlength="50">
					  </label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt><span>*</span> 정렬순서</dt>
					<dd>
					<select class="form-control input-sm" id="Mainmenu-update-ORDER">
					</select>
					<!-- <label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="예시) 1" maxlength="2" id="Mainmenu-update-ORDER" onKeyDown="return cf_only_Num(event);">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 정렬순서는 반드시 숫자로 입력하셔야 합니다.</b>
						</label>
					</dd> -->
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>영문메뉴명</dt>
					<dd>
					  <label class="input"> 
              			<i class="icon-append fa fa-question-circle"></i>
						    <input type="text" id="Mainmenu-update-ENG-NAME" placeholder="영문메뉴명을 입력하세요" maxlength="50"/>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>담당자부서</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당자부서를 입력하세요" id="Mainmenu-update-DEP" maxlength="50">
						 
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>컬러</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="컬러를 입력하세요" id="Mainmenu-update-COLOR" maxlength="20">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>기타1</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="기타 컬럼1" id="Mainmenu-update-DATA1" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>기타2</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="기타 컬럼2" id="Mainmenu-update-DATA2" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6">	
				<dl class="dl-horizontal">
					<dt>기타3</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="기타 컬럼3" id="Mainmenu-update-DATA3" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
		</fieldset>
		<fieldset>
			<section class="col col-12">	
				<dl class="dl-horizontal">
					<dt><span>*</span> 페이지 형태</dt>
					<dd>
						<select class="form-control input-sm" id="Mainmenu-update-PAGEDIV_C">
						<c:forEach items="${menuList }" var="model">
							<option value="${model.SC_KEYNO }">${model.SC_CODENM }</option>
						</c:forEach>
						</select>
					</dd>
				</dl>
			</section>
			<section class="col col-12 Mainmenu-update-SUBMENUBOX">
				<dl class="dl-horizontal">
		          <dt>소개 페이지</dt>
		          <dd>
					<label class="input" for="Mainmenu-update-INTRO_URL">
						<i class="icon-append fa fa-question-circle"></i>
						<input type='text' id="Mainmenu-update-INTRO_URL" maxlength="150">
					    <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 띄어쓰기 없이 영문과 숫자만으로 작성되어야되고, 마지막은 .do로 끝나야됩니다.</b>
					</label>
				  </dd>
		        </dl>
		        <dl class="dl-horizontal">
					<dd>
					* 소메뉴 클릭시 <br>
					&nbsp;&nbsp;소개 페이지 있을 경우 : 소메뉴 url + / + 소개페이지 url 로 연결 <br>
					&nbsp;&nbsp;소개 페이지 없을 경우 : 하위 첫번째 메뉴로 연결 
					</dd>
				</dl>
			</section>
			<section class="col col-12"  id="Mainmenu-update-BOARDTYPEBOX" style="display:none;">
				<dl class="dl-horizontal">
		          <dt>게시판 형태</dt>
		          <dd>
		            <select class="form-control input-sm" id="Mainmenu-update-BOARDTYPE">
		              <option value="">게시판 선택</option>
		            <c:forEach items="${boardTypeList }" var="boardType">
		              <option value="${boardType.BT_KEYNO }">${boardType.BT_TYPE_NAME }</option>
		            </c:forEach>
		            </select>
		          </dd>
		        </dl>
			</section>
			<section class="col col-6 Mainmenu-update-TOURTYPEBOX">
		        <dl class="dl-horizontal">
		          <dt>카테고리</dt>
		          <dd>
		          	<select class="form-control input-sm" id="Mainmenu-update-TOURCATEGORY" onchange="pf_chageTourCategory('update',this.value)">
		              <option value="">카테고리 선택</option>
		            <c:forEach items="${tourInfoList }" var="tourInfo">
		              <option value="${tourInfo.SC_KEYNO }">${tourInfo.SC_CODENM }</option>
		            </c:forEach>
		            </select>
		          </dd>
		        </dl>
			</section>
			<section class="col col-6 Mainmenu-update-TOURTYPEBOX">
		        <dl class="dl-horizontal">
		          <dt>이름</dt>
		          <dd>
		            <select class="form-control input-sm" id="Mainmenu-update-TOURKEY">
		              <option value="">선택하세요.</option>
		            </select>
		          </dd>
		        </dl>
			</section>
			<section class="col col-12" id="Mainmenu-update-URLBOX">
				<dl class="dl-horizontal">
					<dt><span>*</span> URL 입력</dt>
					<dd>
					<label class="input" for="Mainmenu-update-URL">
						<div class="url-input" style="    border: 1px solid #BDBDBD;">
							<span class="url-input-span" id="Mainmenu-update-preURL">/test/aaa/bbb</span>
							<i class="icon-append fa fa-question-circle"></i>
							<input type='text' id="Mainmenu-update-URL" maxlength="150">
						    <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 소메뉴형은 띄어쓰기 없이 영문으로 작성되어야되고, 소메뉴형이 아닐경우 마지막은 .do로 끝나야됩니다.</b>
							<div class="clear"></div>
						</div>
					</label>
					</dd>
				</dl>
			</section>
				<!-- <dl class="dl-horizontal" style="display:none;">
					<dt><span>*</span> 포워딩 URL 입력</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="예시) /contents" id="Mainmenu-update-FWURL" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> URL은 /로 시작되어야 하고, 영문으로 작성되어야 합니다. 기존에 존재하는 메뉴 URL이어야됩니다.</b>
						</label>
					</dd>
				</dl> -->
			</section>
			<section class="col col-12" id="Mainmenu-update-LINKBOX" name="Mainmenu-update-LINKBOX">	
				<dl class="dl-horizontal">
					<dt><span>*</span> 링크 URL 입력</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input type="text" placeholder="http://"  id="Mainmenu-update-LINKURL" maxlength="150">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i>  http:// or https://를 붙여주세요</b>
						</label>
					</dd>
				</dl>
			</section>
		</fieldset>
		
		<c:if test="${menu.MN_HOMEDIV_C eq HOMEDIV_ADMIN }">
		<fieldset class="iconFiledset">
	      <section class="col col-12"> 
	          <input type="hidden" placeholder="font-awesome class 이름" maxlength="100" id="Mainmenu-update-ICONBOX" name="Mainmenu-update-ICONBOX">
	          <dl class="dl-horizontal">
	            <dt>
	              <div>메뉴 아이콘</div>
	              <div><i id="menuIconView_update" class="fa fa-automobile"></i></div>
	            </dt>
	            <dd id="menuIconBox_update">
	              <%@ include file="/WEB-INF/jsp/txap/homepage/menu/font_awesome_list_update.jsp" %>
	            </dd>
	          </dl>
	      </section>
	    </fieldset>
	    </c:if>
	    <c:if test="${menu.MN_HOMEDIV_C ne HOMEDIV_ADMIN }">
    	<fieldset class="pageFiledset" style="padding: 25px 10px;">
    		<section class="col col-12">	
				<dl class="dl-horizontal">
					<dt>페이지평가 사용여부</dt>
					<dd>
						<label class="radio radio-inline">
							<input type="radio" class="RESEARCH" name="Mainmenu-update-RESEARCH" value="Y">
							<i></i>사용
						</label>
						<label class="radio radio-inline">
							<input type="radio" class="RESEARCH" name="Mainmenu-update-RESEARCH" value="N" checked="checked">
							<i></i>미사용
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRating">	
				<dl class="dl-horizontal">
					<dt>QR-CODE 표시여부</dt>
					<dd>
						<label class="radio radio-inline">
							<input type="radio" name="Mainmenu-update-QRCODE" value="Y">
							<i></i>표시</label>
						<label class="radio radio-inline">
							<input type="radio" name="Mainmenu-update-QRCODE" value="N" checked="checked">
							<i></i>숨김</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRating Mainmenu-update-DEPARTMENTBOX">
		        <dl class="dl-horizontal">
		          <dt>담당자 선택</dt>
		          <dd>
		            <select class="form-control input-sm" id="Mainmenu-update-DEPARTMENT" onchange="pf_chageDepartMentCategory('update',this.value)">
		              <option value="">선택하세요.</option>
		            <c:forEach items="${homeDivList }" var="homeDivInfo">
		              <option value="${homeDivInfo.MN_KEYNO}">${homeDivInfo.MN_NAME}</option>
		            </c:forEach>
		            </select>
		          </dd>
		        </dl>
			</section>
			<section class="col col-6 pageRating Mainmenu-update-DEPARTMENTBOX">
		        <dl class="dl-horizontal">
		          <dd style="margin-left:15px; width:220px;display: inline-block;">
		            <select class="form-control input-sm select2" id="Mainmenu-update-DEPARTMENTUSER">
		              	<option value="">선택하세요.</option>
		            </select>
		          </dd>
	            <label class="checkbox radio-inline" style="float: right;">
				<input type="checkbox" class="Mainmenu-update-DirectSelect" value="DU_0000000000" onclick="pf_directSelectForm('update');">
				<i></i>직접입력</label>
		        </dl>
			</section>
			<section class="col col-12 pageRatingInfo">	
				<dl class="dl-horizontal">
					<dt>콘텐츠 담당부서</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당부서를 입력하세요." id="Mainmenu-update-MANAGERDEP"  maxlength="50">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRatingInfo">	
				<dl class="dl-horizontal">
					<dt>콘텐츠 담당자</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당자 이름을 입력하세요." id="Mainmenu-update-MANAGER"  maxlength="50">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
			<section class="col col-6 pageRatingInfo">	
				<dl class="dl-horizontal">
					<dt>담당자 연락처</dt>
					<dd>
					<label class="input"> 
						<i class="icon-append fa fa-question-circle"></i>
						<input	type="text" placeholder="담당자 연락처를 입력하세요." id="Mainmenu-update-MANAGERTEL"  maxlength="20">
						 <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 필요시 입력하세요.</b>
						</label>
					</dd>
				</dl>
			</section>
		</fieldset>
		
		<fieldset class="pageFiledset">
    		<section class="col col-12">	
				<dl class="dl-horizontal">
					<dt>공공누리 사용여부</dt>
					<dd>
						<label class="radio radio-inline">
							<input type="radio" class="GONGGONGNULI" name="Mainmenu-update-GONGNULI_YN" value="Y">
							<i></i>사용</label>
						<label class="radio radio-inline">
							<input type="radio" class="GONGGONGNULI" name="Mainmenu-update-GONGNULI_YN" value="N" checked="checked">
							<i></i>미사용</label>
					</dd>
				</dl>
			</section>
			<section class="col col-12 gonggnogType">
		        <dl class="dl-horizontal">
		          <dt>공공누리 타입 선택</dt>
		          <dd>
		            <ul class="gonggongUL">
						<li>
							<input type="radio" name="Mainmenu-update-GONGNULI_TYPE" class="Mainmenu-update-koglType1" value="1" id="update-koglType1"/>
							<label for="update-koglType1">
							<img src="/resources/img/codetype/new_img_opencode1.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:149px;height:54px;" /> 
							1유형 : 출처표시 (상업적 이용 및 변경 가능)
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-update-GONGNULI_TYPE" class="Mainmenu-update--koglType2" value="2" id="update-koglType2"/>
							<label for="update-koglType2">
							<img src="/resources/img/codetype/new_img_opencode2.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:183px;height:54px;" />  
							2유형 : 출처표시 + 상업적이용금지
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-update-GONGNULI_TYPE" class="Mainmenu-update-koglType3" value="3" id="update-koglType3"/>
							<label for="update-koglType3">
							<img src="/resources/img/codetype/new_img_opencode3.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:183px;height:54px;" />  
							3유형 : 출처표시 + 변경금지
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-update-GONGNULI_TYPE" class="Mainmenu-update-koglType4" value="4" id="update-koglType4"/>
							<label for="update-koglType4">
							<img src="/resources/img/codetype/new_img_opencode4.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:219px;height:54px;" />  
							4유형 : 출처표시 + 상업적이용금지 + 변경금지
							</label>
						</li>
						<li>
							<input type="radio" name="Mainmenu-update-GONGNULI_TYPE" class="Mainmenu-update-koglType5" value="5" id="update-koglType5"/>
							<label for="update-koglType5">
							<img src="/resources/img/codetype/new_img_opencode0.jpg" alt="" style="position:absolute;left:40px;top:2px;vertical-align:middle;width:219px;height:54px;" />  
							자유이용 불가 (저작권법 제24조의2 제1항 제1호 ~ 4호 중 어느 하나에 해당됨)
							</label>
							<a href="http://www.law.go.kr/법령/저작권법" target="_blank" style="margin-left:10px;font-size:11px;color:#595959;font-family:'돋움', dotum;"> 
							<span style="font-size:10px;color:#595959;">▶</span> 해당사항 확인 (국가법령정보센터)</a>
						</li>
						<li class="gonggongBoard">
							<input type="radio" name="Mainmenu-update-GONGNULI_TYPE" class="Mainmenu-update-koglType6" value="0" id="update-koglType6"/>
							<label for="update-koglType6">
							게시글 작성 시 직접선택
							</label>
						</li>
					</ul>
		          </dd>
		        </dl>
			</section>
		</fieldset>
		</c:if>
	</div>
</div>

<!-- 홈페이지 추가 모달창  -->
<div id="addNewHomepage" title="홈페이지 추가">
	<form:form action="" id="form_newHome" method="post"  enctype="multipart/form-data">
		<div class="widget-body no-padding smart-form">
			<fieldset>
				<div class="necessT">
			     	<span class="colorR fs12">홈페이지 추가시 개발자의 추가 작업이 필요합니다. 개발자에게 문의하여주세요.</span><br>
			        <span class="colorR fs12">* 표시는 필수 입력 항목입니다.</span>
				</div>
	     		<section class="col col-6"> 
	        		<dl class="dl-horizontal">
	          			<dt><span>*</span> 홈페이지명</dt>
	          			<dd>
							<label class="input"> 
	              				<i class="icon-append fa fa-question-circle"></i>
	                			<input class="checkTrim" type="text" name="MN_NAME" placeholder="홈페이지명을 입력하세요"/>
	            			</label>
	          			</dd>
	        		</dl>
	      		</section>
	      		<section class="col col-6"> 
	        		<dl class="dl-horizontal">
	          			<dt><span>*</span> 정렬순서</dt>
	          			<dd>
	          				<label class="input"> 
	            				<i class="icon-append fa fa-question-circle"></i>
	            				<input  type="text" placeholder="예시) 1" maxlength="2" name="MN_ORDER" onKeyDown="return cf_only_Num(event);">
	             				<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 정렬순서는 반드시 숫자로 입력하셔야합니다.</b>
	            			</label>
	          			</dd>
	        		</dl>
	      		</section>
	    	</fieldset>
	    	<fieldset>
	      		<section class="col col-6">  
        			<dl class="dl-horizontal">
         				<dt><span>*</span> 홈페이지 타이틀명</dt>
            			<dd>
            				<label class="input"> 
              					<i class="icon-append fa fa-question-circle"></i>
              					<input class="checkTrim" type="text" placeholder="홈페이지 타이틀명" maxlength="100" name="HM_TITLE">
               					<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> TITLE 태그에 들어갈 이름입니다.</b>
             					</label>
            			</dd>
        			</dl>
      			</section>
	      			
      			<section class="col col-6"> 
	        		<dl class="dl-horizontal popup_dl">
	          			<dt><span>*</span> 언어 선택</dt>
	          			<dd>
	          				<select class="form-control input-sm popup_select" name="HM_LANG">
			                <option value="ko">한국어</option>
			                <option value="en">영어</option>
			                <option value="ja">일본어</option>
			                <option value="zh">중국어</option>
			                <option value="ru">러시아어</option>
              			</select>
	          			</dd>
	        		</dl>
	      		</section>
	      		
	      		<section class="col col-12"> 
	          		<dl class="dl-horizontal popup_dl">
	            		<dt><span>*</span> 메뉴 깊이제한</dt>
	            		<dd>
	              			<select class="form-control input-sm popup_select" name="HM_MENU_DEPTH">
				                <option value="2">2단</option>
				                <option value="3">3단</option>
				                <option value="4">4단</option>
				                <option value="5">5단</option>
	              			</select>
	            		</dd>
	          		</dl>
	          		
	          		<dl class="dl-horizontal">
	          			<dt><span>*</span> 타일즈 이름</dt>
	            		<dd>
	            			<label class="input"> 
			              		<i class="icon-append fa fa-question-circle"></i>
			              		<input  type="text" placeholder="예시) tiles" class="exceptForm" maxlength="30" name="HM_TILES" onblur="pf_urlSetting(this);">
			               		<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 영문 소문자로 작성되어야 하고, 30자 제한입니다.</b>
              				</label>
	            		</dd>
	          		</dl>
	          		
	          		<dl class="dl-horizontal">
	            		<dt><span>*</span> 시작 URL 입력</dt>
	            		<dd>
	            			<label class="input"> 
	              				<i class="icon-append fa fa-question-circle"></i>
	              				<input  type="text" placeholder="예시) /tiles" maxlength="100" name="MN_URL" readonly="readonly">
	               				<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> URL은 /로 시작되어야 하고, 영문으로 작성되어야 합니다.</b>
              				</label>
	            		</dd>
	          		</dl>
	          		
	          		<dl class="dl-horizontal">
	          			<dt>대표 이미지</dt>
	            		<dd>
	            			<label class="input col col-6" style="padding: 0"> 
		              			<i class="icon-append fa fa-question-circle"></i>
		              			<input type="file" class="exceptForm" name="homeimg" id="homeimg" accept=".ico" 
		              			 onchange="cf_imgCheckAndPreview('homeimg','ico','1','','/resources/favicon.ico','F')">
		               			<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 대표이미지를 등록하세요.</b>
              				</label>
              				<div class="input col col-6" style="padding-top: 5px;">아이콘 : <img src="/resources/favicon.ico" id="homeimg_img" style="max-width: 20px;"></div>
			     		</dd>
		          		<dd>* 브라우저 왼쪽 상단에 나타나는 아이콘입니다. 파비콘(favicon)이라고 불리며 .ico 파일만 지원합니다. </dd>
	          		</dl>
	          		
	          		<dl class="dl-horizontal" style="margin-right: 12px;">
	            		<dt><span>*</span> 템플릿 설정</dt>
	            		<dd>
	              			<select class="form-control input-sm popup_select" name="template">
	              				<option value="">기본</option>
								<c:forEach items="${homeDivList }" var="model">
								<c:if test="${model.MN_KEYNO ne HOMEDIV_ADMIN }">
								<option value="${model.HM_TILES}">${model.MN_NAME }</option>
								</c:if>
								</c:forEach>
							</select>
	            		</dd>
	            		<dd>* 설정하신 템플릿으로 레이아웃을 생성합니다.</dd>
	          		</dl>
	          		
          		</section>
        	</fieldset>
	    	<fieldset>
      			<section class="col col-12">  
					<p style="text-align: center;font-size: 20px;">로그인시 권한별 시작 페이지</p>
	          		<c:forEach items="${authorityList }" var="auth" >
	          		<c:if test="${auth.UIA_NAME ne 'ANONYMOUS' }">
	          		<dl class="dl-horizontal">
	            		<dt>
	            			${auth.UIA_NAME }
	            			<input type="hidden" name="UIA_KEYNO" value="${auth.UIA_KEYNO }">
	            		</dt>
		            	<dd>
		            		<label class="input"> 
		              			<i class="icon-append fa fa-question-circle"></i>
		              			<input  type="text" class="exceptForm" placeholder="예시) /contents/index.do" maxlength="100" name="HAM_DEFAULT_URL" value="">
		               			<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> URL은 /로 시작되어야 하고, 영문으로 작성되어야 하고, .do로 끝나야됩니다.</b>
	              			</label>
		            	</dd>
	          		</dl>
	          		</c:if>
	          		</c:forEach>
	          		<dl class="dl-horizontal">
	          			<dd>* 공백으로 두시면 기본 디폴트 시작 페이지로 설정됩니다.(/시작url/index.do)</dd>
	          		</dl>
	      		</section>	
      		</fieldset>
	  	</div>
	  	<input class="exceptForm" type="hidden" name="MN_LEV" value="0"/>
	  	<input class="exceptForm" type="hidden" name="MN_REGNM" value="${userInfo.UI_KEYNO }" />
  	</form:form>
</div>

<!-- 홈페이지 수정 모달창  -->
<div id="modifyHomepage" title="홈페이지 수정">
	<form:form action="" id="form_modifyHome" method="post"  enctype="multipart/form-data">
  		<input class="exceptForm" type="hidden" name="HM_FAVICON" value="${homeData.HM_FAVICON }"/>
  		<input class="exceptForm" type="hidden" name="HM_KEYNO" value="${homeData.HM_KEYNO }"/>
    	<div class="widget-body no-padding smart-form">
      		<fieldset>
         		<div class="necessT">
					<span class="colorR fs12">! 표시는 개발자의 추가 작업이 필요합니다. 변경 시 개발자에게 문의하세요.</span><br>
			        <span class="colorR fs12">* 표시는 필수 입력 항목입니다.</span>
	     		</div>
        		<section class="col col-6"> 
          			<dl class="dl-horizontal">
            			<dt><span>*</span> 홈페이지명</dt>
            			<dd>
              				<label class="input"> 
                				<i class="icon-append fa fa-question-circle"></i>
                  				<input class="checkTrim" type="text" name="MN_NAME" placeholder="홈페이지명을 입력하세요" value="${homeData.MN_NAME }"/>
              				</label>
            			</dd>
          			</dl>
        		</section>
        		<section class="col col-6"> 
          			<dl class="dl-horizontal">
            			<dt><span>*</span> 정렬순서</dt>
            			<dd>
            				<label class="input"> 
              					<i class="icon-append fa fa-question-circle"></i>
              					<input  type="text" placeholder="예시) 1" maxlength="2" name="MN_ORDER" onKeyDown="return cf_only_Num(event);" value="${homeData.MN_ORDER }">
               					<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 정렬순서는 반드시 숫자로 입력하셔야합니다.</b>
              				</label>
            			</dd>
          			</dl>
        		</section>
      		</fieldset>
      		<fieldset>
       			<section class="col col-6"> 
        			<dl class="dl-horizontal">
         				<dt><span>*</span> 홈페이지 타이틀명</dt>
            			<dd>
            				<label class="input"> 
			              		<i class="icon-append fa fa-question-circle"></i>
			              		<input class="checkTrim" type="text" placeholder="홈페이지 타이틀명" maxlength="100" name="HM_TITLE" value="${homeData.HM_TITLE }"/>
			               		<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> TITLE 태그에 들어갈 이름입니다.</b>
             					</label>
            			</dd>
        			</dl>
      			</section>
      			
      			<section class="col col-6"> 
        			<dl class="dl-horizontal popup_dl">
         				<dt><span>*</span> 언어 선택</dt>
            			<dd>
            				<select class="form-control input-sm popup_select" name="HM_LANG">
				                <option value="ko" ${homeData.HM_LANG eq 'ko' ? 'selected':''}>한국어</option>
				                <option value="en" ${homeData.HM_LANG eq 'en' ? 'selected':''}>영어</option>
				                <option value="ja" ${homeData.HM_LANG eq 'ja' ? 'selected':''}>일본어</option>
				                <option value="zh" ${homeData.HM_LANG eq 'zh' ? 'selected':''}>중국어</option>
				                <option value="ru" ${homeData.HM_LANG eq 'ru' ? 'selected':''}>러시아어</option>
	              			</select>
            			</dd>
        			</dl>
      			</section>
      			
	        		<div class="clear"></div>
        		<section class="col col-12">  
	          		<dl class="dl-horizontal popup_dl">
	            		<dt><span>*</span> 메뉴 깊이제한</dt>
	            		<dd>
	            		<c:choose>
		            		<c:when test="${homeData.HM_TILES eq 'cf'}">
		            		${homeData.HM_MENU_DEPTH }단
		            		<input type="hidden" name="HM_MENU_DEPTH" value="${homeData.HM_MENU_DEPTH }">
		            		</c:when>
		            		<c:when test="${homeData.HM_TILES eq 'jcia'}">
		            		${homeData.HM_MENU_DEPTH }단
		            		<input type="hidden" name="HM_MENU_DEPTH" value="${homeData.HM_MENU_DEPTH }">
		            		</c:when>
		            		<c:when test="${fn:startsWith(homeData.HM_TILES,'template')}">
		            		${homeData.HM_MENU_DEPTH }단
		            		<input type="hidden" name="HM_MENU_DEPTH" value="${homeData.HM_MENU_DEPTH }">
		            		</c:when>
		            		<c:otherwise>
								<select class="form-control input-sm popup_select" name="HM_MENU_DEPTH"  >
					                <option value="2" ${homeData.HM_MENU_DEPTH eq 2 ? 'selected':''}>2단</option>
					                <option value="3" ${homeData.HM_MENU_DEPTH eq 3 ? 'selected':''}>3단</option>
					                <option value="4" ${homeData.HM_MENU_DEPTH eq 4 ? 'selected':''}>4단</option>
					                <option value="5" ${homeData.HM_MENU_DEPTH eq 5 ? 'selected':''}>5단</option>
				              	</select>	            		
		            		</c:otherwise>
		            	</c:choose>
	            		</dd>
	          		</dl>
	          		
	          		<dl class="dl-horizontal">
	          			<dt><span>!</span> 타일즈 이름</dt>
	            		<dd style="height:30px;">
	            			${homeData.HM_TILES }
	            	
			            	<%-- <label class="input"> 
			              		<i class="icon-append fa fa-question-circle"></i>
			              		<input  type="text" placeholder="예시) tiles" maxlength="30" name="HM_TILES" value="${homeData.HM_TILES }"/>
			               		<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 영문으로 작성되어야 하고, 30자 제한입니다.</b>
		              		</label> --%>
	            		</dd>
	          		</dl>
	          		
	          		<dl class="dl-horizontal">
	            		<dt><span>!</span> 시작 URL 입력</dt>
	            		<dd style="height:30px;">
	            			${homeData.MN_URL }
	            			<input type="hidden" name="MN_URL" value="${homeData.MN_URL }">
				            <%-- <label class="input"> 
				              <i class="icon-append fa fa-question-circle"></i>
				              <input  type="text" placeholder="예시) /contents" maxlength="100" name="MN_URL" value="${homeData.MN_URL }">
				               <b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> URL은 /로 시작되어야 하고, 영문으로 작성되어야 합니다.</b>
			              </label> --%>
	            		</dd>
	          		</dl>
	          		
	        		<dl class="dl-horizontal">
	          			<dt>대표 이미지</dt>
	            		<dd>
		            		<label class="input col col-6" style="padding: 0"> 
		              			<i class="icon-append fa fa-question-circle"></i>
		              			<input type="file" class="exceptForm" name="homeimg2" id="homeimg2" accept=".ico" 
		              			 onchange="cf_imgCheckAndPreview('homeimg2','ico','1','','/resources/favicon.ico','F')">
		               			<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> 대표이미지를 등록하세요.</b>
	              			</label>
	              			<div class="input col col-6" style="padding-top: 5px;">아이콘 : <img src="${homeData.HM_FAVICON }" onerror="this.src='/resources/favicon.ico'" id="homeimg2_img" style="max-width: 20px;"></div>
				     	</dd>
			          	<dd>* 브라우저 왼쪽 상단에 나타나는 아이콘입니다. 파비콘(favicon)이라고 불리며 .ico 파일만 지원합니다. </dd>
		          	</dl>
          		</section>
        	</fieldset>
      		<fieldset>
      			<section class="col col-12">  
          			<p style="text-align: center;font-size: 20px;">로그인시 권한별 시작 페이지</p>
	          		<c:forEach items="${authorityList }" var="auth" >
	          		<c:if test="${auth.UIA_NAME ne 'ANONYMOUS' }">
	          		<dl class="dl-horizontal">
	            		<dt>
	            			${auth.UIA_NAME }
	            			<input type="hidden" name="HAM_KEYNO" value="${auth.HAM_KEYNO }">
	            			<input type="hidden" name="UIA_KEYNO" value="${auth.UIA_KEYNO }">
	            		</dt>
		            	<dd>
		            		<label class="input"> 
		              			<i class="icon-append fa fa-question-circle"></i>
		              			<input  type="text" class="exceptForm" placeholder="예시) /contents/index.do" maxlength="100" name="HAM_DEFAULT_URL" value="${auth.HAM_DEFAULT_URL }">
		               			<b class="tooltip tooltip-top-right"> <i class="fa fa-warning txt-color-teal"></i> URL은 /로 시작되어야 하고, 영문으로 작성되어야 하고, .do로 끝나야됩니다.</b>
	              			</label>
		            	</dd>
	          		</dl>
	          		</c:if>
	          		</c:forEach>
	          		<dl class="dl-horizontal">
	          			<dd>* 공백으로 두시면 기본 디폴트 시작 페이지로 설정됩니다.(/시작url/index.do)</dd>
	          		</dl>
	      		</section>	
      		</fieldset>
    	</div>
  	</form:form>
</div>


<!-- 권한 관리 레이어창 --> 
<div id="Authority-manager" title="권한 관리">
	<div class="widget-body ">
		<ul id="authorityTab" class="nav nav-tabs bordered">
			<li class="active">
				<a href="#accessAuthority" data-toggle="tab" aria-expanded="true">접근 권한</a>
			</li>
		</ul>

		<div id="authorityTabContent" class="tab-content padding-10">
			<div class="tab-pane fade active in" id="accessAuthority">
				<div class="form-horizontal">
					<fieldset>
						<input type="hidden" name="M_KEYNO" value="UIR_0000000019">
						<div class="form-group">
							<label class="col-md-2 control-label authority-setting-name" style="font-size:17px;">접근 권한</label>
							<div class="col-md-10">
								<label class="radio radio-inline">
									<input type="radio" class="radiobox style-0" name="M_TYPE" class="M_TYPE" value="A" />
									<span>모두 허용</span> 
								</label>
								<label class="radio radio-inline">
									<input type="radio" class="radiobox style-0" name="M_TYPE" class="M_TYPE" value="B" />
									<span>관리자만 허용</span> 
								</label>
								<label class="radio radio-inline">
									<input type="radio" class="radiobox style-0" name="M_TYPE" class="M_TYPE" value="D" />
									<span>회원만 허용</span> 
								</label>
								<label class="radio radio-inline">
									<input type="radio" class="radiobox style-0" name="M_TYPE" class="M_TYPE" value="C" />
									<span>직접 설정</span> 
								</label>
							</div>
						</div>
						<div class="form-group authority-detail-setting">
							<div class="col-md-12 authorityTable">
								<table class="table table-bordered smart-form">
									<thead>
										<tr>
											<th style="width:15%">
												<!-- <select id="authority_check">
													<option value="">선택옵션</option>
													<option value="A">전체선택</option>
													<option value="B">관리자만</option>
													<option value="C">일반유저만</option>
													<option value="D">선택해제</option>
												</select> -->
												<label class="checkbox" style="padding-top:0;display: inline;">
													<input type="checkbox" name="authority_keyAll"><i></i>
												</label>전체 선택
											</th>
											<th style="width:20%;font-size:15px;">이름</th>
											<th style="font-size:15px;">유형</th>
											<th style="font-size:15px;">코멘트</th>
										</tr>
									</thead>
									<tbody>
										
									</tbody>							
								</table>
							</div>
						</div>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
</div>

