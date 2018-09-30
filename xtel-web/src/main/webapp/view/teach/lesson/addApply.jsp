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
<title>我的课程</title>
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/layui/css/layui.css" rel="stylesheet" rel="stylesheet">
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

   .f-style{
     color:red;
    font-size:18px
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
       <form class="courseForm" method="post" >
		<div class="row">
			<div class="col-xs-12 col-md-12 col-sm-12 col-lg-12" style="margin-top: 0px;height:18px;padding-top:15px;margin-left:11px;">
				<span style="font-size: 13px;display: inline-block;">讲师</span>: <label id="dept" style="font-family: MicrosoftYaHei;font-size: 14px;display: inline-block;"><%=userName%></label>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</div>

        <hr style="color:red;margin-top:20px">

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程名称<span class="f-style">*</span>:</span>
				<input type="text" id="name" name="name"   class="form-control"  datatype="*" nullmsg="请输入课程名称!"   placeholder="请输入课程名称"/>
	 		  
	 			&nbsp;&nbsp;&nbsp;&nbsp;
	 			<span >总课时<span class="f-style">*</span>:</span>
				 <input type="text" id="totalClass"  name="totalClass"   datatype="/^[1-9]\d*$/"  nullmsg="请输入总课时"  errormsg="请输入小于100的整数"  class="form-control"  placeholder="请输入总课时"/>
	       	</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >价格<span class="f-style">*</span>:</span>
				<input type="text" id="price" name="price"  datatype="/^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$/" nullmsg="请输入正确的价格" errormsg="请输入数字"  class="form-control"  placeholder="请输入价格"/>
	 			&nbsp;&nbsp;&nbsp;&nbsp;
	 			<span >人数上限 <span class="f-style">*</span>:</span>
				 <input type="text" id="numberOfExpected"  name="numberOfExpected"  datatype="/^[1-9]\d*$/"  nullmsg="请输入人数上限"  errormsg="请输入正整数" class="form-control"  placeholder="请输入人数上限" />           
	       	</div>
		</div>		
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程类型<span class="f-style">*</span>:</span>
				<label><input type="radio"  name="type"  nullmsg="请选择类型"  datatype="*" value="0"><span >传统直播授课</span></input></label>
				 &nbsp;&nbsp;
				<label><input type="radio"  name="type"  value="1"><span >智能授课</span></input></label>
	 		</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程简介:</span></br>
				<textarea class="form-control" rows="3" id="brief"  name="brief"></textarea>
			</div>
		</div>
		<hr color="#e1e5eb">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 0px;margin-left:11px;margin-bottom: 10px;">
				<span >排课安排:</span>
				<button class="btn btn-link" type="button" onclick="addPlan()">添加</button><br/>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"  id="coursePlan" style="margin-left:-1px;">
        
                <span >开课时间<span class="f-style">*</span>:</span>
                 <div class="layui-input-inline" name="arrPlan" >
                 <input type="text" class="layui-input" id="add_time"  nullmsg="请选择开课时间"  datatype="*"  style="margin-right:50px"/>
                </div>
			  </div>

			</div>
		</div>
		<hr color="#eaeced">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 0px;text-align: right;margin-bottom: 5px;">
				<button class="btn btn-success" type="submit" id="btnSubmit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
  				<button class="btn btn-danger" type="button" id="btnClose">关闭</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</div>
		</form>
	</div> 
 
     <!-- Jquery组件引用 -->
     <script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
         <!-- Validform组件引用 -->
     <script type="text/javascript" src="plug-in/Validform/Validform_v5.3.2.js"></script> 
     <script type="text/javascript" src="plug-in/layui/layui.js"></script>  

<script type="text/javascript">
 function addPlan(){
	 var planHtml="";

	 planHtml+='<div class="layui-input-inline" name="arrPlan">',
	 planHtml+='<span >开课时间<span class="f-style">*</span>:</span>&nbsp;',
	 planHtml+="<input type='text' class='layui-input' nullmsg='请选择开课时间'  datatype='*'  id='add_time"+num+"'>",
	 planHtml+=" <button type='button' class='layui-btn  layui-btn-danger layui-btn-small' onclick='deleteElement(this);' style='margin-left: 50px;border-radius:20px;'>删除</button></div>"
     $("#coursePlan").append(planHtml);
	    layui.use('laydate', function(){
	          date=new Date();
	          var laydate = layui.laydate;
	          //执行一个laydate实例
	          laydate.render({
	            elem: '#add_time'+num, //指定元素
	            type: 'datetime',
	            min:'date',
	            value: date
	          });
	        });
	    num++;
   }
    var layer;
    var num = 1;
    
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
       $(".courseForm").Validform({
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
            	console.log(12);
            	doAdd();
            }
       });

    layui.use('laydate', function(){
    	  var laydate = layui.laydate;
    	   date=new Date();
    	  
    	  //执行一个laydate实例
    	  laydate.render({
    	    elem: '#add_time', //指定元素
    	    type: 'datetime',
            min:'date',
            value: date
    	  });
    	});
   });
	//关闭按钮功能实现
	$("#btnClose").bind('click',function(){
		//关闭窗口 lhgdiaglog方法
		//frameElement.api.close(); 
       var index = parent.layer.getFrameIndex(window.name);
       parent.layer.close(index);
	});

	/**
  	* 删除行
  	*/
  	function deleteElement(obj){
  		$(obj).parent().remove();
	}

  function doAdd(){	

	 var divArray=[];	
    //排课安排
    $("div[name='arrPlan']").each(function(){ //
        var trArr; //存行数据
       $("input",this).each(function(){ //便利行内的input 的值
      			 trArr=$(this).val();
        });
        divArray.push(trArr); //行数据格式
    });
    var param={
	      "name":$("#name").val(),
	      "totalClass":$("#totalClass").val(),
	      "price":$("#price").val(),
	      "numberOfExpected":$("#numberOfExpected").val(),
	      "name":$("#name").val(),
	      "type":$('input[name="type"]:checked').val(),
	      "brief":$("#brief").val(),
	      "divArrayStr":JSON.stringify(divArray)
	      };
    console.log(param);
    $.ajax({
	      type : 'POST',
	      url : "lessonCenterController/insertCourseInfo",
	      data: param,
          success : function(data) {
        		  layer.msg(data.message, {
        			  icon: data.code,
        			  time: 2000 //2秒关闭（如果不配置，默认是3秒）
        			}, function(){
        		          if(data.code=="1"){
        	                  //调用父窗口方法、刷新页面
        	              //   frameElement.api.opener.loadTable(1);
        	                  //关闭弹出窗口
        	              //   frameElement.api.close(); 
        		              var index = parent.layer.getFrameIndex(window.name);
        		              parent.layer.close(index);
        	              }
        			});   
         }
    });
};
	
</script>
</body>
</html>
