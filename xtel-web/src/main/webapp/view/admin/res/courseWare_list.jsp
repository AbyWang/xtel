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
<title>课件管理</title>
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<!-- <script src="https://cdn.bootcss.com/jquery/1.12.3/jquery.min.js"></script> -->
<!-- bootstrap组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<!-- <link href="https://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script> -->

<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- <link href="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.js"></script> -->

<!-- Layer组件引用 -->
<script src="plug-in/layer/layer.js"></script>
<script src="plug-in/laydate/laydate.js"></script>
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
			                        <label  for="name">课件名称：</label>
			                        <div class="input-group col-md-6">
			                        	<input type="text" class="form-control input-sm" id="nameVlaue" name="nameVlaue">
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
            <button id="btn_add" type="button" class="btn btn-primary btn-sm" onclick="add('新增','','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
            <button id="btn_edit" type="button" class="btn btn-success btn-sm" onclick="update('修改','','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button>
            <button id="btn_delete" type="button" class="btn btn-danger btn-sm"  onclick="deleteALLSelect('批量删除','','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>批量删除
            </button>
            <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="courseWare"></table>
        </div>
    </div>
<script src="js/common.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
$(function () {
	loadTable();
});
function loadTable(flag){
	var defaultColunms = courseWare.initColumn();
    var table = new BSTable("courseWare",path+"/getResourcesPage", defaultColunms);
    table.init();
    if(flag==1){
        table.refresh();
    }	
}
courseWare.initColumn= function () {
    return [
        { checkbox: true,align: 'center'},
        {title: 'id',field: 'COURSEWAREID', align: 'center', valign: 'middle',width:'50px'},
        {title: '课件名称',field: 'DESCRIPTION', align: 'center', valign: 'middle',width:'50px'},
        {title: '课程名称',field: 'NAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '课程ID',field: 'COURSEID', align: 'center', valign: 'middle',width:'50px'},
        {title: '上传者名称',field: 'USERNAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '上传者ID',field: 'USERID', align: 'center', valign: 'middle',width:'50px'},
        {title: '上传时间',field: 'UPLOADTIME', align: 'center', valign: 'middle',width:'50px'},

        {title: '操作', align: 'center', valign: 'middle',width:'50px', formatter: 
        	function (value, row, index) {
        	  return '<button class="btn btn-danger btn-xs" onclick="delObj(\'jeecgListDemoController.do?doDel&id='+row.id+'\',\'jeecgDemoList\')"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除</button>';
        }}]
  };
  //查询
  function reload(){
	  loadTable(1);
  }
  //重置
  function reset(){
	  $("#nameVlaue").val("");
  }
  
</script>
</body>
</html>
