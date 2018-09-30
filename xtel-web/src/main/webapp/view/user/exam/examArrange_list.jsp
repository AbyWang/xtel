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
<title>考试安排</title>
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<!-- bootstrap组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>

<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
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
                                    <label  for="name">名称：</label>
                                    <div class="input-group col-md-12">
                                        <input type="text" class="form-control input-sm" id="name" name="name">
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-4">
                                     <div  class="input-group col-md-12" style="margin-top:20px">
                                     <a type="button" onclick="jeecgDemoSearch();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</a>
                                     <a type="button" onclick="jeecgDemoRest();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 重置</a>
                                     </div>
                                </div>
                            </form>
                            </div>
                         </div>
                   </div>
            </div>
        </div>
       <div id="toolbar">
        <!--   <a  id="btn_add" type="button" class="btn btn-primary btn-sm"  href="examController/gotoAddExamPlan">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
           </a> --> 
         <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
               <span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
            <table id="listAllLesson"></table>
        </div>
    </div>
<script src="js/common.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
$(function () {
    var defaultColunms = listAllLesson.initColumn();
    var table = new BSTable("listAllLesson",path+ "/examController/listExamArrangeByUserId", defaultColunms);
    table.init();
});
    
var data=[];
listAllLesson.initColumn= function () {
    return [
        {title: '编号',field: 'ID', align: 'center', valign: 'middle'},
        {title: '试卷id',field: 'PAPERID', align: 'center', valign: 'middle'},
        {title: '考试名称',field: 'PAPERNAME', align: 'center', valign: 'middle'},
        {title: '课程名称',field: 'COURSENAME', align: 'center', valign: 'middle'},
        {title: '老师',field: 'USERNAME', align: 'center', valign: 'middle'},
        {title: '上传时间',field: 'TIME', align: 'center', valign: 'middle'},
         {title: '考试方式',field: 'TYPE', align: 'center', valign: 'middle',
            formatter: function (value, row, index) {
                if(value==0){
                    return "统一考试";
                  }else{
                    return "在线自考";
                  }           
            }},
          {title: '操作', align: 'center', valign: 'middle', formatter: 
               function (value, row, index) {
        	  console.log(row.ID);
                return   '<a  type="button" class="btn btn-primary btn-xs"  href="examController/gotoExam?paperId='+row.PAPERID+'&examId='+row.ID+'"><span class="glyphicon glyphicon-dashboard" aria-hidden="true"></span>测验</a>';
          }}] };
  </script>
</body>
</html>
