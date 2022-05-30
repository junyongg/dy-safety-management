<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf" %>

<jsp:useBean id="setting" class="com.tx.common.common.SettingData" scope="page"/>	

<c:set var="HOMEPAGE_LANGUAGE" value="<%=setting.HOMEPAGE_LANGUAGE %>"/>

<c:set var="HOMEDIV_TOUR" value="<%=setting.HOMEDIV_TOUR %>"/>
<c:set var="HOMEDIV_ADMIN" value="<%=setting.HOMEDIV_ADMIN %>"/>
<c:set var="HOMEDIV_CF" value="<%=setting.HOMEDIV_CF %>"/>
<c:set var="HOMEDIV_JCIA" value="<%=setting.HOMEDIV_JCIA %>"/>
<c:set var="HOMEDIV_JACT" value="<%=setting.HOMEDIV_JACT %>"/>
<c:set var="HOMEDIV_CULTURE" value="<%=setting.HOMEDIV_CULTURE %>"/>

<c:set var="SESSION_DURATION" value="<%=setting.SESSION_DURATION %>"/>

<c:set var="BOARD_PAGE_SIZE" value="<%=setting.BOARD_PAGE_SIZE %>"/>
<c:set var="BOARD_RECORD_COUNT_PER_PAGE" value="<%=setting.BOARD_RECORD_COUNT_PER_PAGE %>"/>

<c:set var="MENU_TYPE_PAGE" value="<%=setting.MENU_TYPE_PAGE %>"/>
<c:set var="MENU_TYPE_PAGE2" value="<%=setting.MENU_TYPE_PAGE2 %>"/>
<c:set var="MENU_TYPE_BOARD" value="<%=setting.MENU_TYPE_BOARD %>"/>
<c:set var="MENU_TYPE_LINK" value="<%=setting.MENU_TYPE_LINK %>"/>
<c:set var="MENU_TYPE_SUBMENU" value="<%=setting.MENU_TYPE_SUBMENU %>"/>
<c:set var="MENU_TYPE_TOUR" value="<%=setting.MENU_TYPE_TOUR %>"/>


<c:set var="BOARD_TYPE_LIST" value="<%=setting.BOARD_TYPE_LIST %>"/>
<c:set var="BOARD_TYPE_LIST_NO_DETAIL" value="<%=setting.BOARD_TYPE_LIST_NO_DETAIL %>"/>
<c:set var="BOARD_TYPE_GALLERY" value="<%=setting.BOARD_TYPE_GALLERY %>"/>
<c:set var="BOARD_TYPE_PUBLICATION" value="<%=setting.BOARD_TYPE_PUBLICATION %>"/>
<c:set var="BOARD_TYPE_CALENDAR" value="<%=setting.BOARD_TYPE_CALENDAR %>"/>
<c:set var="BOARD_TYPE_GALLERY_IMG" value="<%=setting.BOARD_TYPE_GALLERY_IMG %>"/>
<c:set var="BOARD_TYPE_LETTER" value="<%=setting.BOARD_TYPE_LETTER %>"/>
<c:set var="BOARD_TYPE_CULTURAL" value="<%=setting.BOARD_TYPE_CULTURAL %>"/>
<c:set var="BOARD_TYPE_SIGN" value="<%=setting.BOARD_TYPE_SIGN %>"/>
<c:set var="BOARD_TYPE_ACTIVE" value="<%=setting.BOARD_TYPE_ACTIVE %>"/>

