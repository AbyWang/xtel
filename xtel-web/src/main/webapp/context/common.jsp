<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="plug-in/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="plug-in/bootstrap-table/bootstrap-table.css">
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="plug-in/jquery/js/jquery-1.9.1.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="plug-in/bootstrap/js/bootstrap.min.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
</html>