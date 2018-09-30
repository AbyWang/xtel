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
<title>排课审核</title>

<!-- bootstrap组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/layui/layui.js"></script>
<script src="js/common.js"></script>
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
         	<table id="roleList"></table>
        </div>
    </div>
<script src="js/common.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
var data=[];
$(function () {
	loadTable();
});

function loadTable(flag){
	 var defaultColunms = roleList.initColumn();
	 var table = new BSTable("roleList",path+"/teachingController/listArrangePage", defaultColunms);
	 table.init();
	if(flag==1){
	    table.refresh();
	}
}
roleList.initColumn= function () {
    return [
        {title: 'id',field: 'id', align: 'center', valign: 'middle',width:'50px',visible:false},
        {title: '课程名称',field: 'COURSENAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '讲师',field: 'USERNAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '调整前时间',field: 'TIME', align: 'center', valign: 'middle',width:'50px' ,
        	formatter:function (value, row, index) {
        		
        		return changeDateFormat(value);
        	}
        	},
        {title: '调整后时间',field: 'UPDATETIME', align: 'center', valign: 'middle',width:'50px',
                formatter:function (value, row, index) {
                    
                    return changeDateFormat(value);
                }
        },
        {title: '状态',field: 'STATUS', align: 'center', valign: 'middle',width:'50px'
        	 ,formatter:function (value, row, index) {
        		 if(value==0){
        			 return "<span style='color:red'>待审核</span>";
        		 }else if(value==1){
        		     return "<span style='color:green'>已审核</span>";
        		 }

             }
        },
        {title: '操作', align: 'center', valign: 'middle',width:'50px', formatter: 
        	function (value, row, index) {
        	   data[index]=row;
            return '<button class="btn btn-info btn-xs" onclick=check("'+index+'")><span class="glyphicon glyphicon-check" aria-hidden="true"></span>审核</button>';
        }}]
  };
  
  
  function check(index){
	    var id=data[index].ID;
	    var updateTime=data[index].UPDATETIME;
	    var status=data[index].STATUS;
	    layui.use('layer', function(){
	        var layer = layui.layer;
	        if(status==1){
	            layer.msg("已审核",  {
	                icon: 2,
	                //2秒关闭（如果不配置，默认是3秒）
	                time: 2000 
	              })
	              return ;
	         }
	        layer.confirm('是否通过?', {icon: 1,btn: ['通过','取消'],title:'排课调整'}, function(index){
	            layer.close(index);
	                $.ajax({
	                    type : 'POST',
	                    url : "teachingController/updateArrangeById",// 请求的action路径
	                    data : {
	                    	id:id,
	                    	updateTime:updateTime
	                        },
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
	        });
  }
  //查询
  function reload(){
	  loadTable(1);
  }
  //重置
  function reset(){
	  $("#courseName").val("");
  }
</script>
</body>
</html>
