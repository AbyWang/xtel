<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo user=(UserInfo)session.getAttribute("userInfo");
String userName=user.getUserName();
Integer userId=user.getUserId();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>修改密码</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="plug-in/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="view/main/css/public.css" media="all" />

</head>
<body class="childrenBody">
<form class="layui-form layui-row changePwd"  method="post">
	<div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
		<div class="layui-input-block layui-red pwdTips">新密码必须两次输入一致才能提交</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-block">
			    <input type="hidden" value="<%=userId%>"  id="userId"   class="layui-input">
			
				<input type="text" value="<%=userName%>" disabled id="userName" class="layui-input layui-disabled">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">旧密码 </label>
			<div class="layui-input-block">
				<input type="password" value="" placeholder="请输入旧密码" lay-verify="required|oldPwd" id="oldPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">新密码 </label>
			<div class="layui-input-block">
				<input type="password" value="" placeholder="请输入新密码 " lay-verify="required|newPwd" id="newPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码 </label>
			<div class="layui-input-block">
				<input type="password" value="" placeholder="请确认密码" lay-verify="required|confirmPwd"  id="confirmPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit lay-filter="changePwd">立即修改</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="plug-in/layui/layui.js"></script>
<script type="text/javascript" >
layui.use(['form','layer','laydate','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laydate = layui.laydate,
        laytpl = layui.laytpl,
        table = layui.table;
    //添加验证规则
    form.verify({
        newPwd : function(value, item){
            if(value.length < 6){
                return "密码长度不能小于6位";
            }
        },
        confirmPwd : function(value, item){
        	var newPwd=$("#newPwd").val().trim();
        	var confirmPwd=$("#confirmPwd").val().trim();
            if(newPwd!=confirmPwd){
                return "两次输入密码不一致，请重新输入！";
            }
        }

    })
    
     form.on('submit(changePwd)', function(data){
         $.ajax({
             url:"user/changePwd",
             type: "post",
             data: {userId:$("#userId").val(),
                 newPwd:$("#newPwd").val(),
                 oldPwd:$("#oldPwd").val()},
             success: function (info) {
                 layer.msg(info.message, {icon: info.code});
             }
         });

        });

    //控制表格编辑时文本的位置【跟随渲染时的位置】
    $("body").on("click",".layui-table-body.layui-table-main tbody tr td",function(){
        $(this).find(".layui-table-edit").addClass("layui-"+$(this).attr("align"));
    });
})

</script>


</body>
</html>