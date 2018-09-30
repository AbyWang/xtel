<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>课程管理</title>
<link href="plug-in/Validform/css/demo.css" rel="stylesheet" />
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />

<style>


</style>
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
            <button id="btn_add" type="button" class="btn btn-primary btn-sm" onclick="addApply()">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>

            <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="userInfo"></table>
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
     <script type="text/javascript" src="plug-in/layui/layui.js"></script>  
      <script src="js/DateFormat.js"></script> 

<script type="text/javascript">
var data=[]; 
var path = "<%=path%>";
$(function () {
	loadTable();
});

function loadTable(flag){
	
    var defaultColunms = userInfo.initColumn();
    var table = new BSTable("userInfo",path+ "/lessonCenterController/listMyLessonPage", defaultColunms);
   // var param = { status:1};
   //table.setQueryParams(param);
    table.init();
    if(flag==1){
    	table.refresh();
    }
}
var data=[];
userInfo.initColumn = function () {
    return [
        {title: '编号',field: 'COURSEID', align: 'center', valign: 'middle',visible: false},
        {title: '课程名称', field: 'NAME', align: 'center', valign: 'middle'},
        {title: '总课时', field: 'TOTALCLASS', align: 'center', valign: 'middle'},
        {title: '价格', field: 'PRICE', align: 'center', valign: 'middle'},
		{title: "课程类型", field : "TYPE", align: 'center', valign: 'middle',
        	  formatter: function (value, row, index) {
				if(value==0){
					return "传统直播授课";
				}else{
					return "智能授课";
				}
				
			}},
		{title: '最大人数', field: 'NUMBEROFEXPECTED', align: 'center', valign: 'middle'},
		{title: '已出售数量', field: 'SOLD', align: 'center', valign: 'middle'},
        {title: '通过人数', field: 'PASS', align: 'center', valign: 'middle'},
        {title: '讲师', field: 'USERNAME', align: 'center', valign: 'middle'},
        {title: '状态',field: 'STATUS', align: 'center', valign: 'middle',
            formatter: function (value, row, index) {
                if(value==0){
                    return "未提交,未审核";
                }else if(value==1){
                    return "<span style='color:red'>审核中</span>";
                }else if (value==2){
                    return "<span style='color:green'>待开课<span>";
                }else if(value==3){
                    return "课程进行中";
                }else{
                    return "课程已结束";
                  }
                }},
        {title: '操作', align: 'center', valign: 'middle', formatter: 
	       function (value, row, index) {
                 data[index]=row;
                  var button="";
                  //课程完成不能修改

                  button='<button class="btn btn-primary btn-xs" onclick=update("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-pencil" aria-hidden="true">修改</span></button>'
         
      
                   button+='<button class="btn btn-info btn-xs" onclick=searchStu("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-user" aria-hidden="true">学员</span></button>' 

                   return [button].join('');
         }}
        ];};

        
        function addApply(){	
        	//openwindow('新增课程申请', "addApply","780px","480px");
           layui.use('layer', function(){
           var layer = layui.layer;
           layer.open({
        		  type: 2, 
        		  title:"新增课程申请",
        		  area: ['700px', '550px'],
        		  content:'lessonCenterController/addApply' ,
        		  success:function(layero,index){
              		$(":focus").blur();
              	},
        		  end:function(){
        			  loadTable(1);
        		  }
        		});
           })
        }
	function update(index){
        var courseId=data[index].COURSEID;
        var status=data[index].STATUS;

        layui.use('layer', function(){
            var layer = layui.layer;
            if(status!=1){
            	layer.msg("已审核,不可修改", {
                    icon: 2,
                    time: 2000 //2秒关闭（如果不配置，默认是3秒）
                 });  
            	return;
            }
            layer.open({
                   type: 2, 
                   title:"修改课程申请",
                   area: ['700px', '480px'],
                   content: 'lessonCenterController/updateApply?courseId='+courseId ,
                   success:function(layero,index){
               		$(":focus").blur();
                	},

                 });
            })
	}
	function searchStu(index){
		   var courseId=data[index].COURSEID;
	        layui.use('layer', function(){
	            var layer = layui.layer;
	            layer.open({
	                   type: 2, 
	                   title:"学员列表",
	                   area: ['800px', '550px'],
	                   content: 'lessonCenterController/gotoStudent?courseId='+courseId ,
	                   success:function(layero,index){
                   		$(":focus").blur();
                   	},
	                   end:function(){
	                   }
	                 });
	            })
	}
	//查询
	function reload(){
		loadTable(1);
	}
	//重置
	function reset(){
		$("#courseName").val("");
	}
	//开课
	//function startClass(index){
	//	   var courseId=data[index].COURSEID;
	//	   
	//}
</script>
</body>
</html>
