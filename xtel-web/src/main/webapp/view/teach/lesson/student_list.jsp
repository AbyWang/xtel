<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String courseId=request.getAttribute("courseId").toString();
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>课程申请</title>
<link href="plug-in/Validform/css/demo.css" rel="stylesheet" />
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />

<style>


</style>
</head>

<body>
        <div class="panel-body" style="padding-bottom:0px;">
        <div id="toolbar">
         <form id="searchForm" class="form form-horizontal" action="" method="post">
         <div class="form-inline">
              <label  for="name">用户名：</label>
             <input type="text" class="form-control input-sm" id="userName" name="userName">
             <a type="button"  onclick="reload();"class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</a>&nbsp;&nbsp;
             <a type="button" onclick="reset();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 重置</a>
           </div>
        </div>
       </form>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="studentList"></table>
        </div>
    </div>
     <!-- Jquery组件引用 -->
     <script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>  
     <script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
     <!-- bootstrap组件引用 --><script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
    <script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
    <script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <!-- Validform组件引用 -->
     <script src="js/common.js"></script>    
    <script src="js/DateFormat.js"></script> 
     <script type="text/javascript" src="plug-in/layui/layui.js"></script>  
  

<script type="text/javascript">
var data=[]; 
var path = "<%=path%>";
var  courseId="<%=courseId%>";
$(function () {

	loadTable();
});

function loadTable(flag){
    var defaultColunms = studentList.initColumn();
    var table = new BSTable("studentList",path+ "/lessonCenterController/listStudentByCourseId?courseId="+courseId, defaultColunms);
    table.init();
    if(flag==1){
    	table.refresh();
    }
}
var data=[];
studentList.initColumn = function () {
    return [
        {checkbox: true,align: 'center'},
        {title: '编号',field: 'ID', align: 'center', valign: 'middle'},
        {title: '房间号',field: 'ROOMID', align: 'center', valign: 'middle'},
        {title: '用户名', field: 'USERNAME', align: 'center', valign: 'middle'},
        {title: '群组', field: 'GROUPNAME', align: 'center', valign: 'middle'},
        {title: '申请时间', field: 'TIME', align: 'center', valign: 'middle',
            formatter: function (value, row, index) {
                return changeDateFormat(value);
           }},
		{title: "申请状态", field : "STATUS", align: 'center', valign: 'middle',
        	  formatter: function (value, row, index) {
				if(value==0){
					return "审核中";
				}else{
					return "审核通过";
				}
				
			}},
       /**{title: '操作', align: 'center', valign: 'middle', formatter: 
	       function (value, row, index) {
                 data[index]=row;
	             return ['<button class="btn btn-danger btn-xs" onclick=delStuent("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-remove" aria-hidden="true">删除</span></button>',
	          ].join('');
         }}*/
        ];};
/**
	function delStuent(index){
        var id=data[index].ID;
        var roomId=data[index].ROOMID;
        var userName=data[index].USERNAME;
        layui.use('layer', function(){
            var layer = layui.layer;
            layer.confirm('是否删除学员?', {icon: 2,btn: ['删除','取消'],title:'删除学员'}, function(index){
                layer.close(index);
                $.ajax({
                    type : 'POST',
                    url : "lessonCenterController/deleteStudent",// 请求的action路径
                    data : {id:id,userName:userName,roomId:roomId},
                    success : function(data) {
                        layer.msg(data.message, {
                            icon: data.code,
                            //2秒关闭（如果不配置，默认是3秒）
                            time: 2000 
                          }, function(){
                            if(data.code=="1"){
                                loadTable(1);
                            }
                    });
                 }
                });
             });
       })
	}*/
	//查询
	function reload(){
		loadTable(1);
	}
	//重置
	function reset(){
		$("#userName").val("");
	}
</script>
</body>
</html>
