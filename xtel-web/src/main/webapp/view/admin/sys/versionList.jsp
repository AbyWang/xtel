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
<title>版本列表</title>
<!-- Jquery组件引用 -->

<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- Layer组件引用 -->
<script src="plug-in/layui/layui.js"></script>
<!-- 通用组件引用 -->
<script src="js/common.js"></script>
</head>
     <div class="panel-body" style="padding-bottom:0px;">
        <!-- 搜索 -->
        <div id="toolbar">
            <button id="btn_add" type="button" class="btn btn-primary btn-sm" onclick="add('新增','','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
            </button>
           <!--  <button id="btn_edit" type="button" class="btn btn-success btn-sm" onclick="update('修改','','jeecgDemoList',600,400)">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
            </button> -->
              </div>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="versionList"></table>
        </div>
    </div>
    
    <!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content"  >
		  <form class="registerform" >
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" 
						aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="myModalLabel">
					版本发布
				</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
                   <label>版本号:</label>
                    <input class="form-control" type="text" id="version" datatype="*" />
                    <div class="Validform_checktip"></div>
                 </div>
                 <div class="form-group">
                        <label >ios安装包:</label>
                        <input class="form-control" type="text"  id="iosUrl"  datatype="*"/>
                        <div class="Validform_checktip">
                  </div>
                                                              
                  <div class="form-group">
                       <label>android安装包:</label>
                       <input class="form-control" type="text" id="androidUrl"  datatype="*"/>
                      <div class="Validform_checktip">
                 </div>   
                 <div class="form-group">
                       <label>PC安装包:</label>
                       <input class="form-control" type="text" id="pcUrl"  datatype="*"/>
                      <div class="Validform_checktip">
                 </div> 
                 <div class="form-group">
				    <label for="name">更新日志:</label>
				    <textarea class="form-control" id="releaseNote" rows="3"></textarea>
				  </div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" 
						data-dismiss="modal">关闭
				</button>
				<button type="submit"   class="btn btn-primary">
					提交更改
				</button>
			</div>
			</form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
var path = "<%=path%>";
var data=[]; 
var layer;
$(function () {
	loadTable();
	layui.use('layer', function(){
        layer= layui.layer;
        
      })
});
	
	
//修改	
function updateVersion(index){
    var rdata=data[index];
    //填充值
    $("#version").val(rdata.VERSION);
    $("#iosUrl").val(rdata.IOSURL);
    $("#androidUrl").val(rdata.ANDROIDURL);
    $("#pcUrl").val(rdata.PCURL);
    $("#releaseNote").html(rdata.RELEASENOTE);
 	$('#myModal').modal('show');
 }

function loadTable(flag){
	
	var defaultColunms = versionList.initColumn();
    var table = new BSTable("versionList",path+ "/systemController/listSystemVersion", defaultColunms);
    table.init();
    if(flag==1){
    	table.refresh();
    }
}

versionList.initColumn= function () {
    return [
        {title: 'id',field: 'ID', align: 'center', valign: 'middle',width:'50px',visible:false},
        {title: '版本号', field: 'VERSION', align: 'center', valign: 'middle',width:'50px'},
        {title: '时间', field: 'TIME', align: 'center', valign: 'middle',width:'50px',
        	  formatter: function (value, row, index) {
        	        return changeDateFormat(value)
        	    }},
        {title: '发布内容', field: 'RELEASENOTE', align: 'center', valign: 'middle',width:'50px'},
        {title: '发布人', field: 'USERID', align: 'center', valign: 'middle',width:'50px'},
        {title: '状态', field: 'STATUS', align: 'center', valign: 'middle',width:'50px',formatter: 
  	    function (value, row, index) {
        	if(value==1){
        		return "<font color='green'>启用</font>";
        	}else{
        		return "<font color='red'>禁用</font>";
        	}
        }},
       {title: '操作', align: 'center', valign: 'middle',width:'50px', formatter: 
	      function (value, row, index) {
    	    data[index]=row;
    	    var btn="";
    	    if(row.STATUS==0){   //使用中
    	    	btn+="<button class='btn btn-sm btn-info'  onclick=updateStatus('"+row.ID+"')><i class='icon-edit bigger-180'></i>启用</button>&nbsp;";
    	    }
    	    btn+="<button class='btn btn-sm btn-success'  onclick=updateVersion('"+index+"')><i class='icon-edit bigger-180'></i>修改</button>&nbsp;";
            return btn;
           }
        }];}
        
        //启用状态修改
        function updateStatus(id){
        	$.ajax({
        		type:"post",
        		url:path+"/systemController/updateStatus/"+id,
        		data:{"startStatus":1,"closeStatus":0},
        		dataType:"json",
        		success:function(data){
        			console.log(data);
        			if(data.success){
        				layer.msg(data.msg, {
            	            icon: 1,
            	            time: 2000 //2秒关闭（如果不配置，默认是3秒）
            	          });  
        				loadTable(1);
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
