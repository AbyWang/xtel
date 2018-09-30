<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    <link href='css/googleapis.css' rel='stylesheet' type='text/css'>
	<link rel="shortcut icon" href="favicon.ico">
	<link rel="stylesheet" href="plug-in/bootstrap3.3.5/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/style1.css">

	</head>
	<body>
		<div class="container">
				<h2>信通远程教学平台</h2>

      			<div class="row">
				<div class="col-md-4 col-md-offset-4">
				<form  class="fh5co-form animate-box" data-animate-effect="fadeIn"  id="loginForm" check="<%=path%>/user/checkuser" role="form" action="<%=path%>/login"  method="post">
					
						<div class="form-group">
							<label for="username" class="sr-only">Username</label>
							<input type="text" class="form-control"  iscookie="true" name="loginname" id="loginname" placeholder="Username" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="password" class="sr-only">Password</label>
							<input type="password" class="form-control" iscookie="true" name="password" id="password" placeholder="Password" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="remember"><input type="checkbox" iscookie="true" class="ace" id="on_off"  name="remember" value="yes">记住密码</label>

						</div>
						<div class="form-group">
						     <a href="<%=path%>/toSignUp">注册</a>
							<input type="button" id="but_login"  value="登录"   onclick="checkUser()" class="btn btn-primary btn-lg">
						</div>
						    <div role="alert" class="form-group" id="errMsgContiner">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                   <div id="showErrMsg" style="color:red"></div>
                              </div>
					</form>
				</div>
			</div>
		</div>
	
	<script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="plug-in/jquery/jquery.cookie.js"></script>
	<!-- Bootstrap -->
	<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>

<script>
$(function(){
    getCookie();
    optErrMsg();
});

$("#errMsgContiner").hide();
function optErrMsg(){
    $("#showErrMsg").html('');
    $("#errMsgContiner").hide();
}


//输入验证码，回车登录
$(document).keydown(function(e){
    if(e.keyCode == 13) {
        $("#but_login").click();
    }
});

//验证用户信息
function checkUser(){
  if(!validForm()){
    return false;
  }
  newLogin();
}
//表单验证
function validForm(){
  if($.trim($("#loginname").val()).length==0){
    showErrorMsg("请输入用户名");
    return false;
  }

  if($.trim($("#password").val()).length==0){
    showErrorMsg("请输入密码");
    return false;
  }
  return true;
}

if (window != top) {
    top.location.href = location.href;
}

function newLogin() {
        setCookie();
        var actionurl=$('form').attr('action');//提交路径
        var checkurl=$('form').attr('check');//验证路径
        var formData = new Object();
        var data=$(":input").each(function() {
          formData[this.name] =$("#"+this.name ).val();
        });
        $.ajax({
          async : false,
          cache : false,
          type : 'POST',
          url : checkurl,// 请求的action路径
          data : formData,
          error : function() {// 请求失败处理函数
          },
          success : function(data) {
              console.log(data);
            if (data.success) {
                window.location.href = actionurl;
            }else{
                showErrorMsg(data.msg);
            }
          }
        });
}

//登录提示消息显示
function showErrorMsg(msg){ 
  $("#errMsgContiner").show();
  $("#showErrMsg").html(msg);    
  window.setTimeout(optErrMsg,5000); 
}


//设置cookie
function setCookie()
{
    console.log($('#on_off').is(':checked'));
    // 记住登录用户名---
    if ($('#on_off').is(':checked')) {
        console.log(123);
        $("input[iscookie='true']").each(function() {
            $.cookie(this.name, $("#"+this.name).val(), "/",24);
            $.cookie("COOKIE_NAME","true", "/",24);
        });
    } else {
        console.log(123);
        $("input[iscookie='true']").each(function() {
            $.cookie(this.name,null);
            $.cookie("COOKIE_NAME",null);
        });
    }
}
//读取cookie
function getCookie(){
       var COOKIE_NAME=$.cookie("COOKIE_NAME");
        if (COOKIE_NAME !=null) {
            $("input[iscookie='true']").each(function() {
                $($("#"+this.name).val( $.cookie(this.name)));
              });
            $("#on_off").attr("checked", true);
            $("#on_off").val("1");
        } 
        else
        {
            $("#on_off").attr("checked", false);
            $("#on_off").val("0");
        }
}
</script>
	</body>
</html>

