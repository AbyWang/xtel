<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>新增文库</title>
<style>
lable{
text-align:left

}

</style>
</head>

<body style="overflow-x: hidden;">
<div class="container-fluid">
<form class="form-horizontal" id="article">
        <div class="form-group">
 			<label class="col-sm-1 control-label">新增文库</label></br>
 			<hr style="color:red;">
              <label class="col-sm-1 control-label">文章名称:</label>
              <div class="col-sm-4">
               <input type='text' name="name" id="name"  class="form-control"  datatype="*" nullmsg="请输入文章名称!"   placeholder="请输入文章名称" />
               </div>
        </div>
        <div class="form-group"> 
           <label class="col-sm-1 control-label">文章内容:</label>
           </br>
           <div id="content" class="col-xs-12 col-sm-12 col-md-12 col-lg-12"></div>
        </div>
       <div id="option">
       </div>
      </div>
      <hr color="#eaeced">
      <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 0px;text-align: right;margin-bottom: 5px;">
                <button class="btn btn-success" type="submit" id="btnSubmit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
                <a id="btn_cacel" href="javascript:history.go(-1)" type="button" class="btn btn-danger btn-sm">关闭</a>&nbsp;'
            </div>
      </div>
    </form>
    <!-- Jquery组件引用 -->
    <script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
    <!-- Validform组件引用 -->
    <script type="text/javascript" src="plug-in/Validform/Validform_v5.3.2.js"></script> 
    <script type="text/javascript" src="plug-in/layui/layui.js"></script>  
    <script type="text/javascript" src="plug-in/wangEditor/release/wangEditor.min.js"></script>  
<script type="text/javascript">
  var path='<%=path%>';
  var layer;
  var E = window.wangEditor;
  var editor = new E('#content');
  editor.customConfig.uploadImgServer = 'filedeal?isup=1' ; // 上传图片到服务器，
  editor.customConfig.uploadImgHooks = {
        // （但是，服务器端返回的必须是一个 JSON 格式字符串！！！否则会报错）
        customInsert: function (insertImg, result, editor) {
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果：;
            var url = result.data;
            console.log(url);
            insertImg(url);
        },
      },
  editor.create();
  
  $(function(){
	  layui.use('layer', function(){
          layer= layui.layer;
          
        })
	  $.Tipmsg.r=null;
      //假定你的信息提示方法为showmsg， 在方法里可以接收参数msg，当然也可以接收到o及cssctl;
       var showmsg=function(msg){
    	   layer.msg(msg, {
    		   icon: 2,
    		   time: 2000 //2秒关闭（如果不配置，默认是3秒）
    		 })
       }
       $("#article").Validform({
            tiptype:function(msg,o,cssctl){
                if(!o.obj.is("form")){
                	 showmsg(msg);
                }
            },
            //表单提交时触发
            tipSweep:true,
            //ajax提交
            ajaxPost:true,
            callback:function(form){
            	doAdd();
            }
       }); 
  });

  function doAdd(){
		 $.ajax({
			    type:"post",
			 	url: path+'/library/addArticle',
			    data: {name:$("#name").val().trim(),content:editor.txt.html()},
			    success: function(data) {
		                  layer.msg(data.message, {
		                      icon: data.code,
		                      time: 2000 //2秒关闭（如果不配置，默认是3秒）
		                    }, function(){
		                          if(data.code=="1"){
		                              //调用父窗口方法、刷新页面
		                          //   frameElement.api.opener.loadTable(1);
		                              //关闭弹出窗口
		                          //   frameElement.api.close(); 
		                              //var index = parent.layer.getFrameIndex(window.name);
		                              //parent.layer.close(index);
		                        	  window.location.href='javascript:history.go(-1)';
		                          }
		                    });   
			    }
			}); 
	}
</script>
</body>
</html>