<c:set var="BOARD_COLUMN_TYPE_TITLE" value="<%=setting.BOARD_COLUMN_TYPE_TITLE %>"/>
<c:set var="BOARD_COLUMN_TYPE_TEXT" value="<%=setting.BOARD_COLUMN_TYPE_TEXT %>"/>
<c:set var="BOARD_COLUMN_TYPE_CHECK" value="<%=setting.BOARD_COLUMN_TYPE_CHECK %>"/>
<c:set var="BOARD_COLUMN_TYPE_CHECK_CODE" value="<%=setting.BOARD_COLUMN_TYPE_CHECK_CODE %>"/>
<c:set var="BOARD_COLUMN_TYPE_RADIO" value="<%=setting.BOARD_COLUMN_TYPE_RADIO %>"/>
<c:set var="BOARD_COLUMN_TYPE_RADIO_CODE" value="<%=setting.BOARD_COLUMN_TYPE_RADIO_CODE %>"/>
<c:set var="BOARD_COLUMN_TYPE_SELECT" value="<%=setting.BOARD_COLUMN_TYPE_SELECT %>"/>
<c:set var="BOARD_COLUMN_TYPE_SELECT_CODE" value="<%=setting.BOARD_COLUMN_TYPE_SELECT_CODE %>"/>
<c:set var="BOARD_COLUMN_TYPE_CALENDAR" value="<%=setting.BOARD_COLUMN_TYPE_CALENDAR %>"/>
<c:set var="BOARD_COLUMN_TYPE_PWD" value="<%=setting.BOARD_COLUMN_TYPE_PWD %>"/>
<c:set var="BOARD_COLUMN_TYPE_EMAIL" value="<%=setting.BOARD_COLUMN_TYPE_EMAIL %>"/>
<c:set var="BOARD_COLUMN_TYPE_NUMBER" value="<%=setting.BOARD_COLUMN_TYPE_NUMBER %>"/>
<c:set var="BOARD_COLUMN_TYPE_LINK" value="<%=setting.BOARD_COLUMN_TYPE_LINK %>"/>
<c:set var="BOARD_COLUMN_TYPE_CALENDAR_START" value="<%=setting.BOARD_COLUMN_TYPE_CALENDAR_START %>"/>
<c:set var="BOARD_COLUMN_TYPE_CALENDAR_END" value="<%=setting.BOARD_COLUMN_TYPE_CALENDAR_END %>"/>


<c:set var="AUTHORITY_ADMIN" value="<%=setting.AUTHORITY_ADMIN %>"/>
<c:set var="AUTHORITY_ANONYMOUS" value="<%=setting.AUTHORITY_ANONYMOUS %>"/>

<c:set var="AUTHORITY_SUB_ALL" value="<%=setting.AUTHORITY_SUB_ALL %>"/>
<c:set var="AUTHORITY_SUB_BOARD" value="<%=setting.AUTHORITY_SUB_BOARD %>"/>
<c:set var="AUTHORITY_SUB_ETC" value="<%=setting.AUTHORITY_SUB_ETC %>"/>

<c:set var="AUTHORITY_ROLE_ACCESS" value="<%=setting.AUTHORITY_ROLE_ACCESS %>"/>
<c:set var="AUTHORITY_ROLE_READ" value="<%=setting.AUTHORITY_ROLE_READ %>"/>
<c:set var="AUTHORITY_ROLE_WRITE" value="<%=setting.AUTHORITY_ROLE_WRITE %>"/>
<c:set var="AUTHORITY_ROLE_UPDATE" value="<%=setting.AUTHORITY_ROLE_UPDATE %>"/>
<c:set var="AUTHORITY_ROLE_DELETE" value="<%=setting.AUTHORITY_ROLE_DELETE %>"/>
<c:set var="AUTHORITY_ROLE_REPLY" value="<%=setting.AUTHORITY_ROLE_REPLY %>"/>
<c:set var="AUTHORITY_ROLE_COMMENT" value="<%=setting.AUTHORITY_ROLE_COMMENT %>"/>

<c:set var="COLUMN_1" value="<%=setting.COLUMN_1 %>"/>
<c:set var="COLUMN_2" value="<%=setting.COLUMN_2 %>"/>
<c:set var="COLUMN_3" value="<%=setting.COLUMN_3 %>"/>
