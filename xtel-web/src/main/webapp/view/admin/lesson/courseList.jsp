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
<title>课程审核</title>

<!-- bootstrap组件引用 -->
<link rel="stylesheet" href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" />
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="js/bootstrap-curdtools.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
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
              <table class="table table-striped table-bordered table-hover" id="arrangelist">

       </table>
        </div>
    </div>
 <script src="js/common.js"></script>
 <script type="text/javascript" src="js/curdtools_zh-cn.js"></script> 
<script src="js/util.js"></script> 
<script src="js/DateFormat.js"></script>
<script type="text/javascript" src="plug-in/layui/layui.js"></script>  

<script>
var path = "<%=path%>";

var groupId;
$(function () {
    groupId=getQueryString("groupId");
    loadTable(groupId);
});
var data=[];
function loadTable(groupId,flag){
    var url=path+ "/teachingController/listCourseApply";
    if(isOrNotEmpty(groupId)){
        url=setParam(url,"groupId",groupId);
    }
    var defaultColunms = arrangelist.initColumn();
    var table = new BSTable("arrangelist",url, defaultColunms);
    table.init();
    if(flag==1){
        table.refresh();
    }
}
arrangelist.initColumn= function () {
    return [
        {title: 'id',field: 'COURSEID', align: 'center', valign: 'middle',width:'50px',visible: false},
        {title: '群组名称',field: 'GROUPNAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '课程名称',field: 'NAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '课程讲师ID',field: 'LECTUREID', align: 'center', valign: 'middle',width:'50px',visible: false},
        {title: '课程讲师',field: 'USERNAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '总课时',field: 'TOTALCLASS', align: 'center', valign: 'middle',width:'50px'},
        {title: '人数上限',field: 'NUMBEROFEXPECTED', align: 'center', valign: 'middle',width:'50px'},
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
                if(value==1){
                    return "<span style='color:red'>待审核</span>";
                }else if(value==2){
                    return "<span style='color:green'>审核通过</span>";
                }else if(value==3){
                    return "课程进行中";
                }else if(value==4){
                    return "课程已结束";
                }
            }},
          {title: '操作', align: 'center', valign: 'middle',width:'80px', formatter: 
                        function (value, row, index) {
                        data[index]=row;
                            return [
                             "<button class='btn btn-xs btn-info' onclick=detail('"+index +"')><span class='glyphicon glyphicon-info-sign aria-hidden='true'></span>详细</button>&nbsp;",
                             '<button class="btn btn-primary btn-xs" onclick=check("'+index+'")><span class="glyphicon glyphicon-check" aria-hidden="true"></span>审核</button>'
                  ].join('') 
              }}]
     };

function check(index){
    var courseId=data[index].COURSEID;
    var status=data[index].STATUS;
    var courseName=data[index].NAME;
    var numberOfExpected=data[index].NUMBEROFEXPECTED;
    var userName=data[index].USERNAME;
    console.log(userName);
    layui.use('layer', function(){
        var layer = layui.layer;
        if(status!=1){
        	layer.msg("已审核",  {
                icon: 2,
                //2秒关闭（如果不配置，默认是3秒）
                time: 2000 
              })
              return ;
        }
        layer.confirm('是否通过?', {icon: 1,btn: ['通过','取消'],title:'课程审核'}, function(index){
        layer.close(index);
        	$.ajax({
                type : 'POST',
                url : "teachingController/courseApply",// 请求的action路径
                data : {
                	courseId:courseId,
                	courseName:courseName,
                	numberOfExpected:numberOfExpected,
                	userName:userName
                	},
                success : function(data) {
                    layer.msg(data.message, {
                        icon: data.code,
                        //2秒关闭（如果不配置，默认是3秒）
                        time: 2000 
                      }, function(){
                        if(data.code=="1"){
                        	loadTable(groupId,1);
                        }
                });
             }
         });
       });
    });
 }
function detail(index){
	 var courseId=data[index].COURSEID;
	 var name=data[index].NAME;
      layui.use('layer', function(){
            var layer = layui.layer;
            layer.open({
                   type: 2, 
                   title:"课程详情:"+name,
                   area: ['700px', '520px'],
                   content: 'teachingController/getoCourseDetail?courseId='+courseId ,
	               success:function(layero,index){
	               	  $(":focus").blur();
	               },
                   end:function(){
                   }
                 });
            })
}
//查询
function reload(){
	loadTable(groupId,1);
}
//重置
function reset(){
	$("#courseName").val("");
}
</script>
</body>
</html>
