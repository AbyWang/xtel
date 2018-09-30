<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="pragma"content="no-cache">
<metahttp-equiv="cache-control" content="no-cache">
<meta http-equiv="expires"content="0">
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>添加用户</title>

<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- Layer组件引用 -->
<script src="plug-in/layui/layui.js"></script>
<!-- 通用组件引用 -->
<script src="js/bootstrap-curdtools.js"></script>

</head>
<body>
<div class="layui-container">

   <form class="layui-form" id="addUserForm"  autocomplete="off" method="post" style="margin-top:10px">
				  <div class="layui-form-item">
					   <label class="layui-form-label" style="width: 100px">用户名</label>
					    <div class="layui-input-inline">
					      <input type="text" id="userName" name="userName" required placeholder="请输入用户名"  autocomplete="off" class="layui-input">
					    </div>
                   </div>
				  <div class="layui-form-item">
					    <label class="layui-form-label" style="width: 100px">密码</label>
					    <div class="layui-input-inline">
					      <input type="password" id="password"  name="password"   autocomplete="off" required placeholder="请输入密码"  class="layui-input">
					    </div>
				  </div>

				  <div class="layui-form-item">
				    <label class="layui-form-label" style="width: 100px">用户类型</label>
				    <div class="layui-input-inline">
				      <select id="userType" name="userType" required lay-search>
					       <option value="">请选择</option>
		                    <option value="0">系统管理员</option>
		                    <option value="1">群组管理员</option>
		                   <option value="2">普通用户</option>
				      </select>
    			</div>
 
		    <div class="layui-form-item">
					    <label class="layui-form-label" style="width: 100px">所属群组</label>
					    <div class="layui-input-inline">
					    <select id="groupId" name="groupId" required lay-search>
			                    <option value="">请选择</option>
			                    <c:forEach items="${groupInfoList}" var="group">
				                    <option value="${group.ID}">${group.NAME}</option>
			                    </c:forEach>
			              </select>
			              </div>
				  </div>
	<div class="layui-form-item">
    <div class="layui-input-block" style="text-align:center;">
    	<button class="layui-btn" type="button" id="btnSubmit" onclick="addUser();">提交</button>
      <button type="reset" id="btnClose" class="layui-btn layui-btn-primary">关闭</button>
    </div>
  </div>
</form>  
</div>
<script src="js/common.js"></script>
<script type="text/javascript" src="plug-in/Validform/Validform_v5.3.2.js"></script> 
<script type="text/javascript">
var path = "<%=path%>";
var layer;
//假定你的信息提示方法为showmsg， 在方法里可以接收参数msg，当然也可以接收到o及cssctl;
var showmsg=function(msg){
	   layer.msg(msg, {
		   icon: 2,
		   time: 2000 //2秒关闭（如果不配置，默认是3秒）
		 })
}

layui.use('form', function(){
	  var form = layui.form;
	  //监听提交
	  /*form.on('submit(saveClose)', function(data){
	    layer.msg(JSON.stringify(data.field));
	    return false;
	  });    */
});
	
$(function () {
	 layui.use('layer', function(){
         layer = layui.layer;
    });
	 $("#userName").val("");
     $("#password").val("");
}); 

//关闭按钮功能实现
$("#btnClose").bind('click',function(){
	//关闭窗口 lhgdiaglog方法
	//frameElement.api.close(); 
   var index = parent.layer.getFrameIndex(window.name);
   parent.layer.close(index);
}); 

//保存
function addUser(){
	var userName=$("#userName").val().trim();
	var password=$("#password").val().trim();
	if(userName==""){
		layer.msg("用户名必填!", {
            icon: 0,
            time: 2000 //2秒关闭（如果不配置，默认是3秒）
       });  
		return;
	}else if(password==""){
		layer.msg("请填写密码!", {
            icon: 0,
            time: 2000 //2秒关闭（如果不配置，默认是3秒）
       });  
		return;
	}else if(!checkIsPasswd(password)){//只能为数字跟字母，长度为6-12
		layer.msg("密码只能为数字字母,长度6-12!", {
            icon: 0,
            time: 2000 //2秒关闭（如果不配置，默认是3秒）
       });  
		return;
	}
	
	 $.ajax( {
		type : "POST",
		url : path+"/user/addUser",
		data : $("#addUserForm").serialize(),
		dataType:"json",
		success : function(data) {
			console.log(data);
			if(data.success){
				layer.msg(data.msg, {
	                icon: 1,
	                time: 2000 //2秒关闭（如果不配置，默认是3秒）
	             });  
				 var index = parent.layer.getFrameIndex(window.name);
				 parent.layer.close(index);
				$('#userInfo').bootstrapTable('refresh');
			}else{
				layer.msg(data.msg, {
	                 icon: 2,
	                 time: 2000 //2秒关闭（如果不配置，默认是3秒）
	            });  
			}
		}
	}); 
}
</script>
</body>
</html>
