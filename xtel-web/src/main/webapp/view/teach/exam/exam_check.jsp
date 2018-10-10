<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>阅卷</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<meta name="description" content="">
<meta name="author" content="">
<link href="<%=path%>/plug-in/bootstrap3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/exam/styles.min.css?v=155b8a0f0957">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/exam/style.css?v=931dbfbf4c57">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/exam/base.css?v=9f5c566a0857">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/css/exam/exam_style.css?v=0d98557bbc57">

</head>
<body>
	<!-- loading -->
	<div class="spinner-wrapper" id="spinnerLoading">
		<div class="spinner">
			<div class="rect1"></div>
			<div class="rect2"></div>
			<div class="rect3"></div>
			<div class="rect4"></div>
			<div class="rect5"></div>
		</div>
	</div>

	<div class="main manmade-mode">

		<div class="body-wrapper">
			<div class="body paper">
		        <div class="questions" id="list-exercises">
		
		        </div>
			</div>
			<div class="nav-wrapper nav-wrapper-l">
				<div class="nav nav-status">
					<ul class="menu-items">
						<li class="menu-item menu-item-user">
						     <input type="hidden" id="examId"/>
							<div class="item-label">考生姓名</div>
							<div class="item-data" id="userName"></div>
						</li>

						<li
							class="menu-item menu-item-exam menu-item-score menu-item-pass">
							<div class="item-label">考试成绩</div>
							<div class="item-data" id="examScore"></div>
						</li>
						<li
							class="menu-item menu-item-exam menu-item-status menu-item-pass">
							<div class="item-label">考试状态</div>
							<div class="item-data" id="passStatus"></div>
						</li>
					</ul>
				</div>
				<div class="nav nav-operation">
					<ul class="menu-items">
						<li class="menu-item menu-item-card" id="numberCardBtn"><i
							class="icon item-icon icon-m_head_test_card"></i> <span
							class="item-label">答题卡</span></li>
					</ul>
				</div>
				<a href="JavaScript:void(0);" onclick="history.go(-1)"
					class="btn btn-primary btn-nav">返回</a>

				<button type="button" class="btn btn-primary btn-nav btn-bottom"
					id="saveCheckResultsBtn">保存</button>
			</div>
		</div>

		<div class="modal fade" id="numberCardModal" tabindex="-1"
			role="dialog">
			<div class="modal-dialog modal-number-card" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" id="card-content">
						<div class="title">答题卡</div>
					</div>
					<div class="modal-footer">
						<span class="box icon-box s2"></span> <span class="icon-label">正确</span>
						<span class="box icon-box s4"></span> <span class="icon-label">错误</span>
					</div>
				</div>
			</div>
		</div>

		<!-- Jquery组件引用 -->
		<script src="<%=path%>/plug-in/jquery/jquery-1.9.1.js"></script>
		<script src="<%=path%>/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=path%>/plug-in/layui/layui.js"></script> 
		<script type="text/javascript">
       var layer;
       var passScore;
       var passScore;
       var path='<%=path%>';
       $(function () {
    	   passScore  = '<%=request.getAttribute("passScore")%>' ;
    	   layui.use('layer', function(){
               layer = layui.layer;
           })
    	   $("#spinnerLoading").addClass("hidden");
    	   loadExercises();
           loadUserAnswers();
           examScore();
     
       //   $("div #list-exercises .questions-content").each(function () {

        //	  $(".question-score input[name='questionScore']").each(function(){
        //		   console.log($(this).val());
        //       }); 
         //  });
          
       });
      

       function examScore(){
    	   var examScore=0; 
    	      $("input[name='questionScore']").each( function(){  
                  examScore+=parseFloat($(this).val());      
              })   
              $("#examScore").text(examScore);
    	      console.log(passScore);
    	      if(passScore<=examScore){
    	    	    $("#passStatus").text("通过");
    	      }else{
    	    	  $("#passStatus").text("未通过");
    	      }
       }
       
       
       //自动算分
       $("body").on("input change", ".operation-check .question-score", function () {
    	   var _this = $(this);
    	   var reg = /^\d+(\.\d+)?$/;
    	   examScore();
       });
       
       
       
      function loadExercises(){
            var paperId = '<%=request.getAttribute("paperId")%>' ;
             $.ajax({
                      type : 'POST',
                      async:false, 
                      url : "<%=path%>/examController/listExercisesByPaperId",
                      data: {paperId:paperId},
                      success : function(data) {
                          if(data.code==1){
                        	  //var examineText = doT.template($("#list_exercises").text());
                        	  //$("#list_exercises").append(examineText(data));
                        	  createQuestionsViewFn(data.data);
                          }else{
                              layer.msg("系统异常", {icon: 2})
                          }  
                          
                        }
                  })           
           }

        //创建题目
       function createQuestionsViewFn(data){
            //题目
            var choiceHtml ="";
            var choiceNum=1;
            //答题卡
            var choiceCard="";
            var choiceTotalScore=0;
            $.each(data, function (index, obj) {
            
                if(obj.TYPE==0){
                    if(choiceHtml==""){
                    	 choiceHtml='<div class="questions-title"><span>单选题(共</span><span id="choice-total"></span><span>题，合计</span><span id="choice-score"></span><span>分)</span></div>';
                    }
                    choiceTotalScore+=obj.SCORE;
                    choiceHtml+='<div class="questions-content"> <div class="question-content" id="question-content-'+obj.ID+
                    '"data-commit="true"><div class="question-operation operation-check"><i class="icon icon-right  icon-m_prompt_correct1" value="'+obj.ID+'"></i>'+
                    '<i class="icon icon-wrong icon-m_prompt_error1 icon-checked"></i><div class="input-group"><input type="text" name="questionScore" id="question-score-'+obj.ID+'" class="form-control question-score"/>'+
                    '<span class="input-group-addon">分</span></div></div><div class="exam-question"><span class="question-index ellipsis">'+
                    choiceNum+'.</span>'+obj.STEM+' (<i id="score-'+obj.ID+'">'+obj.SCORE+'</i>分)</div><div class="answers">';
                    
                    if(obj.OPTION1!= undefined){
                        choiceHtml+=' <div class="select single-select a. "><input type="checkbox" value="A" disabled class="m-option" name="'+obj.ID+'"/> '
                                  +'A.<p class="ue" style="display: inline;">'+obj.OPTION1+'</p></label></div>';
                      }
                    if(obj.OPTION2!= undefined){
                        choiceHtml+=' <div class="select single-select a. "><input type="checkbox" value="B" disabled class="m-option" name="'+obj.ID+'"/> '
                                  +'B.<p class="ue" style="display: inline;">'+obj.OPTION2+'</p></label></div>';
                      }
                    if(obj.OPTION3!= undefined){
                        choiceHtml+=' <div class="select single-select a. "><input type="checkbox" value="C"  disabled class="m-option" name="'+obj.ID+'"/> '
                                  +'C.<p class="ue" style="display: inline;">'+obj.OPTION3+'</p></label></div>';
                      }
                    if(obj.OPTION4!= undefined){
                        choiceHtml+=' <div class="select single-select a. "><input type="checkbox" value="D" disabled class="m-option" name="'+obj.ID+'"/> '
                                  +'D.<p class="ue" style="display: inline;">'+obj.OPTION4+'</p></label></div>';
                      }
                    if(obj.OPTION5!= undefined){
                        choiceHtml+=' <div class="select single-select a. "><input type="checkbox" value="E" disabled class="m-option" name="'+obj.ID+'"/> '
                                  +'E.<p class="ue" style="display: inline;">'+obj.OPTION5+'</p></label></div>';
                      }
                    if(obj.OPTION6!= undefined){
                        choiceHtml+=' <div class="select single-select a. "><input type="checkbox" value="F" disabled class="m-option" name="'+obj.ID+'"/> '
                                  +'F.<p class="ue" style="display: inline;">'+obj.OPTION6+'</p></label></div>';
                      }
                    //正确答案
                    var referenceanswer=obj.REFERENCEANSWER.replace(/#/g," ");
                    choiceHtml+='</div><div class="analysis"> <div class="analysis-row"> <div class="analysis-title" >考生答案：</div> '+
                    '<div class="analysis-content question-com-answer right"  id="answer_'+obj.ID+'"></div> </div><div class="analysis-row">'+
                    '<div class="analysis-title">正确答案：</div><div class="analysis-content question-ans-right" id="ans-right-'+obj.ID+'">'+referenceanswer+'</div></div></div></div></div>';
                                  
                    if(choiceCard==""){
                    	choiceCard=' <div class="card-content" > <div class="card-content-title">单选题</div><div class="split"></div>  <div class="box-list">'
                    }
                    choiceCard+=' <div class="box normal-box s4"><a href="#question-content-'+obj.ID+'" class="iconBox questions_'+obj.ID+'"  id="card_'+obj.ID+'">'+choiceNum+'</a> </div>';
       
                    choiceNum++;
                }
            })
            choiceCard+='</div></div>';
     
            $("#list-exercises").append(choiceHtml);
            $("#card-content").append(choiceCard);
            $("#choice-total").html(--choiceNum);
            $("#choice-score").text(choiceTotalScore);
        }
       // ajaxstart with loading shown
       $( document ).ajaxStart(function() {
           $("#spinnerLoading").removeClass("hidden");
       });
       // ajaxstop with loading hidden
       $( document ).ajaxStop(function() {
         $("#spinnerLoading").addClass("hidden");
       });

    function loadUserAnswers(){
    	var id = '<%=request.getAttribute("id")%>' ;
        $.ajax({
            async:false, 
            type : 'POST',
            url : "<%=path%>/examController/getUserDetailAnswers",
            data: {id:id},
            success : function(data) {
                if(data.code==1){
                	var rdata=data.data;
                	var len=rdata.length;
                	for(var j = 0; j < len; j++ ) {
                		var answers=rdata[j].ANSWER;
                        var exerId=rdata[j].EXERID;
                       
                		var array=answers.split("#");
                		
                		var user_answer=answers.replace(/#/g," ");
                		
                		var ansRight=$("#ans-right-"+exerId).text();
                		//判断考生答案和正确答案是否相等
                		if(ansRight==user_answer){
                        //选项卡颜色设置
                          var card_div=$("#card_"+exerId).parent();
                          card_div.removeClass("s4");
                          card_div.addClass("s2");
                          //自动阅卷
                          $("#question-content-"+exerId+" .icon-wrong").removeClass("icon-checked");
                          $("#question-content-"+exerId+" .icon-right").addClass("icon-checked");
                          var score=$("#score-"+exerId).text();
                          $("#question-score-"+exerId).val(score);
                		}else{
                	      $("#question-score-"+exerId).val(0);
                		}
                		
                		//设置考生答案
                		$("#answer_"+exerId).html(user_answer);
                		for(k = 0,length=array.length; k< length; k++) {
                	    	$("input[name='"+exerId+"'][value='"+array[k]+"']").prop("checked", "checked"); 
                	    	//设置选中选项颜色
                	    	var check_div=$("input[name='"+exerId+"'][value='"+array[k]+"']").parent();
                	    	check_div.addClass("checked");
                		}            		  
                	}
                }else{
                	layer.msg("系统异常", {icon: 2})
                }  
                
              }
        })    
    }
    
    $("i.icon-right").click(function (e) {
    	console.log($(".icon-right").val());
    	
    	
    })
    
    //   $("body").on("click", ".icon-right", function (e) {
    //	    console.log(2424);
    //   }
   </script>
   <script type="text/javascript"  src="<%=path%>/js/exam/exam_check_results.js"></script>
</body>
</html>
