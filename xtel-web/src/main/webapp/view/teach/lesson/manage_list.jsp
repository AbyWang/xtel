<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo user=(UserInfo)session.getAttribute("userInfo");
String userName=user.getUserName();
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width" />
<base href="<%=basePath%>">
<title>课程安排</title>
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
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:300px">
        <div class="modal-content"  >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" 
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    开课时间调整
                </h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                   <label>开课时间:</label>
                    <input class="hidden" type="text" id="id"  />  
                    <input class="form-control" type="text" id="time" readonly style="background:white;" />                                          
                 </div>                             
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" 
                        data-dismiss="modal">关闭
                </button>
                <button type="button"  onclick="updateArrageById()" class="btn btn-success">
                    提交
                </button>
            </div>
        </div>
    </div>
</div>

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
         	<table id="listCourseArrange"></table>
        </div>
    </div>
<script src="js/common.js"></script>
<script src="js/DateFormat.js"></script> 
<script type="text/javascript">
var path = "<%=path%>";
var userName = "<%=userName%>";
var layer;
$(function () {
	loadTable();
	layui.use('layer', function(){
		  var layer = layui.layer;
		});    
});
	
	function loadTable(flag){

	  var defaultColunms = listCourseArrange.initColumn();
      var table = new BSTable("listCourseArrange",path+ "/lessonCenterController/listLsssonArrangePage", defaultColunms);
      table.init();
      if(flag==1){
          table.refresh();
      }	
	}
	
var data=[];
listCourseArrange.initColumn= function () {
    return [
      /*{title: '编号',field: 'ID', align: 'center', valign: 'middle',width:'50px',visible:false},
        {title: '课程ID',field: 'COURSEID', align: 'center', valign: 'middle',width:'50px',visible:false},
        {title: '房间ID',field: 'ROOMID', align: 'center', valign: 'middle',width:'50px',visible:false}, */
        {title: '课程名称',field: 'COURSENAME', align: 'center', valign: 'middle',width:'50px'},
        {title: '开课时间',field: 'TIME', align: 'center', valign: 'middle',width:'50px',
        	formatter: function (value, row, index) {
                return changeDateFormat(value);
        		},
        	},
        {title: '待更新时间',field: 'UPDATETIME', align: 'center', valign: 'middle',width:'50px',
                formatter: function (value, row, index) {
                	if(value!=0){
                    return changeDateFormat(value);
                	}
                 },
            },
        {title: '状态',field:'STATUS', align: 'center', valign: 'middle',width:'50px',

            	formatter: function (value, row, index) {
                    switch(value){
                     //对用户来说都是待开课
                      case 0:case 1:
                         return  "<span style='color:green'>待开课</span>";
                    	  break;
                      case 2:
                          return  "<span style='color:#FF8C00'>开课中</span>";
                          break;
                      case 4:
                    	  return  "<span style='color:#0000C6'>已结束</span>";
                          break;
                     }
                    },
                },
        {title: '操作', align: 'center', valign: 'middle',width:'80px', 
        		formatter: function (value, row, index) {
        	            data[index]=row;
        	            var btn="";
        	            btn+='<button class="btn btn-info btn-xs" onclick=startClass("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-play" aria-hidden="true">开课</span></button>';
                        btn+='<button class="btn btn-primary btn-xs" onclick=updateArrange("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-pencil" aria-hidden="true">调整</span></button>';
                        btn+='<button class="btn btn-danger btn-xs" onclick=stopClass("'+index+'") style="margin-right:15px;"><span class="glyphicon glyphicon-stop" aria-hidden="true">结束</span></button>';

       		      return btn;

        }}] };      
      
  function startClass(index){
	  //排课计划id
      var id=data[index].ID;
	  var roomId=data[index].ROOMID;
      var courseId=data[index].COURSEID;
	  var status=data[index].STATUS;
	  var courseName=data[index].COURSENAME;
      if(status==4){
	          layer.msg('课程已结束', {
	              icon: 2,
	              time: 2000 //2秒关闭（如果不配置，默认是3秒）
	            });
	          return ;
	  }else if(status==2){
		   window.location.href="Talker5Protocol:"+roomId+'+'+userName+'+'+roomId+"+2"+"+"+courseName;
	  }
	  $.ajax({
          type : 'POST',
          url : "lessonCenterController/startClass",// 请求的action路径
          data : {id:id,roomId:roomId,courseId:courseId,id:id},
          success : function(data) {
                  if(data.code=="1"){
                      window.location.href="Talker5Protocol:"+roomId+'+'+userName+'+'+roomId+"+2"+"+"+courseName;
                  }else{
                      layer.msg(data.message, {
                          icon: 2,
                          time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        });
                  }
           }
       })
   }

  function stopClass(index){
	   //排课计划id
      var id=data[index].ID;
      var status=data[index].STATUS;
      if(status==4){
          layer.msg('课程已结束', {
              icon: 2,
              time: 2000 //2秒关闭（如果不配置，默认是3秒）
            });
          return ;
      } 
      //排课计划id
      var roomId=data[index].ROOMID;
      var courseId=data[index].COURSEID;//课程id
      var time=data[index].TIME;//开课时间
          layer.confirm('是否结束课时?', 
        		  {icon: 3,btn: ['结束','取消'],title:'结束课时'},
        		  function(index){
                    layer.close(index);
                    $.ajax({
                        type : 'POST',
                        url : "lessonCenterController/stopClass",// 请求的action路径
                        data : {id:id,roomId:roomId,courseId:courseId,time:time},
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
        })
  }


  
  //调整排课计划
  function updateArrange(index){
      var id=data[index].ID;
      var time=data[index].TIME;   
      var status=data[index].STATUS;

       $("#id").val(id);
       if(status==2){
           layer.msg('课程已开始,不能调整!', {
               icon: 2
             });
           return ;
       }
       if(status==4){
           layer.msg('课程已结束,不能调整！', {
               icon: 2
             });
           return ;
       }
       $('#myModal').modal('show');
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            laydate.render({ 
              elem: '#time',
              type: 'datetime',
              min:(new Date()).format("yyyy-MM-dd hh:mm:ss"),//min/max - 最小/大范围内的日期时间值
              theme:'#393D49',//主题颜色
              value:new Date(time)
            });
        })
      }
  
     function updateArrageById(){
           var id=$("#id").val();
           var updateTime=$("#time").val();
           if(updateTime==""){
        	   layer.msg("时间不能为空!", {
                   icon: 0,
                   //2秒关闭（如果不配置，默认是3秒）
                   time: 2000 
                 });
        	   return;
           }
           
           $.ajax({
                  type : 'POST',
                  url : "lessonCenterController/updateArrangeById",// 请求的action路径
                  data :{id:id,updateTime:updateTime},
                  dataType: "json",
                  success : function(data) {
                      $('#myModal').modal('hide');
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
</div>