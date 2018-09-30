<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo user=(UserInfo)session.getAttribute("userInfo");
Integer userId=user.getUserId();
String userName=user.getUserName();
session.setAttribute("userId", userId);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="plug-in/bootstrap3.3.5/css/bootstrap.min.css?v=246e02790957" >
<link rel="stylesheet" type="text/css" href="css/exam/ksx-base.css?v=7ff9830e7957">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/exam/styles.min.css?v=155b8a0f0957">

<link href="plug-in/layui/css/layui.css" rel="stylesheet">
<link href="css/exam/addExam.css" rel="stylesheet">
<!-- Jquery组件引用 -->
<script src="plug-in/jquery/jquery-1.9.1.js"></script>
<!-- bootstrap table组件以及中文包的引用 -->
<link href="plug-in/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<script src="plug-in/bootstrap-table/bootstrap-table.js"></script>
<script src="plug-in/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<title>组卷</title>
</head>
<div class="viewFrameWork sidebar-full" id="viewFrameWork">
   <div class="viewFrameWork-main">
   <div class="viewFrameWork-body">
            <!-- loading -->
        <div class="spinner-wrapper hidden" id="spinnerLoading">
                <div class="spinner">
                    <div class="rect1"></div>
                    <div class="rect2"></div>
                    <div class="rect3"></div>
                    <div class="rect4"></div>
                    <div class="rect5"></div>
                </div>
           </div>
        <div class="body-wrapper">
        <div class="body-content">
        <div class="cont-r">
        <div role="tabpanel" class="tab-area tab-col4">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active step1">
                    <a href="#createTest1" aria-controls="create1" role="tab" data-toggle="tab">
                        第一步:创建试卷
                    </a>
                </li>
                <li role="presentation" class="step2">
                    <a href="#createTest2" aria-controls="create2" role="tab" data-toggle="tab">
                        第二步:组卷方式
                    </a>
                </li>
                <li role="presentation" class="step3">
                    <a href="#createTest3" aria-controls="create3" role="tab" data-toggle="tab">
                        第三步:添加试题
                    </a>
                </li>
             <!--   <li role="presentation" class="step4">
                    <a href="#createTest4" aria-controls="create4" role="tab" data-toggle="tab">
                        第四步:发布考试
                    </a>
                </li> --> 
            </ul>
            <form action="" name="form" method="post" id="subForm">
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="createTest1">
                        <div class="create-test-area new-test-aera clearfix">
                            <div class="create-test-box guide col-xs-10 col-md-offset-1 animate" step="2">
                                <h3>
                                    <input name="" type="radio" value="" checked class="new-test" />
                                    创建新试卷
                                </h3>
                                <div class="ctb-row">
                                    试卷名称：
                                    <input type="text" name="paperName" id="paperName" placeholder="请输入试卷名称" value="" />
                                    <span class="f-style4">*</span>
                                </div>
                                <div class="ctb-row">
                                   课程：
                                    <select id="courseId" name="courseId"  placeholder="群组">   
                                     <option value=''>---请选择---</option>   
                                     <c:forEach var="item" items="${courseList}">   
                                     <option value='${item.COURSEID}'>  
                                         ${item.NAME}  
                                      </option>   
                                     </c:forEach>   
                                    </select>
                                </div>
                                <div class="btn-div">
                                    <button  type="button" class="btn btn-primary btn-step1 guide-btn">下一步</button>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <!--第二步-->
                    <div role="tabpanel" class="tab-pane" id="createTest2">
                        <div class="create-test-area in-hand clearfix">
                            <div class="create-test-box guide animate col-xs-10 col-md-offset-1" step="3">
                                <h3>
                                    <input name="" type="radio" value="" checked="checked" class="item-in-lib" />
                                    从试题库中选题
                                </h3>
                                <div class="ctb-row pick-in-lib">
                                    组卷方式：
                                    <span class="lib-type1 type1" name="paper_type_sel" title="勾选想出的题生成一份试卷" data-toggle="tooltip" data-placement="bottom">选题组卷</span>
                                   <input type="hidden" value="1" name="paper_type" id="paper_type_select" />   
                                </div>
                                <div class="btn-div">
                                    <button type="button" class="btn btn-primary btn-random guide-btn" id="nextStep_2">下一步</button>
                                </div>
                            </div>
             
                        </div>
                    </div>
                    <!--第三步-->
                   <div role="tabpanel" class="tab-pane" id="createTest3">
                        <div class="input-questions-area clearfix">
                            <div class="info-board">
                                <div class="total">
                                    <p>总题数：<span class="test_total">0</span>题</p>
                                    <p>当前总分：<span class="total_score">0</span>分</p>
                                    <p>及格分数：<input type="text" id="passScore">分</p>
                                </div>
                            </div>
                            <div class="questions-board">
                                <h3><input class="edit-paper-name form-control" type="text" id="edit_paper_name" name="edit_paper_name" value="demo" placeholder="点击输入试卷名称"></h3>
                                <p class="emptyTip">当前试卷还是空空如也，点击下方添加新题型！</p>
                                <div class="group_main"></div>
                                <div class="ipt-questions-box ipt-questions-box-w com-drop">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-default btn-s-blue dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                            <span class="txt">添加试题</span>
                                            <span class="arrow-d glyphicon glyphicon-triangle-bottom"></span>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-blue" role="menu">
                                            <li><a href="javascript:void(0)"; class="questionType_add" num="0">选择题</a></li>
                                            <li><a href="javascript:void(0)"; class="questionType_add" num="1">问答题</a></li>
                                            <li><a href="javascript:void(0)"; class="questionType_add" num="2">填空题</a></li>
                                        </ul>
                                    </div>                                             
                                     <div class="btn-div">
                                      <a id="savePaperBtn" type="button" class="btn btn-primary btn-step3">
                                        保存试卷
                                    </a>
                                   </div>
                                </div>
                            </div>            
                        </div>
                    </div>
                  <!-- 第四步
                <div role="tabpanel" class="tab-pane table-content" id="createTest4">
                    <div class="issue-area clearfix">
                        <form class="form-horizontal" action="" name="form"
                              method="post" id="subForm">
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
                                               <input type="hidden" name="courseid"  />
                                                <input type="text" name="courseName" class="form-control hasUsingFormDom"
                                                       id="courseName" placeholder="请输入考试考试课程"  value="" />
                                            </div>
                                        </div>

                                        <div class="form-group answer-time">
                                            <label class="col-sm-2 control-label">答卷时长</label>
                                            <div class="col-sm-10">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="examTimeRestrict" checked value="1"/>
                                                        <input type="text" value="60" name="examTime" class="form-control form-control-inline width-62 fl hasUsingFormDom" /><span> 分钟</span>
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
                                            <label for="passMark" class="col-sm-2 control-label">及格分数</label>
                                            <div class="col-sm-10">
                                                <input type="text" name="passMark" class="form-control form-control-inline width-62 fl hasUsingFormDom" id="passMark"  value="3" />
                                            </div>
                                        </div>
 

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">考试说明</label>
                                            <div class="col-sm-10">
                                                <div class="" id="noticeEditor"></div>
                                                <input type="text" name="beforeAnswerNotice" class="hasUsingFormDom hidden" >
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
                                                    <a href="" target="_blank">编辑试卷</a>
                                                    <i class="icons8-edit"></i>
                                                </div>
                                            </div>
                                            <div class="panel-body">

                                                <div class="form-row">
                                                    <span class="title">总分:</span>
                                                    <span class="content paper-total-score"></span>
                                                </div>
                                                <div class="form-row">
                                                    <span class="title">创建人:</span>
                                                    <span class="content paper-create-user-name"></span>
                                                </div>
                                                <div class="form-row">
                                                    <span class="title">试题数量:</span>
                                                    <span class="content paper-test-count"></span>
                                                </div>
                                                <div class="form-row">
                                                    <span class="title">创建日期:</span>
                                                    <span class="content paper-created-time"></span>
                                                </div>
                                                <div class="text-center"> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                             </form>
                           </div>
                    </div>
                   
                   -->
        <div class="group_simple" id="group_simple">
            <div class="questions-group group_title">
                <h4>
                    <input type="text" class="q-ipt q-ipt-t-s" name="test_tittle" />
                    <span class="inline-ite">每题<input type="text" name="test_peer_score">分</span>
                </h4>
            </div>
            <div class="group_questionShow">
                <div class="manual-cont">
                </div>
            </div>
         <!--  <div class="group_questionAdd">
                <div class="questions-group">
                    <h4><input type="text" placeholder="试题描述" name="question" class="q-ipt q-ipt-t"></h4>
                    <div class="questionContent">
                    </div> 
                    <div class="btn-div">
                        <button class="btn btn-blue-border2 saveQuestionBtn btn-default" type="button">保存</button>
                        <input type="hidden" name="tab_num" value="4" />
                    </div>
                </div>
            </div> -->  
        <div id="paperTpye1" style="display:none">
            <div class="extract-box-tit">
                <span class="questionTypeText"></span>
                <div class="extract-box-btnDiv">
                    <span class="t">
                        <a class="btn btn-blue-border2 selQuestionLink" href="javascript:void(0)">
                        <i class="icons8-edit-property"></i>
                        <span>选择试题</span>
                        </a>
                    </span>
                </div>
                <input type="hidden" class="questions" name="test_ids" value="" />
            </div>
        </div>
        <input type="hidden" name="add_style" value="select" />

        <div id="iframe-box"></div>
        <input type="hidden" name="paper_name" value="12414" />
        <input type="hidden" name="paper_style" value="140624" />
                      </div>
                      </div>
                   </div>
                </div>
            </div>
         </div>
   </div>
   </div>

    <!-- Jquery组件引用 -->
    <script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
    <script src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
    <!-- Validform组件引用 -->
    <script type="text/javascript" src="plug-in/Validform/Validform_v5.3.2.js"></script> 
    <script type="text/javascript" src="plug-in/layui/layui.js"></script>  
    <script type="text/javascript" src="plug-in/wangEditor/release/wangEditor.min.js"></script>  
    <script src="plug-in/layui/layui.js"></script>
  <script>
       var layer;
       var path = "<%=path%>";

        $(function() {
            layui.use('layer', function(){
                 layer = layui.layer;
            });
            $('.in-lib').hide();
            $('.pick-random').hide();
            //点击下一步切换标签，跳转到第二步
            $('.btn-step1').click(function() {
                if($("input[name=paperName]").val()==""){
                    layer.msg('请输入试卷名称', {
                        icon: 2,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                      });  
                    return;
                }else if($("input[name=paperName]").val().length > 50){
                    layer.msg('试卷名称不得大于50字！', {
                        icon: 2,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                      }); 
                    return;
                }

                if($("select[name=courseId]").val()==0){
                    layer.msg('请选择试卷分类', {
                        icon: 2,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                      }); 
                    return;
                }
                $('.step2').addClass('active');
                $('#createTest2').addClass('active');
                $('#createTest1').removeClass('active');
                $(".step1").removeClass('active');
            });
    
      $("#nextStep_2").click(function(e) {
          $("input[name=add_style]").val("select");
       //   $("input[name=classification]").val("");
          var type = $("#paper_type_select").val(); //
          $('.step3').addClass('active');
          $('#createTest3').addClass('active');
          $('#createTest2').removeClass('active');
          $(".step2").removeClass('active');
          $("#edit_paper_name").val($("#paperName").val());
       });
      /**
      $("#lastStep").click(function(e) {
          $('.step4').addClass('active');
          $('#createTest4').addClass('active');
          $('#createTest3').removeClass('active');
          $(".step3").removeClass('active');
          $("#edit_paper_name").val($("#paperName").val());
       });*/
            //从题库中选题
            $('.pick-in-lib').children().eq(0).click(function() {
                $(this).addClass('lib-type1').removeClass('lib-type0')
                $('.pick-in-lib').find('span').eq(1).addClass('lib-type0').removeClass('lib-type1');
                $('.pick-in-lib').find('span').eq(2).addClass('lib-type0').removeClass('lib-type1');
                var a = 1;
            });
            $('.pick-in-lib').children().eq(1).click(function() {
                $(this).addClass('lib-type1').removeClass('lib-type0');
                $('.pick-in-lib').find('span').eq(0).addClass('lib-type0').removeClass('lib-type1');
                $('.pick-in-lib').find('span').eq(2).addClass('lib-type0').removeClass('lib-type1');
                var a = 2;
            });
            $('.pick-in-lib').children().eq(2).click(function() {
                $(this).addClass('lib-type1').removeClass('lib-type0');
                $('.pick-in-lib').find('span').eq(0).addClass('lib-type0').removeClass('lib-type1');
                $('.pick-in-lib').find('span').eq(1).addClass('lib-type0').removeClass('lib-type1');
                var a = 3;
            });
            function Get_Cookie( a ) {

                var start = document.cookie.indexOf( a + "=" );
                var len = start + a.length + 1;
                if ( ( !start ) &&
                    ( a != document.cookie.substring( 0, a.length ) ) )
                {
                    return 0;
                }
                if ( start == -1 ) return 0;
                var end = document.cookie.indexOf( ";", len );
                if ( end == -1 ) end = document.cookie.length;
                return unescape( document.cookie.substring( len, end ) );
            }
        })
        
           $('.create-test-bar3').click(function(e) {
                e.stopPropagation();
                e.preventDefault();
                $(this).parent().hide();
                $('.in-hand').find('.item-in-lib').prop('checked', true);
                $('.in-hand').find('.item-in-hand').prop('checked', false);
                $('.in-hand').show();
            });
            $('.create-test-bar4').click(function(e) {
                e.stopPropagation();
                e.preventDefault();
                $(this).parent().hide();
                $('.in-lib').find('.item-in-hand').prop('checked', true);
                $('.in-lib').find('.item-in-lib').prop('checked', false);
                $('.in-lib').show();
            });
            
             var is_first_visit="";
            //添加试题操作
            $(".questionType_add").click(function(){
                $(".com-drop ").addClass("buttonLeft");
                $(".emptyTip").hide();
            })
        	$(".tooltip-disorder").tooltip();

        var scroll_now_idx = 0;//记录滚动到视野中的大题index
        //视窗滚动事件
        $(".viewFrameWork-body").scroll(function(){
            var box_height = $("#viewFrameWork").height();
            var left_height = $(".info-board").height();
            var right_height = $(".questions-board").height();
            $(".info-board .item").removeClass("item-active");
            //当左侧侧边栏的高度小于页面高度时，侧边栏固定
            if(left_height+173 < box_height) {
                $(".info-board").offset({
                    top: 173
                });
                //左侧侧边栏的高度大于页面高度的时候，与页面联动
            }
            else{
                for(var i=0;i<$(".questions-board .group_simple").length;i++){
                    var first_child = $(".questions-board .group_simple:eq("+i+") .group_title");
                    var last_child = $(".questions-board .group_simple:eq("+i+") .manual-cont");
                    if(last_child.children(".questions").length > 0){
                        last_child = last_child.children(".questions:last");
                    }
                    if(first_child.offset().top<173 && last_child.offset().top>100){
                        scroll_now_idx = i;
                    }
                }
                var scroll_distance = 0;
                for(var i=0;i<scroll_now_idx;i++){
                    scroll_distance += $(".info-board .item:eq("+i+")").height();
                }
                $(".info-board .item:eq("+scroll_now_idx+")").addClass("item-active");
                $(".info-board").offset({
                    top: -scroll_distance+173-scroll_now_idx*43
                });
            }
        });
        //左侧item click事件
        var leftItemClick = function(that) {
            var box_height = $("#viewFrameWork").height();
            var right_height = $(".questions-board").height();
            var idx = $(that).index();
            var click_distance = 0;
            for (var i = 0; i < idx; i++) {
                click_distance += $(".questions-board .group_simple:eq(" + i + ")").height();
            }
            if($(".viewFrameWork-body").scrollTop()+box_height<right_height){
                $(".viewFrameWork-body").animate({
                    scrollTop: click_distance + 43 * idx + 161
                }, 600);
            }
            $(".info-board .item").removeClass("item-active");
            $(that).addClass("item-active");
        }
        $(".info-board .item").click(function(){
            leftItemClick(this);
        });
    </script>
    <script src="js/common.js"></script>
    <script type="text/javascript" src="<%=path%>/js/exam/addExam.js?v=d62fa946b957"></script>
</body>
</html>
