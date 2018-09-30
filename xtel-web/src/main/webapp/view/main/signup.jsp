<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<%response.setHeader("Pragma","No-cache");  response.setHeader("Cache-Control","no-cache");  response.setDateHeader("Expires", 0);  response.flushBuffer();%> 
<!DOCTYPE html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>信通远程教学平台</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FreeHTML5.co" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
	

	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<link rel="shortcut icon" href="favicon.ico"/>
	<link href='css/googleapis.css' rel='stylesheet' type='text/css'/>
	<link rel="stylesheet" href="plug-in/bootstrap3.3.5/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/style1.css"/>
    <link rel="stylesheet" href="plug-in/select2/css/select2.min.css"/>
    <link href="plug-in/layui/css/layui.css" rel="stylesheet"/>
	</head>
	<body>
		<div class="container">
				<h2>信通远程教学平台</h2>
      			<div class="row">
				<div class="col-md-4 col-md-offset-4">
				<form  class="fh5co-form animate-box" data-animate-effect="fadeIn"  id="signupForm" method="post"  role="form"   action="<%=path%>/user/addUser">
				       <div class="form-group">
                        <select id="groupId" name="groupId" class="form-control" placeholder="群组">   
                            <option value=''>---请选择---</option>   
                            <c:forEach var="item" items="${group}">   
                            <option value='${item.ID}'>  
                             ${item.NAME}  
                             </option>   
                            </c:forEach>   
                         </select>  
                        </div>
						<div class="form-group">
							<label for="username" class="sr-only">Username</label>
							<input type="text" class="form-control"  id="userName"  name="userName" placeholder="Username" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="password" class="sr-only">Password</label>
							<input type="password" class="form-control" id="password" name="password"  placeholder="Password" autocomplete="off">
						</div>
						  <div class="form-group">
						  <label for="password" class="sr-only">Confirm</label>
                          <input type="password" class="form-control" id="confirm" name="confirm" placeholder="confirm" autocomplete="off" />
                         </div>

						<div class="form-group">
						     <a href="<%=path%>/toLogin">已经注册?登录</a>
							<input type="button" id="but_login"  value="注册"   onclick="signup()" class="btn btn-primary btn-lg">
						</div>
						    <div role="alert" class="form-group" id="errMsgContiner">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                   <div id="showErrMsg" style="color:red"></div>
                              </div>
					</form>
				</div>
			</div>
		</div>
	
	<script src="plug-in/jquery/jquery-1.9.1.js"></script>
	<!-- Bootstrap -->
	<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="plug-in/select2/js/select2.min.js"></script>
    <script src="plug-in/layui/layui.js"></script>
<script>
$(function(){
    
    optErrMsg();
    
});
$("#errMsgContiner").hide();
function optErrMsg(){
    $("#showErrMsg").html('');
    $("#errMsgContiner").hide();
}

//验证用户信息
function signup(){
  if(!validForm()){
    return false;
  }
  register();
}

//登录提示消息显示
function showErrorMsg(msg){ 
  $("#errMsgContiner").show();
  $("#showErrMsg").html(msg);    
  window.setTimeout(optErrMsg,5000); 
}

function register() {
    var actionurl=$('form').attr('action');//提交路径
    var formData = new Object();
    var data=$(":input").each(function() {
      formData[this.name] =$("#"+this.name ).val();
    });
   // $.extend(formData,{"groupId":$("#group").val()});
    console.log(formData);
    $.ajax({
      async : false,
      cache : false,
      type : 'POST',
      url : actionurl,// 请求的action路径
      data: formData,
      success : function(data) {
    	  console.log(data);
        if (data.code==1) {
        	
        	   layui.use('layer', function(){
        	          var layer = layui.layer;
        	          layer.msg('注册成功！', {
        	              icon: 1,
        	              time: 2000 //2秒关闭（如果不配置，默认是3秒）
        	            },function(){
        	            	window.location.href ="<%=path%>/toLogin";
        	            });   
        	        });   
        }else{
            showErrorMsg(data.message);
        }
      }
    });
}
//表单验证
function validForm(){
	
  if($.trim($("#groupId").val()).length==0){
	      showErrorMsg("请选择群组");
	      return false;
    }
  if($.trim($("#userName").val()).length==0){
    showErrorMsg("请输入用户名");
    return false;
  }
   var password=$.trim($("#password").val());
   var confirm=$.trim($("#confirm").val());
  if($.trim($("#password").val()).length==0){
    showErrorMsg("请输入密码");
    return false;
  }

  if(password!=confirm){
      showErrorMsg("两次密码不一致，请确认");
      return false;
  }
  

  
  return true;
}

//输入验证码，回车登录
$(document).keydown(function(e){
    if(e.keyCode == 13) {
        $("#but_login").click();
    }
});

 </script>
</body>
</html>

