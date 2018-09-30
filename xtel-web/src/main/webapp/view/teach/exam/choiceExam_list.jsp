<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>选择题目</title>
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/layui/css/layui.css" rel="stylesheet" rel="stylesheet">

<!-- bootstrap组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/layui/layui.js"></script>
<script src="js/bootstrap-curdtools.js"></script>
<script src="js/common.js"></script>
<style type="text/css">
	body{ 
		margin:0; 
		padding:0;
	}
	span{
	color:#A8ACAF;
	font-family: MicrosoftYaHei;
	font-size: 14px;
	
	}

    textarea,input[type="text"],input[type="radio"]{
	width:auto;
    display: inline-block;
    padding: 4px 6px;
    margin-bottom: 10px;
    margin-top: 10px;
    -webkit-border-radius: 4px;
    -moz-border-radius: 4px;
    border-radius: 4px;
    vertical-align: middle;
    background-color: rgb(255, 255, 255);
    box-shadow: rgba(0, 0, 0, 0.075) 0px 1px 1px inset;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(204, 204, 204);
    border-image: initial;
    transition: border 0.2s linear, box-shadow 0.2s linear;

   }
</style>
</head>

<body style="overflow-x: hidden;">
<div class="container">
       <form class="courseForm" method="post" >
        <hr style="color:red;margin-top:20px">
        <div id="toolbar">
             <button class="btn btn-primary btn-sm" type="button"  id="btnSubmit">
            <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> 保存 </button>
            
             <button class="btn btn-danger btn-sm" type="button"  id="btnClose">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 关闭 </button>
        </div>
		<div class="table-responsive">
         	<table id="exerciseList"></table>
        </div>
		<hr color="#eaeced">
		</form>
</div> 
<script type="text/javascript">
var path = "<%=path%>";
var type;
$(function(){
	type = parent.selType;
	var defaultColunms = exerciseList.initColumn();
    var table = new BSTable("exerciseList",path+ "/examController/getExerciseList/"+type, defaultColunms);
    table.init();
});

exerciseList.initColumn= function () {
    return [
        {checkbox: true  , valign: 'middle'},
        {title: '编号',field: 'ID', align: 'center', valign: 'middle',width:'50px'},
        {title: '题型',field: 'TYPE', align: 'center', valign: 'middle',width:'50px',
        	formatter: function (value, row, index) {
                if(value==0){
                    return "选择题";
                  }else if(value==1){
                    return "问答题";
                  }else if(value==2){
                	return "填空题"; 
                  }           
            }},
        {title: '试题内容',field: 'STEM', align: 'center', valign: 'middle',width:'50px'},
        {title: '创建时间',field: 'UPLOADTIME', align: 'center', valign: 'middle',width:'50px',
            formatter: function (value, row, index) {
                return changeDateFormat(value);       
            }}  
       ]};

	//关闭按钮功能实现
	$("#btnClose").bind('click',function(){
		//关闭窗口 lhgdiaglog方法
		//frameElement.api.close(); 
       var index = parent.layer.getFrameIndex(window.name);
       parent.layer.close(index);
	});
	
	//提交
	$("#btnSubmit").bind('click',function(){
	   var ids=new Array(); 
        var rows=$("#exerciseList").bootstrapTable("getSelections");
       // for(var i=0;i++;i<rows.length){
      //  	divArray.push(rows[i].ID);
      //  }
       
       $(rows).each(function(){   
    	   ids.push(this.ID);
       })
       
       if(ids.length==0){
           layui.use('layer',function(){
               var layer = layui.layer;
               layer.msg("请选择试题！",{icon:2});
           })
       }else{  
         parent.selQuestion(ids,type);
         var index = parent.layer.getFrameIndex(window.name);
         parent.layer.close(index);
       }
	});	
</script>
 <script src="js/common.js"></script>
 <script src="js/DateFormat.js"></script> 
</body>
</html>
 