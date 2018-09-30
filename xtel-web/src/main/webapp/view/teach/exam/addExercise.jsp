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
<title>我的课程</title>
<style>
lable{
text-align:left

}
#div1{
    left: 10%;
}
</style>
</head>

<body style="overflow-x: hidden;">
<div class="container-fluid">
<form class="form-horizontal" id="exercises">
        <div class="form-group">
            <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12" style="margin-top: 0px;height:18px;padding-top:15px;margin-left:11px;">
                <span style="font-size: 13px;display: inline-block;">出题人</span>: <label id="dept" style="font-family: MicrosoftYaHei;font-size: 14px;display: inline-block;"><%=userName%></label>&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
        </div>

        <hr style="color:red;margin-top:20px">
        <div class="form-group">
               <label class="col-sm-2 control-label">习题类型:</label>
              <div class="col-sm-4">
               <select  class="form-control"  name="type" id="type" onchange="typeChange()">
                    <option value="">请选择</option>
                    <option value="0">选择题</option>
                    <option value="1">问答题</option>
                   <option value="2">填空题</option>
              </select>
             </div>
           <div class="form-group">
               <label class="col-sm-1 control-label">标签:</label>
              <div class="col-sm-4">
               <input type='text' class='form-control' name="brief" id="brief"/>
               </div>
            </div>
        </div>

         <div class="form-group hidden" id="optionNum"> 
              <label class="col-sm-2 control-label">选项个数:</label>
              <div class="col-sm-2">
              <select  class="form-control" name="numberOfOptions"  id="numberOfOptions" onchange="addOption()">
                    <option value="">请选择</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
              </select>   
          </div>
        </div>
        <div class="form-group"> 
           <label class="col-sm-2 control-label">题干:</label>
           </br> </br>
           <div id="div1" class="col-xs-10 col-sm-10 col-md-10 col-lg-10" >
           </div>
        </div>
       <div id="option">
       </div>
      </div>
      <hr color="#eaeced">
      <div class="row">
           <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 0px;text-align: center;margin-bottom: 5px;">
                <button class="btn btn-success" type="button" id="btnSubmit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="JavaScript:void(0);" class="btn btn-danger" onclick="history.go(-1)"><span>返回</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
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
   var E = window.wangEditor;
   var editor = new E('#div1');
   editor.customConfig.uploadImgServer = 'filedeal?isup=1' ; // 上传图片到服务器，
   editor.customConfig.uploadImgHooks = {
        // （但是，服务器端返回的必须是一个 JSON 格式字符串！！！否则会报错）
        customInsert: function (insertImg, result, editor) {
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果：;
            var url = result.data;
            insertImg(url);
        },
      },
   editor.create();
    
	//关闭按钮功能实现
	$("#btnClose").bind('click',function(){
		//关闭窗口 lhgdiaglog方法
		//frameElement.api.close(); 
       var index = parent.layer.getFrameIndex(window.name);
       parent.layer.close(index);
	});


	   //关闭按钮功能实现
    $("#btnClose").bind('click',function(){
        //关闭窗口 lhgdiaglog方法
        //frameElement.api.close(); 
       var index = parent.layer.getFrameIndex(window.name);
       parent.layer.close(index);
    });
	   
	 //提交 
   $("#btnSubmit").bind('click',function(){	
	   var formData=$("#exercises").serializeArray();
       formData.push({"name":"stem","value":editor.txt.text()});
	   var referenceAnswer="";  
	   $('input[name="answer"]:checked').each(function(){  
		   referenceAnswer=referenceAnswer+$(this).val()+"#";
	   });  
	   console.log(referenceAnswer);
	   formData.push({"name":"referenceAnswer","value":referenceAnswer})
	   
	  // append("referenceAnswer",referenceAnswer)
	   $.ajax({
		    url: 'examController/addExercise',
		    data: formData,
		    beforeSend: function(){
	              $("#btnSubmit").attr({ disabled: "disabled" });
	           },
		    success: function(data) {
	             layui.use('layer', function(){
	                  var layer = layui.layer;
	                  layer.msg(data.message, {
	                      icon: data.code,
	                      time: 2000 //2秒关闭（如果不配置，默认是3秒）
	                    }, function(){
	                          if(data.code=="1"){

	                        	   window.location.reload();
	                          }
	                    });   
	                });
		    },
	      complete: function () {
	               $("#btnSubmit").removeAttr("disabled");
	        },
		});
    });
   
   function typeChange(){
	   var type=$("#type").val();
	   //判断选项是否是选择题
	   if(type==0){
	     $("#optionNum").removeClass('hidden');
	   }else{
		 $("#optionNum").addClass('hidden');
		 $("#option").empty();
	   }
   }
  
   function addOption(){
	   $("#option").empty();
	   var num=$("#numberOfOptions").val();
	   var opHtml="";
	   var arr = ["A","B","C","D","E","F"]; 
	   for(var i=1;i<=num;i++){      
	       opHtml+="<div class='form-group' >";  
		   opHtml+="<label class='col-sm-2 control-label'>选项"+arr[i-1]+":</label>";
		   opHtml+="<div class='col-sm-8'><input type='text' class='form-control' name='option"+i+"' id='option"+i+"'/></div></div> "; 
	   
	   }
       opHtml+="<div class='form-group' ><label class='col-sm-2 control-label'>参考答案:</label>";  
       for(i=0,len=arr.length;i<num;i++){  
    	   opHtml+='<label class="checkbox-inline"><input type="checkbox" name="answer" value="'+arr[i]+'"/>'+arr[i]+'</label>&nbsp;&nbsp;&nbsp;'
       }
       opHtml+="</div>";
	  $("#option").append(opHtml);
   }
</script>
</body>
</html>
