<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo user=(UserInfo)session.getAttribute("userInfo");
Integer userId=user.getUserId();
String userName=user.getUserName();
session.setAttribute("userId", userId);
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<script src="js/DateFormat.js"></script> 
<script src="plug-in/layui/layui.js"></script>
<title>文库详情</title>
<style>
lable{
text-align:left

}
.article-type{
	display:inline-block;
	width: 26px;
    height: 26px;
    line-height:26px;
    text-align:center;
    border-radius:50%;
    border:1px solid #f4ced0;
    color:#ca0c16;
}
.likes-color{
color:red;
}
</style>
</head>

<body style="overflow-x: hidden;">
<div class="container-fluid">
	<form class="form-horizontal">
        <div>
        	  </br>
        	  	<input type="hidden" id="id" value="${article.id}"/>
        	  	<input type="hidden" id="time" value="${article.uploadTime}"/>
             	<div> <span class="article-type">原</span>&nbsp;&nbsp;${article.name}</div>
              <div>
              	<span id="uploadTime"></span>
              	<span style="margin-left:20px;">阅读数：${article.hits}</span>
              <li style="float:right;margin-right:5px;">
              <a id="btn_cacel" style="font-size:22px;text-decoration:none" href="javascript:history.go(-1)" type="button" class="glyphicon glyphicon-arrow-left"></a>&nbsp;&nbsp;
               <c:choose>
               		<!-- 判断当前用户是否点过赞 -->
					<c:when test="${fn:contains(article.articleGalRecordList,userId) }"> 
						<span onclick="onLikes();" id="likesColor" style="font-size:22px;cursor:pointer;" class="glyphicon glyphicon-thumbs-up likes-color"></span> 
				 	</c:when>
					<c:otherwise>
						<span onclick="onLikes();" id="likesColor" style="font-size:22px;cursor:pointer;" class="glyphicon glyphicon-thumbs-up"></span> 
					</c:otherwise> 
			</c:choose>
              &nbsp;&nbsp;<span id="likes">${article.likes}</span>
              </li>
              </div>
        </div>
		<hr style="color:red;">
        <div > 
           <div id="content" style="">${article.content}</div>
        </div>
   </form>
</div>
    <!-- Jquery组件引用 -->
    <script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
    <!-- Validform组件引用 -->
    <script type="text/javascript" src="plug-in/Validform/Validform_v5.3.2.js"></script> 
    <script type="text/javascript" src="plug-in/layui/layui.js"></script>  
    <script type="text/javascript" src="plug-in/wangEditor/release/wangEditor.min.js"></script>  
<script type="text/javascript">
  var path='<%=path%>';
  var layer;
  $(function(){
	  layui.use('layer', function(){
          layer= layui.layer;
        });
	   $("#uploadTime").html(changeDateFormat($("#time").val()));//日期转换
	   onHits();//实现阅读数添加
  });
 //点赞  
 function onLikes(){
	 var likesFlag=$("#likesColor").hasClass("likes-color");//判断是当前用户否点赞
	 var articleId=$("#id").val();
	 
	 $.ajax({
		 type:"post",
		 url:path+"/library/onLikes/"+articleId,
		 success:function(result){
			 if(result.code=="1"){
			 	 $("#likes").html(result.data);
				 if(likesFlag){//已点赞
					 $("#likesColor").removeClass("likes-color");
				 }else{
					 $("#likesColor").addClass("likes-color");
				 }
			 }
		 }
	 }); 
 }

 //阅读数
 function onHits(){
 	var articleId=$("#id").val();
	 $.ajax({
		 type:"post",
		 url:path+"/library/onHits/"+articleId,
		 success:function(result){
			console.log(result);
		 }
	 }); 
 }
</script>
</body>
</html>
