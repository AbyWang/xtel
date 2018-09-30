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
<title>我的文库</title>
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
<script src="plug-in/layui/layui.js"></script>
<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<script src="js/bootstrap-curdtools.js"></script>
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
			                        <label  for="name">文章名称：</label>
			                        <div class="input-group col-md-6">
			                        	<input type="text" class="form-control input-sm" id="name" name="name">
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
		   <a  id="btn_add" type="button" class="btn btn-primary btn-sm"  href="<%=path%>/library/toAddArticlePage">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
           </a>
            <a class="btn btn-default btn-sm" data-toggle="collapse" href="#collapse_search" id="btn_collapse_search" >
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span> 检索 </a>
        </div>
        <div class="table-responsive">
            <!-- class="text-nowrap" 强制不换行 -->
         	<table id="listMyLibrary"></table>
        </div>
    </div>
<script type="text/javascript">
var path = "<%=path%>";
var layer;
$(function () {
	loadTable();
	layui.use('layer', function(){
		  var layer = layui.layer;
	});  
});

function loadTable(flag){
	var defaultColunms = listMyLibrary.initColumn();
    var table = new BSTable("listMyLibrary",path+ "/library/listMyLibraryPage", defaultColunms);
    table.init();
    if(flag==1){
        table.refresh();
    }	
}

listMyLibrary.initColumn= function () {
    return [
        {title: '文章编号', field: 'id', align: 'center', valign: 'middle',width:'50px',visible:false},
        {title: '文章名称',field: 'name', align: 'center', valign: 'middle',width:'50px'},
        {title: '上传者',field: 'userName', align: 'center', valign: 'middle',width:'50px'},
        {title: '上传时间',field: 'uploadTime', align: 'center', valign: 'middle',width:'50px',
        	formatter: function (value, row, index) {
                return changeDateFormat(value);
        	}
        },
        {title: '点击量',field: 'hits', align: 'center', valign: 'middle',width:'50px'},
        {title: '点赞数',field: 'likes', align: 'center', valign: 'middle',width:'50px'},
        {title: '操作', align: 'center', valign: 'middle',width:'50px', formatter: 
  		        function (value, row, index) {
        			var btn="";
        			btn+='<a id="btn_add" style="padding: 1px 5px;font-size:12px;line-height:1.5;border-radius:3px;" type="button" class="btn btn-info btn-sm" href="<%=path%>/library/toArtileDetailPage/'+row.id+'">查看</a>&nbsp;';
  		            btn+= '<a id="btn_add" style="padding: 1px 5px;font-size:12px;line-height:1.5;border-radius:3px;" type="button" class="btn btn-info btn-sm" href="<%=path%>/library/toEditArticlePage/'+row.id+'">修改</a>&nbsp;';
  		            btn+= "<button class='btn btn-xs btn-danger' onclick='deleteArticle("+row.id+")'><i class='icon-link bigger-180'></i>删除</button>&nbsp;"
  	 				return btn;
        }
        }]
    };
    
    //查询
    function reload(){
    	loadTable(1);
    }
    //重置
    function reset(){
		$("#name").val("");    	
    }
    
    //删除
    function deleteArticle(id){
    	layer.confirm('是否删除该文章?', 
      		  {icon: 3,btn: ['确定','取消'],title:'删除文章'},
      		  function(index){
                  layer.close(index);
                  $.ajax({
                	 type:"post",
                	 url:path+"/library/deleteArticleById/"+id,
                	 dataType:"json",
                	 success:function(data){
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
      		  })
    }
    
</script>
</body>
</html>
