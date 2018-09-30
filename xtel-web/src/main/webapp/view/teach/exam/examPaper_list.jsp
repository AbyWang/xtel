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
<title>试卷管理</title>
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<!-- bootstrap组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/layui/layui.js"></script>
<script src="js/bootstrap-curdtools.js"></script>
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
                                    <label  for="name">试卷名称：</label>
                                    <div class="input-group col-md-6">
                                        <input type="text" class="form-control input-sm" id="paperName" name="paperName">
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
           <a  id="btn_add" type="button" class="btn btn-primary btn-sm"  href="lessonCenterController/gotoAddExam">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
           </a>
         <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
               <span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <div class="table-responsive">
         	<table id="listAllPaper"></table>
        </div>
    </div>
<script src="js/common.js"></script>
<script src="js/util.js"></script> 
<script type="text/javascript">
var path = "<%=path%>";
$(function () {
	var courseId='<%=request.getAttribute("courseId")%>';
	loadTable(courseId);
});
function loadTable(courseId,flag){
	var url=path+ "/examController/listExcemPaper";
    if(isOrNotEmpty(courseId)){
    	$("#btn_add").addClass("hidden");
        url=setParam(url,"courseId",courseId);
    }
    var defaultColunms = listAllPaper.initColumn();
    var table = new BSTable("listAllPaper",url, defaultColunms);
    table.init();
    if(flag==1){
    	table.refresh();
    }
}
listAllPaper.initColumn= function () {
    return [
        {title: '编号',field: 'ID', align: 'center', valign: 'middle',width:'50px'},
        {title: '试卷名称',field: 'PAPERNAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '总分',field: 'TOTALSCORE', align: 'center', valign: 'middle',width:'50px'},
        {title: '所属课程',field: 'NAME', align: 'center', valign: 'middle',width:'50px'},   
        {title: '操作', align: 'center', valign: 'middle',width:'50px', formatter: 
       	function (value, row, index) {
	            return [
                        "<button class='btn btn-xs btn-info' onclick='lookteaching()'><i class=' icon-remove bigger-180'></i>修改</button>&nbsp;",
                        "<button class='btn btn-xs btn-danger' onclick='arrangeExamination()'><i class=' icon-zoom-in bigger-180'></i>删除</button>&nbsp;"
		                   ].join('');       		   
       }}]  };
    
       //查询
    function reload(){
    	loadTable(1);
    }
    //重置
    function reset(){
    	$("#paperName").val("");
    }
</script>
</body>
</html>
