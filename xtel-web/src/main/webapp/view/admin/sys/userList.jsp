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
<title>用户列表</title>

<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- Layer组件引用 -->
<script src="plug-in/layui/layui.js"></script>
<!-- 通用组件引用 -->
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
			                <form id="searchForm" class="form form-horizontal">
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                        <label  for="name">用户名：</label>
			                        <div class="input-group col-md-6">
			                        	<input type="text" class="form-control input-sm" id="name" name="nameVlaue">
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
            <button id="btn_add" type="button" class="btn btn-primary btn-sm" onclick="add()">
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
<script src="js/common.js"></script>
<script src="js/DateFormat.js"></script>
<script type="text/javascript">
var path = "<%=path%>";
var layer;
$(function () {
	 layui.use('layer', function(){
         layer = layui.layer;
    });
	 loadTable();
}); 
function loadTable(flag){
	 var defaultColunms = userInfo.initColumn();
	 var table = new BSTable("userInfo",path+ "/user/getUserWithPage", defaultColunms);
	 table.init();
	 if(flag==1){
	     table.refresh();
	 } 
} 
userInfo.initColumn = function () {
    return [
        {title: '用户id',field: 'USERID', visible: false},
        {title: '用户名', field: 'USERNAME', align: 'center', valign: 'middle'},
       /*  {title: '购买课程数', field: 'PURCHASEDCOURSE', align: 'center', valign: 'middle', sortable: true},
        {title: '通过课程数', field: 'PASSCOURSE', align: 'center', valign: 'middle', sortable: true},
        {title: '开设课程数', field: 'LECTURES', align: 'center', valign: 'middle', sortable: true}, */
        {title: '所在群组', field: 'GROUPNAME', align: 'center', valign: 'middle'},
        {title: '登录时间', field: 'LOGINTIME', align: 'center', valign: 'middle',
        	formatter:function(value,row,index){
        		return changeDateFormat(row.LOGINTIME);
        	}
        },
        {title: '状态', field: 'STATUS', align: 'center', valign: 'middle', sortable: true,
        	formatter:function (value, row, index) {
        		var status;
        		if(row.STATUS==1){
        			status= "正常";
        		}else if(row.STATUS==0){
        			status= "锁定";
        		}else{
        			status="未知";
        		}
        		return status;
        	}
        },
        {title: '操作', align: 'center', valign: 'middle', formatter: 
	        	function (value, row, index) {
        			var btn="";/* "<button class='btn btn-xs btn-info' onclick=''><i class=' icon-zoom-in bigger-180'></i>修改</button>&nbsp;"; */
        			if(row.STATUS==0){//锁定状态解锁
        				btn+="<button class='btn btn-xs btn-success' onclick=updateUserStatus('"+row.USERID+"',1)><i class=' icon-zoom-in bigger-180'></i>激活</button>&nbsp;";
        			}else{//未锁定状态下锁定
        				btn+="<button class='btn btn-xs btn-danger' onclick=updateUserStatus('"+row.USERID+"',0)><i class=' icon-zoom-in bigger-180'></i>锁定</button>&nbsp;";
        			}
	 				return btn;
 				}
        }];
};
//查询
function reload(){
	loadTable(1);
}
//重置
function reset(){
	$("#name").val("");
}

//
function add(){
	layer.open({
        type: 2, 
        title:"新增用户",
        area: ['450px', '320px'],
        content: path+ "/user/toAddUserPage",
       	success:function(layero,index){
       		$(":focus").blur();
       	},
        end:function(){
     	    
         }
      });
}
//用户解锁，加锁状态更新
function updateUserStatus(userId,status){
	 $.ajax({
		type:"post",
		url:path+"/user/updateUserStatus",
		data:{"userId":userId,"status":status},
		dataType:"json",
		success:function(data){
			if(data.success){
				layer.msg(data.msg, {
	                 icon: 1,
	                 time: 2000 //2秒关闭（如果不配置，默认是3秒）
	            });  
				reload();//重新加载
			}else{
				layer.msg(data.msg, {
	                 icon: 2,
	                 time: 2000 //2秒关闭（如果不配置，默认是3秒）
	            });  
			}
		}
	});  
}
</script>
</body>
</html>
