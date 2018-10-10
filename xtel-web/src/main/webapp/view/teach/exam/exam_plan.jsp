<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>测验</title>
<link href="<%=path%>/plug-in/layui/css/layui.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<%=path%>/plug-in/bootstrap3.3.5/css/bootstrap.min.css?v=246e02790957" >
<link rel="stylesheet" type="text/css" href="<%=path%>/css/exam/manual-add.css">
<style>
.hasBeenAnswer {
	background: #5d9cec;
	color:#fff;
}
.foot{
    text-align: center;
    bottom:0;
}
</style>

</head>
<body>
      <div class="issue-area">
               <form class=".form-horizontal" action="" name="form"  method="post" id="subForm">
                            <div class="exam-setting normal-setting">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="examName" class="col-sm-2 control-label">考试名称</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="examName" class="form-control hasUsingFormDom"
                                                       id="examName" placeholder="请输入考试名称"  value="" />
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">考试课程</label>
                                            <div class="col-sm-10">
                                                  <select id="courseId" name="courseId"  class="form-control" placeholder="群组">   
                                                        <option value=''>---请选择---</option>   
                                                         <c:forEach var="item" items="${courseList}">   
                                                         <option value='${item.COURSEID}'>  
                                                              ${item.NAME}  
                                                           </option>   
                                                           </c:forEach>   
                                                   </select>
                                            </div>
                                        </div>

                                        <div class="form-group answer-time">
                                            <label class="col-sm-2 control-label">答卷时长</label>
                                            <div class="col-sm-10">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="examTimeRestrict" checked value="1"/>
                                                      <input type="text"  name="examTime" class="form-control form-control-inline width-62  " /><span> 分钟</span>
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="examTimeRestrict" value="0"/> 不限时长
                                                    </label>
                                                </div>
                                                
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="passMark" class="col-sm-2 control-label">考试方式</label>
                                            <div class="col-sm-10">
                                               <div class="radio">   
                                                   <label>
                                                        <input type="radio" name="type" value="0" checked="checked"/> 在线考试
                                                    </label>
                                                  </div>
                                                <div class="radio">   
                                                    <label>
                                                        <input type="radio" name="type" value="1" /> 统一考试
                                                    </label>
                                                    </div>
                                            </div>
                                        </div>
 

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">考试时间</label>
                                            <div class="col-sm-10">
                                                <input type="text"  class="form-control form-control-inline width-45"  id="time">
                                            </div>
                                           </div>
                        
                                        
                                       </div>

                                    <div class="col-md-6">
                                        <div class="exam-title">试卷信息</div>
                                        <div class="panel panel-default panel-paper" id="paperPanel">
                                            <div class="panel-heading clearfix">
                                                <div class="paper-title">
                                                    <span class="paper-name"></span>
                                                    <span class="paper-type"> 
                                                      （选题组卷） 
                                                    </span>
                                                </div>
                                                <div class="paper-operation">
                                                    <a href="javascript:void(0);" onclick="choice_paper()" class="choice-paper">选择试卷</a>
                                                    <i class="icons8-edit"></i>
                                                </div>
                                            </div>
                                            <div class="panel-body">

                                                <div class="form-row">
                                                  <input type="hidden"  id="paperId"/>
                                                    <span class="title" >总分:</span>
                                                    <span class="content paper-total-score" id="totalScore"></span>
                                                </div>
                                                <div class="form-row">
                                                    <span class="title">及格分数:</span>
                                                    <span class="content paper-pass-score" id="passScore"></span>
                                                </div>
                                                <div class="form-row">
                                                    <span class="title">创建人:</span>
                                                    <span class="content paper-create-user-name" id="userName"></span>
                                                </div> 
                                              <!--  <div class="form-row">
                                                    <span class="title">试题数量:</span>
                                                    <span class="content paper-test-count"></span>
                                                </div> -->            
                                                <div class="form-row">
                                                    <span class="title">创建日期:</span>
                                                    <span class="content paper-created-time" id="uploadTime"></span>
                                                </div>
                                                <div class="text-center"> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                                       
                                  <div class="col-md-6 foot" >         
                                           <a href="JavaScript:void(0);" class="layui-btn layui-btn-sm " onclick="addExamArrange()"><span>保存</span></a>
                                            <a href="JavaScript:void(0);" class="layui-btn layui-btn-danger layui-btn-sm" onclick="history.go(-1)"><span>返回</span></a>          
                                   </div>
                                </div>
                 
                            </div>
            </form>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:300px">
        <div class="modal-content"  >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" 
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    选择试卷
                </h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                   <label>试卷名称:</label>
                   <select id="examPaper" class="form-control" >
              <option selected="selected"  >请选择</option>
              </select>

             </div>                             
            </div>
            <div class="modal-footer">
                <button type="button"  onclick="btnSumit()" class="btn btn-success">
                    确定
                </button>
                <button type="button" class="btn btn-default" 
                        data-dismiss="modal">关闭
                </button>
            </div>
        </div>
    </div>
