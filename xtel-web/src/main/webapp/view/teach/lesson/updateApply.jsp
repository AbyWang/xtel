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
<title>修改课程申请</title>
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
		<form class="courseForm" method="post" >
       <input type="text" id="courseID" class="hidden"  name="courseID"  value="${courseInfo.courseID}"  />
		<div class="row">
			<div class="col-xs-12 col-md-12 col-sm-12 col-lg-12" style="margin-top: 0px;height:18px;padding-top:15px;margin-left:11px;">
				<span style="font-size: 13px;display: inline-block;">讲师</span>: <label id="dept" style="font-family: MicrosoftYaHei;font-size: 14px;display: inline-block;"><%=userName%></label>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
		</div>

        <hr style="color:red;margin-top:20px">

		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程名称:</span>
				<input type="text" id="name" name="name"  value="${courseInfo.name}" datatype="*" nullmsg="请输入课程名称!"  class="form-control"  placeholder="请输入课程名称"/>
	 			&nbsp;&nbsp;&nbsp;&nbsp;
	 			<span >总课时:</span>
				 <input type="text" id="totalClass"  name="totalClass"  value="${courseInfo.totalClass}" datatype="/^[1-9]\d*$/"  nullmsg="请输入总课时"  errormsg="请输入小于100的整数"  class="form-control"  placeholder="请输入总课时"/>
	       	</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >价格:</span>
				<input type="text" id="price" name="price"  value="${courseInfo.price}"  datatype="/^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$/" nullmsg="请输入正确的价格" errormsg="请输入数字"  class="form-control"  placeholder="请输入价格"/>
	 			&nbsp;&nbsp;&nbsp;&nbsp;
	 			<span >人数上限:</span>
		       <input type="text" id="numberOfExpected"  name="numberOfExpected"  value="${courseInfo.numberOfExpected}"  datatype="/^[1-9]\d*$/"  nullmsg="请输入人数上限"  errormsg="请输入正整数" class="form-control"  placeholder="请输入人数上限"  />           
	       	</div>
		</div>		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程类型:</span>
				<label><input type="radio"  name="type"   ${courseInfo.type==0? "checked=\"checked\"" : ""  }  nullmsg="请选择类型"  datatype="*" value="0"><span >传统直播授课</span></input></label>
				 &nbsp;&nbsp;
				<label><input type="radio"  name="type"   ${courseInfo.type==1? "checked=\"checked\"" : "" } value="1"><span >智能授课</span></input></label>
	 		</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
				<span >课程简介:</span></br>
				<textarea class="form-control" rows="3" id="brief" name="brief">${courseInfo.brief}</textarea>
			</div>
		</div>
		<hr color="#e1e5eb">
		
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 0px;margin-left:11px;margin-bottom: 10px;">
				<span >排课安排:</span>
				<button class="btn btn-link" type="button" onclick="addPlan()">添加</button><span >(点击提交后才正式生效)</span><br/>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"  id="coursePlan" style="margin-left:-1px;">    
              <div class="layui-input-inline" name="arrPlan" >
	            <c:forEach items="${courseInfo.coursePlan}" var="dto">
                    <div  class="layui-input-inline">
                     <span >开课时间:</span>
                     <input type="text" class="layui-input" datatype="*" value=<fmt:formatDate value="${Date(dto.time)}" pattern="yyyy-MM-dd  HH:mm:ss"/>  id="add_time${dto.id}" />
                     <button type='button' class='btn btn-danger' onclick='deleteElement(this);' style='margin-left: 50px;border-radius:20px;'>删除</button>
                     </div>  
                </c:forEach>
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
     <script type="text/javascript" src="plug-in/layui/layui.js"></script>  
	 <script src="js/DateFormat.js"></script> 
	     <!-- Validform组件引用 -->
     <script type="text/javascript" src="plug-in/Validform/Validform_v5.3.2.js"></script> 
<script type="text/javascript">

     var layer;
     var num = 1;
     $(function(){
        layui.use('layer', function(){
        layer= layui.layer;
    
        })
        $.Tipmsg.r=null;
        loadTime();
       // $.Tipmsg.r=null;
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
            	doAdd();
            }
       });
        
       });
   //添加时间
   
   
 function addPlan(){
	 var planHtml="";

	 planHtml+='<div class="layui-input-inline" name="arrPlan">',
	 planHtml+='<span >开课时间:</span>&nbsp;',
	 planHtml+="<input type='text' class='layui-input' datatype='*' id='add_time"+num+"'>",
	 planHtml+=" <button type='button' class='btn btn-danger' onclick='deleteElement(this);' style='margin-left: 50px;border-radius:20px;'>删除</button></div>"
     $("#coursePlan").append(planHtml);
	    layui.use('laydate', function(){
	          var laydate = layui.laydate;
	           date=new Date();
	          //执行一个laydate实例
	          laydate.render({
	            elem: '#add_time'+num, //指定元素
	            type: 'datetime',
	            min:date.format('yyyy-MM-dd hh:mm:ss'),
                value: date
	          });
	        });
	    num++;
   }

	//关闭按钮功能实现
	$("#btnClose").bind('click',function(){
		//关闭窗口 lhgdiaglog方法
		//frameElement.api.close(); 
       var index = parent.layer.getFrameIndex(window.name);
       parent.layer.close(index);
	});
	
	
	//初始化原有时间插件
	function loadTime(){
		   var array = new Array();
	        <c:forEach items="${courseInfo.coursePlan}" var="t">
	         array.push("${t.id}"); //js中可以使用此标签，将EL表达式中的值push到数组中
	          layui.use('laydate', function(){
                    var laydate = layui.laydate; 
                    for(var i=0;i<array.length;i++){
                    //执行一个laydate实例
                    laydate.render({
                      elem: '#add_time'+"${t.id}", //指定元素
                      type: 'datetime',
                      value: changeDateFormat("${t.time}")
                     });
                    }
                  });
	        </c:forEach>

	       
	    }
	   

  	function deleteElement(obj){
  		$(obj).parent().remove();
	}
	
	

function doAdd(){	

	 var divArray=[];	
    //排课安排
    $("div[name='arrPlan']").find("input").each(function(k,v){ //
        //存行数据
        divArray.push($(v).val()); //行数据格式
    });
    var param={
	      "name":$("#name").val(),
	      "totalClass":$("#totalClass").val(),
	      "price":$("#price").val(),
	      "numberOfExpected":$("#numberOfExpected").val(),
	      "name":$("#name").val(),
	      "type":$('input[name="type"]:checked').val(),
	      "brief":$("#brief").val(),
	       "courseID":$("#courseID").val(),
	      "divArrayStr":JSON.stringify(divArray)
	      };
     $.ajax({
	      type : 'POST',
	      url : "lessonCenterController/updateCourse",
	      data: param,
	       beforeSend: function(){
	          $("#btnSubmit").attr({ disabled: "disabled" });
	       }, 
          success : function(data) {
        	  //$("#btnSubmit").removeAttr("disabled");  
        	  layui.use('layer', function(){
                  var layer = layui.layer;
        		  layer.msg(data.message, {
        			  icon: data.code,
        			  time: 2000 //2秒关闭（如果不配置，默认是3秒）
        			}, function(){
        		          if(data.code=="1"){
        		        	  parent.loadTable(1);
        		              var index = parent.layer.getFrameIndex(window.name);
        		              parent.layer.close(index);
        	              }
        			});   
        		});     
         }
    });
}
	
</script>
</body>
</html>
