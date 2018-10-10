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
<title>课程报名</title>
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
			                        <label  for="name">课程名称：</label>
			                        <div class="input-group col-md-6">
			                        	<input type="text" class="form-control input-sm" id="courseName" name="courseName">
			                        </div>
			                    </div>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <div  class="input-group col-md-8" style="margin-top:20px">
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
         	<table id="listAllLesson"></table>
        </div>
    </div>
<script src="js/common.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
$(function () {
	loadTable();
});
	
	function loadTable(flag){

	  var defaultColunms = listAllLesson.initColumn();
      var table = new BSTable("listAllLesson",path+ "/lessonCenterController/listAllLesson", defaultColunms);
      table.init();
      if(flag==1){
          table.refresh();
      }	
	}
	
var data=[];
listAllLesson.initColumn= function () {
    return [
        {title: '编号',field: 'COURSEID', align: 'center', valign: 'middle',width:'50px',visible: false},
        {title: '课程名称',field: 'NAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '状态',field: 'STATUS', align: 'center', valign: 'middle',width:'50px',
         	formatter: function (value, row, index) {
                if(value==0){
                	return "未提交,未审核";
    			}else if(value==1){
    				return "已提交,审核中";
    			}else if (value==2){
					return "待开课";
    			}else if(value==3){
					return "课程进行中";
    			}else{
					return "课程已结束";
    			  }
                }},
        {title: '总课时',field: 'TOTALCLASS', align: 'center', valign: 'middle',width:'50px'},
        {title: '价格',field: 'PRICE', align: 'center', valign: 'middle',width:'50px'},
        {title: '课程类型',field: 'TYPE', align: 'center', valign: 'middle',width:'50px',
         	formatter: function (value, row, index) {
                if(value==0){
                	return "传统直播授课";
                  }else{
                	return "智能授课"; 
                  }
            }},
        {title: '已出售数量',field: 'SOLD', align: 'center', valign: 'middle',width:'50px'},
        {title: '通过课程人数',field: 'PASS', align: 'center', valign: 'middle',width:'50px'},
        {title: '讲师',field: 'USERNAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '操作', align: 'center', valign: 'middle',width:'50px', formatter: 
       		        	function (value, row, index) {
        	            data[index]=row;
       		            return [
                          "<button class='btn btn-xs btn-success' onclick=register('"+index+"')><i class=' icon-zoom-in bigger-180'></i>报名</button>&nbsp;",
       		              "<button class='btn btn-xs btn-info' onclick=signUp('"+index+"')><i class=' icon-zoom-in bigger-180'></i>详细</button>&nbsp;" 
       		             ].join('');   
        }}] };      
      //详细
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
         //报名
      function register(index){
             var courseId=data[index].COURSEID;
             var name=data[index].NAME;
             layui.use('layer', function(){
             var layer = layui.layer;

             layer.confirm('是否报名?', {icon: 1,btn: ['报名','取消'],title:'课程报名'}, function(index){
             layer.close(index);
             $.ajax({
                 type : 'POST',
                 url : "lessonCenterController/insertSignup",// 请求的action路径
                 data : {courseId:courseId},
                 success : function(data) {
                     layer.msg(data.message, {
                         icon: data.code,
                         //2秒关闭（如果不配置，默认是3秒）
                         time: 2000 
                       }, function(){
                         if(data.code==1){
                             loadTable(1);
                         }
                 });
                   
              }
             });
          });
 
       });
         // createdialog(name,"确认报名?","lessonCenterController/insertSignup?courseId="+courseId);
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