</div>
  <script src="<%=path%>/plug-in/jquery/jquery-1.9.1.js"></script>
  <script src="<%=path%>/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/plug-in/layui/layui.js"></script>
<script type="text/javascript" src="<%=path%>/js/DateFormat.js"></script>
<script>
var layer;
layui.use(['form','layer','laydate'],function(){
	  var laydate = layui.laydate;
	  layer=layui.layer;
	  laydate.render({
	     elem: '#time' ,
	     type: 'datetime'
	  });
})


function choice_paper(){
	var courseId=$("#courseId").val();
	if(courseId==null||courseId==""){
		layer.msg("请先选择课程",{icon:2});
		return false;
	}

	  $.ajax({
          url: '<%=path%>/examController/getExamPaperByCourseId',
          data: {courseId:courseId},
          dataType: 'json',
          success: function(data) {
        	  if(data.code == "1"){ //查询数据成功
        		  rdata=data.data;
        	     if(rdata.length==0){
        	         layer.msg("该课程下暂无试卷，请先添加",{icon:2});
        	         return false;
        	     }
        	     $('#myModal').modal('show');
        	     var data_len = rdata.length;
        	     op="";
        	     for(var i = 0;i < data_len; i++){
                     var id = rdata[i].ID;
                     var paperName = rdata[i].PAPERNAME;
                     var totalScore=rdata[i].TOTALSCORE;
                     var passScore=rdata[i].PASSSCORE;
                     var uploadTime=rdata[i].UPLOADTIME;
                     var userName=rdata[i].USERNAME;
                     op += "<option value='"+ id +"' data-total='"+totalScore+"' data-pass= '"+
                     passScore+"' data-user='"+userName+"' data-time='"+uploadTime+"' >"+ paperName +"</option>";
                 }
        	     $("#examPaper").append(op)  ;
        	  }
        	  
          }
	  })
}

function btnSumit(){
	var totalScore=$('#examPaper').find("option:selected").attr("data-total");
	var passScore=$('#examPaper').find("option:selected").attr("data-pass");
	var userName=$('#examPaper').find("option:selected").attr("data-user");
    var uploadTime=$('#examPaper').find("option:selected").attr("data-time");
    var paperId=$('#examPaper').val();
    $("#totalScore").text(totalScore);
    $("#passScore").text(passScore);
    $("#userName").text(userName);
    $("#uploadTime").text(changeDateFormat(uploadTime));
    $('#paperId').val(paperId);
    $('#myModal').modal('hide');
    
}

function addExamArrange(){
	if(checkForm_Arrange()) {
        asyncPaperArrange();
    }
}
function checkForm_Arrange(){
	if($("#courseId").val()==""){
      layer.msg("请选择课程！", {icon: 2})
	  return false;
	}
   if($("#paperId").val()==""){
	  layer.msg("请选择试卷", {icon: 2})
	  return false;
   }
   if($("#time").val()==""){
        layer.msg("请选择考试时间", {icon: 2})
        return false;
    }
   return true;
}
function asyncPaperArrange(){
	var courseId=$("#courseId").val();
	var time=new Date($("#time").val()).getTime();
	console.log(time)
	var paperId=$("#paperId").val();
    var type=$('input[name="type"]:checked').val();;
    $.ajax({
        url: '<%=path%>/examController/addExamArrange',
        data: {
        	courseId:courseId,
        	time:time,
        	paperId:paperId,
        	type:type},
            dataType: 'json',
            success: function(data) {
               layer.msg(data.message, {
                icon: data.code,
                time: 2000 //2秒关闭（如果不配置，默认是3秒）
                }, function(){
                     if(data.code=="1"){
                    	 window.location.href="<%=path%>/gotoExamPlanList";
                     }
               });   
        }
    })
	
}
</script>

</body>
</html>
