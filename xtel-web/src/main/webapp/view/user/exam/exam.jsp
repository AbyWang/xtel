<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<link href="<%=path%>/css/exam/exam-main.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/css/exam/test.css" rel="stylesheet" type="text/css" />
<style>
.hasBeenAnswer {
	background: #5d9cec;
	color:#fff;
}
</style>

</head>
<body>
<div class="main">
	<div class="test_main">
		<div class="nr_left">
			<div class="test">
				<form action="" method="post">
					<div class="test_title">
						<p class="test_time">
							<i class="icon iconfont">&#xe6fb;</i><b class="alt-1"></b>
						</p>
						<font><input type="button"  onclick="handOver()" value="交卷"></font>
					</div>
					<div id="choice_content">
					</div>			
				</form>
			</div>
		</div>
		<div class="nr_right">
			<div class="nr_rt_main">
				<div class="rt_nr1">
					<div class="rt_nr1_title">
						<h1>
							<i class="icon iconfont">&#xe692;</i>答题卡
						</h1>
					</div>				
				</div>
			</div>
		</div>
	</div>
</div>
<script src="<%=path%>/plug-in/jquery/jquery-1.9.1.js"></script>
<!-- Layer组件引用 -->
<script type="text/javascript" src="<%=path%>/plug-in/layui/layui.js"></script>
<script>
    var examId ;
  
	$(function() {
		examId= '<%=request.getAttribute("examId")%>' ;
		loadExercises();
		$('li.option label').click(function() {
			var examId = $(this).closest('.test_content_nr_main').closest('li').attr('id'); // 得到题目ID
			var cardLi = $('a[href=#' + examId + ']'); // 根据题目ID找到对应答题卡

			// 设置已答题
			if(!cardLi.hasClass('hasBeenAnswer')){
				cardLi.addClass('hasBeenAnswer');
			}
		});
	});
	
	function loadExercises(){
	    var paperId = '<%=request.getAttribute("paperId")%>' ;
		 $.ajax({
		          type : 'POST',
		          async:false, 
		          url : "listExercisesByPaperId",
		          data: {paperId:paperId},
		          success : function(data) {
		        	  if(data.code==1){
		        		     createQuestionsViewFn(data.data);
		        	  }else{
		        		  layer.msg("系统异常", {icon: 2})
		        	  }  
		            }
		      })		   
	   }
	
	function createQuestionsViewFn(data){
		 //题目
		 var choiceHtml ="";
		 var choiceNum=1;
		 //答题卡
		 var choiceCard="";
		 var choiceTotal=0;
         $.each(data, function (index, obj) {
         if(obj.TYPE==0){
        	  if(choiceHtml==""){
        		 choiceHtml=' <div class="test_content"><div class="test_content_title"> <h2>选择题</h2><p> <span>共</span><i class="content_lit"></i><span>题，</span>'
                           +'<span id="choice-total">合计</span><i class="content_fs"></i><span>分</span></p></div></div>';
                }
        	   choiceTotal+=obj.SCORE;
                choiceHtml+='<div class="test_content_nr"><ul><li class="m-example" id="'+obj.ID+'" questionid="'+obj.ID+'">  <div class="test_content_nr_tt"><i>'
                        +choiceNum+'</i><span>('+obj.SCORE+'分)</span><font>'+obj.STEM+'</font> </div> <div class="test_content_nr_main"><ul>'

        	   if(obj.OPTION1!= undefined){
        		  choiceHtml+='<li class="option"><label ><input type="checkbox" value="A" class="m-option" name="'+obj.ID+'"/> '
                            +'A.<p class="ue" style="display: inline;">'+obj.OPTION1+'</p></label> </li>';
        	    }
              if(obj.OPTION2!= undefined){
                  choiceHtml+='<li class="option"> <label ><input type="checkbox" value="B" class="m-option" name="'+obj.ID+'"/> '
                            +'B.<p class="ue" style="display: inline;">'+obj.OPTION2+'</p></label> </li>';
                }
              if(obj.OPTION3!= undefined){
                  choiceHtml+='<li class="option"><label ><input type="checkbox" value="C" class="m-option" name="'+obj.ID+'"/> '
                            +'C.<p class="ue" style="display: inline;">'+obj.OPTION3+'</p></label> </li>';
                } 
              if(obj.OPTION4!= undefined){
                  choiceHtml+='<li class="option"> <label ><input type="checkbox" value="D" class="m-option" name="'+obj.ID+'"/> '
                            +'D.<p class="ue" style="display: inline;">'+obj.OPTION4+'</p></label> </li>';
              }
              if(obj.OPTION5!= undefined){
                  choiceHtml+='<li class="option"> <label ><input type="checkbox" value="E" class="m-option" name="'+obj.ID+'"/> '
                            +'E.<p class="ue" style="display: inline;">'+obj.OPTION5+'</p></label> </li>';
                }
              if(obj.OPTION6!= undefined){
                  choiceHtml+='<li class="option"><label ><input type="checkbox" value="F" class="m-option" name="'+obj.ID+'"/> '
                            +'F.<p class="ue" style="display: inline;">'+obj.OPTION6+'</p></label> </li>';
                } 
              
              //选项卡
              if(choiceCard==""){
                  choiceCard='<div class="rt_content"><div class="rt_content_tt"><h2>选择题</h2><p>'
                          +'<span>共</span><i class="content_lit"></i><span>题</span></p></div>'
                          +'<div class="rt_content_nr answerSheet"><ul>'
                }
              choiceCard+='<li><a href="#'+obj.ID+'">'+choiceNum+'</a></li>';
              choiceHtml+='</ul></div></li></ul></div>';
              choiceNum++;
        	 }
          })
          choiceCard+='</ul></div></div>';
          $("#choice_content").append(choiceHtml);
          $(".rt_nr1").append(choiceCard);
         //选择题数量
         $(".content_lit").text(--choiceNum);
         $("#choice-total").text(choiceTotal);
	}
     // 交卷
	function handOver(){
        var answers="";
        
	    $("div .test_content_nr").each(function (index, element) {
	        var commit_li = $(this).find(".m-example");
	        var exerId= commit_li[0].getAttribute("questionid");
	        var checkValue ="";
	     //   $('div.test_content_nr_main input[type=checkbox]:checked').each(function(){ 
	        $(this).find(".test_content_nr_main  input[type=checkbox]:checked").each(function(){ 
	        	checkValue+=$(this).val()+"#";
	        }); 
	        var keyValue=exerId+"@"+checkValue;
	        answers+=keyValue+",";
	        
	    }); 

           //保存
	       $.ajax({
               type : 'POST',
               async:false, 
               url : "<%=path%>/examController/addExamRecord",
               data: {
            	       examId:examId,
                       answers:answers},
             success : function(data) {
                   layui.use('layer', function(){
                   layer= layui.layer;
            	   layer.msg(data.message, {
                       icon: data.code,
                     }, function(){
                           if(data.code=="1"){
                        	   window.location.href="<%=path%>/gotoExamArrangeList"; 
                           }
                     });   
                 })
               }
	       })
	    }
	    
</script>
</body>
</html>
