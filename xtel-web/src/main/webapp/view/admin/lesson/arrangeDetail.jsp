<%@page import="com.cdxt.dl.web.sys.pojo.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>课程安排详情</title>
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<style type="text/css">
	body{ 
		margin:0; 
		padding:0;
	}
	span{
	color:#A8ACAF;
	font-family: MicrosoftYaHei;
	font-size: 14px;
	
	}
	
    textarea,input[type="text"],input[type="radio"]{
	 width:auto;
    display: inline-block;
    padding: 4px 6px;
    margin-bottom: 10px;
    margin-top: 10px;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    vertical-align: middle;
    background-color: rgb(255, 255, 255);
    box-shadow: rgba(0, 0, 0, 0.075) 0px 1px 1px inset;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(204, 204, 204);
    border-image: initial;
    transition: border 0.2s linear, box-shadow 0.2s linear;

   }
</style>
</head>

<body style="overflow-x: hidden;">
<div class="container">
	
	
	
	<div class="row">
	<div class="col-xs-12 col-md-12 col-sm-12 col-lg-12" style="margin-top: 0px;height:18px;padding-top:15px;margin-left:11px;">
				<span style="font-size: 13px;display: inline-block;">讲师</span>: <label id="dept" style="font-family: MicrosoftYaHei;font-size: 14px;display: inline-block;"></label>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</div>
		
        <hr style="color:red;margin-top:20px">


		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程名称:</span>
				<input type="text" id="name" name="name" value="${courseInfo.name}"  class="form-control"  readonly="readonly" />
	 			&nbsp;&nbsp;&nbsp;&nbsp;
	 			<span >总课时:</span>
				 <input type="text" id="totalClass"  name="totalClass"  value="${courseInfo.totalClass}"   class="form-control"  readonly="readonly"/>
	       	</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >价格:</span>
				<input type="text" id="price" name="price" value="${courseInfo.price}"   class="form-control"  readonly="readonly"/>
	 			&nbsp;&nbsp;&nbsp;&nbsp;
	 			<span >人数上限:</span>
				 <input type="text" id="numberOfExpected"  name="numberOfExpected"  value="${courseInfo.numberOfExpected}"   class="form-control"  readonly="readonly"/>
	       	</div>
		</div>		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程类型:</span>
				<label><input type="radio"  name="type"  value="0"   ${courseInfo.type==0? "checked=\"checked\"" : ""  } disabled><span >传统直播授课</span></input></label>
				 &nbsp;&nbsp;
				<label><input type="radio"  name="type"  value="1"  ${courseInfo.type==1? "checked=\"checked\"" : "" } disabled><span >智能授课</span></input></label>
	 		</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程简介:</span></br>
				     <textarea class="form-control"  rows="3" name="brief" readonly="readonly">${courseInfo.brief}</textarea>
				</div>
		</div>
		<hr color="#e1e5eb">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 0px;margin-left:11px;margin-bottom: 10px;">
				<span >排课安排:</span>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"  id="coursePlan" style="margin-left:-1px;">
				<c:forEach items="${courseInfo.coursePlan}" var="dto">
					<div id="${dto.id}" >
						&nbsp;&nbsp;&nbsp;&nbsp;
					 <span >开课时间:</span>
					 <input type="text" class="layui-input form-control"  value=<fmt:formatDate value="${Date(dto.time)}" pattern="yyyy-MM-dd　HH:mm:ss"/> readonly="readonly"  id="add_time"  />
					 </div>
				</c:forEach>
			</div>
		</div>
		
		<hr color="#eaeced">
	</div>
     <!-- Jquery组件引用 -->
     <script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
      <!-- Validform组件引用 -->
     <script type="text/javascript" src="plug-in/Validform/Validform_v5.3.2.js"></script> 
      <script type="text/javascript" src="plug-in/layui/layui.js"></script>   

</body>
</html>
