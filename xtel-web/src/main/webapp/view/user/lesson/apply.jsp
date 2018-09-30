<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>排课申请</title>
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<!-- bootstrap组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

<!-- Layer组件引用 -->
<script src="plug-in/layer/layer.js"></script>
<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<script src="js/bootstrap-curdtools.js"></script>
<script src="js/util.js"></script>
</head>

<body>
	<div class="table-responsive">
	  <div id="toolbar">
	  
	             
			        <div class="input-group col-md-12">
			        <input type="text" class="input-sm" id="name" name="name">
			             &nbsp;   &nbsp;   &nbsp;
                    <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
			 			<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
       </div>
	  <table class="table table-striped table-bordered table-hover" id="arrangelist">

	   </table>
	</div>
	<script src="js/common.js"></script>
	<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>  
    <script type="text/javascript" src="js/curdtools_zh-cn.js"></script>  
	<script type="text/javascript">
var path = "<%=path%>";
$(function () {
	var groupId=getQueryString("groupId");
	loadTable(groupId);
});
var data=[];
function loadTable(groupId){
	var url=path+ "/teachingController/listCourseApply";
	if(isOrNotEmpty(groupId)){
		url=setParam(url,"groupId",groupId);
	}
	var defaultColunms = arrangelist.initColumn();
    var table = new BSTable("arrangelist",url, defaultColunms);
    table.init();
}
arrangelist.initColumn= function () {
    return [
        {title: 'id',field: 'COURSEID', align: 'center', valign: 'middle',width:'50px'},
        {title: '课程名称',field: 'NAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '课程讲师',field: 'LECTUREID', align: 'center', valign: 'middle',width:'50px'},
        {title: '总课时',field: 'TOTALCLASS', align: 'center', valign: 'middle',width:'50px'},
        {title: '价格',field: 'PRICE', align: 'center', valign: 'middle',width:'50px'},
         {title: '课程类型',field: 'TYPE', align: 'center', valign: 'middle',width:'50px',
        	formatter: function (value, row, index) {
            if(value==0){
				return "传统直播授课";
			}else{
				return "智能授课";
			}}
            },

        {title: '申课状态',field: 'STATUS', align: 'center', valign: 'middle',width:'50px',
        	formatter: function (value, row, index) {
    				return "待审核";
        	}},

     {title: '操作', align: 'center', valign: 'middle',width:'50px', formatter: 
    		        	function (value, row, index) {
                        data[index]=row;
                        if(row.STATUS==1){
                            return '<button class="btn btn-info btn-xs" onclick=check("'+index+'")><span class="glyphicon glyphicon-check" aria-hidden="true"></span>审核</button>';
                        }
              }}]
     };

function check(index){
    var courseId=data[index].COURSEID;
    var courseName=data[index].NAME;
    var numberOfExpected=data[index].NUMBEROFEXPECTED;
    var url="lessonCenterController/courseApply?courseId="+courseId+"&courseName="+courseName+"&numberOfExpected="+numberOfExpected;

    createdialog(name,"课程审核",url);
}

</script>
</body>
</html>
