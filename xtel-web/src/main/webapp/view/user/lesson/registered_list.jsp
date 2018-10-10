<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo user=(UserInfo)session.getAttribute("userInfo");
String userName=user.getUserName();
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>已报名课程</title>
<!-- Jquery组件引用 -->

<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- Layer组件引用 -->
<script type="text/javascript" src="plug-in/layui/layui.js"></script>  

<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<script src="js/bootstrap-curdtools.js"></script>
<script src="js/DateFormat.js"></script>
</head>

<body>

        <div class="panel-body" style="padding-bottom:0px;">
        <!-- 搜索 -->
		<div class="accordion-group">
			<div id="collapse_search" class="accordion-body collapse">
				<div class="accordion-inner">
					<div class="panel panel-default" style="margin-bottom: 0px;">
            				<div class="panel-body" >
			                <form id="searchForm" class="form form-horizontal" action="" method="post">
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                        <label  for="name">课程名称：</label>
			                        <div class="input-group col-md-6">
			                        	<input type="text" class="form-control input-sm" id="courseName" name="courseName">
			                        </div>
			                    </div>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <div  class="input-group col-md-12" style="margin-top:20px">
			                         <a type="button" onclick="reload();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</a>&nbsp;&nbsp;
			                         <a type="button" onclick="reset();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 重置</a>
			                         </div>
			                    </div>
			                </form>
			                </div>
			             </div>
			       </div>
			</div>
		</div>
        <div id="toolbar">
            <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="userInfo"></table>
        </div>
    </div>
<script src="js/common.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
var userName = "<%=userName%>";
var data=[];
var layer;
$(function () {
	loadTable();
    layui.use('layer', function(){
        var layer = layui.layer;
      });
});

function loadTable(flag){
	var defaultColunms = userInfo.initColumn();
    var table = new BSTable("userInfo",path+ "/lessonCenterController/listRegisteredLessonPage", defaultColunms);
    table.init();
    if(flag==1){
        table.refresh();
    }	
}

userInfo.initColumn = function () {
    return [
        {title: '编号',field: 'COURSEID', align: 'center',visible:false},
        {title: '课程名称', field: 'NAME', align: 'center', valign: 'middle'},
        {title: '房间号', field: 'ROOMID', align: 'center', valign: 'middle',visible:false},
        {title: '总课时', field: 'TOTALCLASS', align: 'center', valign: 'middle'},
        {title: '价格', field: 'PRICE', align: 'center', valign: 'middle'},
        {title: '课程类型',field: 'TYPE', align: 'center', valign: 'middle',
         	formatter: function (value, row, index) {
                if(value==0){
                	return "传统直播授课";
                  }else{
                	return "智能授课"; 
                  }
            }},
        {title: '讲师', field: 'USERNAME', align: 'center', valign: 'middle'},
        {title: '审核状态',field: 'STATUS', align: 'center', valign: 'middle',
            formatter: function (value, row, index) {
                if(value==0){
                    return "<span style='color:red'>待审核</span>";
                  }else if(value==1){
                    return "<span style='color:green'>审核通过</span>"; 
                  }
            }},                          
        {title: '最近开课时间', field: 'LASTCLASSTIME', align: 'center', valign: 'middle',formatter:
        	function(value,row,index){
        		return changeDateFormat(value);
        	}
        },
        {title: '操作', align: 'center', valign: 'middle', formatter: 
            function (value, row, index) {
            data[index]=row;
            var btn='';
            if(row.COURSESTATUS!=4){//课程已结束
            	btn+='<button class="btn btn-danger btn-xs" onclick=startClass("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-play" aria-hidden="true">开课</span></button>';
            }
            btn+=' <button class="btn btn-info btn-xs" onclick=signUp("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-search" aria-hidden="true">详情</span></button>';
            return btn;   
     }}]
};

function startClass(index){
    //排课计划id
    var status=data[index].STATUS;
    var roomId=data[index].ROOMID;
    if(status==0){
        layer.msg('还未审核', {
            icon: 2,
            time: 2000 //2秒关闭（如果不配置，默认是3秒）
          });   
    }else{
    	window.location.href="Talker5Protocol:"+roomId+'+'+userName+'+'+roomId+"+2"+"+"+courseName;
    }
}
//查询
function reload(){
	loadTable(1);
}
//重置
function reset(){
	$("#courseName").val("");
}

function signUp(index){
    var courseId=data[index].COURSEID;
    var name=data[index].NAME;
    layui.use('layer', function(){
        var layer = layui.layer;
        layer.open({
               type: 2, 
               title:name,
               area: ['700px', '500px'],
               content: 'lessonCenterController/getoRegister?courseId='+courseId ,
               success:function(layero,index){
              		$(":focus").blur();
              	},	   
               end:function(){
               }
             });
        })
 //   createdetailwindow(name, "lessonCenterController/getoRegister?courseId="+courseId,"780px","480px");
} 
</script>
</body>
</html>
