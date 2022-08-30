<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>
<style>
.headerdiv {
    width: 100%;
    height: 63px;
    background-color: #fff;
    display: flex;
    align-items: center;
    position: relative;
    z-index: 1000;
}
.btn_logout {
    vertical-align: middle;
    height: 36px;
    color: #fff;
    padding: 0 16px 0 35px;
    background: #3061AD no-repeat left 15px top 50%;
    border-radius: 30px;
    font-size: 14px;
    cursor: pointer;
    margin-left: 20px;
}
.rb {
    margin-left: auto;
    display: flex;
    align-items: center;
}
h1 > a{
    display: block;
    line-height: 0;
    }
ul {
	line-height: 50px;
}
ul > li{
   list-style:none;
   float: left;
   margin-right: 100px;
   font-weight: 800;
   }
   
ul > li > a{
    line-height: 50px;
    padding: 0 30px;
    font-size: 20px;
    color: #333333;
    transition: all .25s ease;
    min-width: 133px;
    text-align: center;
    text-decoration-line: none;
    }
a:hover{
	color: #2F62AD;
    font-weight: 800;
	}
ul > li.on > a{
	color: #2F62AD; font-weight: 800;
	}

header {
	background-color: #EEF1F8;
}
.menu_bar{
	position: absolute;
    left: 0;
    bottom: -2px;
    display: block;
    height: 4px;
    width: 0;
    background-color: #2F62AD;
    }
</style>
<meta name="_csrf_header" th:content="${_csrf.headerName}">
<meta name="_csrf" th:content="${_csrf.token}">
<div class="headerdiv">
	<h1><a onclick="location.href='/sfa/index.do'" style="cursor: pointer;"><img alt="" src="/resources/img/safeAdmin/bg_main2-1.png"></a></h1>       
        <nav id="gnb">
            <ul> 
      		<c:set var = "str" value = "${currentMenu.MN_NAME}"/>
            <c:if test="${fn:contains(str,'안전') }">	
				<li class="${currentMenu.MN_NAME eq '안전관리점검' ? 'on':''}"><a href="/sfa/safeAdmin/safeAdmin.do">안전관리</a></li>
                <li class="${currentMenu.MN_NAME eq '안전관리 현황' ? 'on':''}"><a href="/sfa/safeAdmin/safeAdminLog.do">안전관리 현황</a></li>
            </c:if>      
            <c:if test="${fn:contains(str,'세금') }">	
                <li class="${currentMenu.MN_NAME eq '세금계산서 유저' ? 'on':''}"><a href="/sfa/safeAdmin/billsUser.do">공급자, 공급받는자 등록</a></li>
                <li class="${currentMenu.MN_NAME eq '세금계산서' ? 'on':''}"><a href="/sfa/safeAdmin/billsAdmin.do">세금계산서 작성</a></li>
                <li class="${currentMenu.MN_NAME eq '세금계산서 전송현황' ? 'on':''}"><a href="/sfa/safeAdmin/billsAdminLog.do">세금계산서 전송현황</a></li>
            </c:if>
<!--                 <li class=""><a href="/dy/moniter/setting.do">설정</a></li> -->
<!--                 <li class="mobile"><a href="javascript:;" class="logout">Logout</a></li> -->
            </ul>
        </nav>
        <div class="rb">        
              <dl>
                	<dd class="user"><b>${userInfo.UI_ID }</b>님</dd>
              </dl>
              <c:if test="${userInfo.UI_NAME eq '개발자' }">
              <button type="button" onclick="location.href='/txap/index.do'" target="_blank" class="btn_logout">관리자페이지</button>
              </c:if>    
              <button type="button" onclick="location.href='/sfa/logout.do'" class="btn_logout">로그아웃</button>
        </div>
         <span class="menu_bar" style ="width: 100%;"></span>
</div>
