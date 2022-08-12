<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>
<%@ include file="/WEB-INF/jsp/setting/settingData.jsp"%>

<script src="/resources/api/mask/jquery.mask.js"></script>

<style>
.intro_menu li {
    width: 45%;
    padding: 0 20px;
    height: 400px;
    transition: all .25s ease;
    color : rgba( 62, 154, 129, 0.9 );
    cursor: pointer;
    list-style:none;
}

.intro_menu li a .txt_box h2 {
    color: #fff;
    font-size: 38px;
    font-weight: 600;
    transition: all .25s ease;
    font-family: 'GmarketSansMedium';
    margin-top: 25%;
    
}
.intro_menu li a .img_box {
    width: 100%;
    transition: all .25s ease;
    background-repeat: no-repeat;
    background-position: center center;
    background-size: 240px;
    background-color: rgba( 62, 154, 129, 0.9 );
}
.intro_content_box {
    width: 100%;
    width: 100%;
    height: calc(98vh - -6px);
/* 	background: url(/resources/img/safeAdmin/bg_login.jpg) no-repeat center center;  */
    background-size: cover;
    display: flex;
    align-items: center;

}
.right_btn{}

.image-box {
    height: 300px;
    background-image: url(/resources/img/safeAdmin/bg_main.jpg);
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    margin-top: 0px;
}
</style>
<meta name="viewport" content="width=device-width,initial-scale=1">
<form:form id="Form" name="Form" action="" method="post">
<input type="hidden" value="">
<div id="wrap">
    <div class="intro_content_box">
        <div class="in" style="margin-top: 0px;">
        <div class="image-box"></div>
            <div class="botto_box">
                <ul class="intro_menu" style ="justify-content: center;">
                    <li>
                        <a onclick="location.href='/sfa/safeAdmin/safeAdmin.do'" target="_blank" title="" class="left_btn">
                            <div class="txt_box">
                                <h2>안전 관리</h2>
                            </div>
                            <span class="black"></span>
                            <div class="img_box" style="" title=""></div>
                        </a>
                    </li>
                    <li>
                        <a onclick="location.href='/sfa/safeAdmin/billsAdmin.do'" target="_blank" title="" class="right_btn">
                            <div class="txt_box">
                                <h2>세금계산서</h2>
                            </div>
                            <span class="black"></span>
                            <div class="img_box" style="" title=""></div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>        
    </div>
</div>
</form:form>
