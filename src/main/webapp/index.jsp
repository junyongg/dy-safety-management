<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
response.setStatus(301);
response.setHeader( "Location", "/jact/intro.do" );
response.setHeader( "Connection", "close" );
%>