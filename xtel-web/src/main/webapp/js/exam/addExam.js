var localObj = window.location;
var contextPath = localObj.pathname.split("/")[1];
var path = localObj.protocol+"//"+localObj.host+"/"+contextPath;
var updateQuestionId = "";
var paper_type = $("input[name=paperType]").val();
var selTr = "";
var selType = ""; //存储试题分类
var commit_ids = "";//存储已选试题id
var typeObject = {
    "1": [],
    "2": [],
    "3": []
};
var layer;
$(document).ready(function () {
    //更改考试名称输入框失焦时 替换隐藏的考试名称
    $("input[name=edit_paper_name]").blur(function () {
        if ($(this).val() !== $("#asyncForm_paper input[name=paperName]").val()) {
            $("#asyncForm_paper input[name=paperName]").val($(this).val());
        }
    });
    
    layui.use('layer', function(){
       layer = layui.layer;
        })
        //保存大题默认名称
    var queName = "";
    //创建新的大题
    $("a.questionType_add").click(function (e) {
        // 收起选择试题类型
        $(this).parents(".btn-group").removeClass("open");
        var type = $(this).attr("num");
        var sortRandom = Math.random(); //随机数用于移动顺序
        $("#group_simple").find(".questionTypeText").text($(this).text());
        $("#group_simple").find("input[name=test_tittle]").attr("sort", sortRandom);
        $("#group_simple").find("input[name=test_peer_score]").attr("sort", sortRandom);
        
        var html = '<div class="group_simple" questionType="' + type + '" sort="' + sortRandom + '">' + $("#group_simple").html() + '</div>';
        $("div.group_main").append(html);
        var $group = $(".group_main .group_simple").last();

        $(".options-disorder .tooltip-disorder").tooltip();

        //试卷大题默认名称，可修改
        switch (type) {
            case "0":
                queName = "单选题";
                break;
            case "1":
                queName = "问答题";
                break;
            case "2":
                queName = "填空题";
                break;
        }
        var inputBox = $("div[questionType=" + type + "]").find("input[name=test_tittle]");
        inputBox = inputBox.eq(inputBox.length - 1);
        inputBox.val(queName);
        //左侧添加相应大题信息
        var htmlLeft = '<div onclick="leftItemClick(this)" class="item group_simple left_group_simple animate" sort="' + sortRandom + '">' +
            '<p><h3 class="test_tittle" sort="' + sortRandom + '">' + queName + '</h3> <a href="javascript:void(0)" class="m-content-trash icons8-trash-can" aria-hidden="true" title="移除" sort="' + sortRandom + '"></a></p>' +
            '<p>共<span class="test_num" sort="' + sortRandom + '">0</span>题；<a href="javascript:void(0)" class="m-content-up glyphicon glyphicon-menu-up" aria-hidden="true" title="上移" sort="' + sortRandom + '"></a></p>' +
            ((type == "6" && paper_type == "1") ? '' : '<p>每题<input type="text" name="test_peer_score" line-height: 15px" sort="' + sortRandom + '">分') +
            '<a href="javascript:void(0)" class="m-content-down glyphicon glyphicon-menu-down" aria-hidden="true" title="下移" sort="' + sortRandom + '"></a></p>' +
            '</div>';
        $(".info-board .total").before(htmlLeft);

        //如果是选择试题
        if ($("input[name=add_style]").val() == "select") {
            if (type == "6" && paper_type == "1") {
                $($group).find(".inline-ite").hide();
            }
            showOptionScore(sortRandom, type);
        }

        changeLeftInfoFn(inputBox, 3, queName);


    });
    
    //联动左右大题信息
    $("body").on("keyup", ".info-board input[name=test_peer_score]", function (e) {
        changeLeftInfoFn(this, 1, queName);
    });

    $("body").on("keyup", ".group_main .group_simple input[name=test_peer_score]", function (e) {
        $(this).parents(".group_simple").find("input[name=per_score]").val($(this).val());
        changeLeftInfoFn(this, 2, queName);
    });

    $("body").on("keyup", ".group_main .group_simple input[name=test_tittle]", function (e) {
        changeLeftInfoFn(this, 3, queName);
    });

    // 若每小题分数与大题设置不同，则清空左侧和大题每题分数
    $("body").on("keyup", ".group_main .group_simple input[name=per_score]", function (e) {
        var $group = $(this).parents(".group_simple");
        var type = $($group).attr("questionType");
        if (type != 6) {
            var per_obj = $($group).find("input[name=test_peer_score]");
            per_obj.val("");
            changeLeftInfoFn(per_obj, 2, queName);
        } else {
            // 组合题不对每题设置分数（本身相当于一道大题）
            var score = $(this).val();
            $(this).parents(".m-example").find(".member-score").val(score);
            totalScoreFn();
        }
    });

    $("body").on("keyup", ".group_main .group_simple input.member-score", function (e) {
        $(this).val($.trim($(this).val()));
        var value = $(this).val();
        if (value == '' && isNaN(value) && value % 0.5 != 0) {
            alert('分数为数字且为0.5的倍数!');
        }
        var $example = $(this).parents(".m-example");
        $($example).find("input[name=per_score]").val("");
        totalScoreFn();
    });

    //移除添加的试题
    $("body").on("click", ".m-example-remove", function (e) {
        totalTestNumFn($(this).parents(".group_simple").attr("sort"), 2);
        $(this).parents(".m-example").remove();
        totalScoreFn();
    });

    //左侧大题移除
    $("body").on("click", ".m-content-trash", function (e) {
        e.stopPropagation();
        e.preventDefault();
        var parentDom = $("div.left_group_simple");
        var contentDom = $(".group_main .group_simple");
        var sortId = $(this).attr("sort");
        var r = confirm("确认移除已添加的大题？");
        if (r == true) {
            //左侧移除
            parentDom.each(function (index, element) {
                var objId = $(this).attr("sort");
                if (objId === sortId) {
                    $(this).remove();
                    return;
                }
            });
            //右侧移除
            contentDom.each(function (index, element) {
                var objId = $(this).attr("sort");
                if (objId === sortId) {
                    $(this).remove();
                    return;
                }
            });
            totalScoreFn();
        }
        // 当删除完所有题型时，恢复添加试题按钮样式以及空题型提示
        var totalLength = $(".group_main .group_simple").length;
        if (totalLength == 0){
            $("#manualInput .questions-board .com-drop ").removeClass("buttonLeft");
            $("#manualInput .questions-board .emptyTip").show();
        }
    });

    //保存试卷
    $("body").on("click", "#savePaperBtn", function (e) {
        e.preventDefault();
        e.stopPropagation();
        if (checkForm_paper()) {
                asyncPaperSub();
        }
    });

    //选题组卷选择试题
    $("body").on("click", "a.selQuestionLink", function (e) {
        e.stopPropagation();
        e.preventDefault();
        showSelQuestions(this);
    });

    //根据组卷类型显示不同默认模板及标题
    paperTypeShowTemp();

    //每题分数限制为0.5的倍数
    $("body").on("change", "input[name='option_peer_score']", function (e) {
        e.stopPropagation();
        e.preventDefault();
        var score = $(this).val();
        if (score % 0.5 != 0) {
          layer.msg("请保证每题分数为0.5的倍数!", {icon: 2})
        }
        ;
    });

    
    //左侧大题下移
    $("body").on("click", ".m-content-down", function (e) {
        e.stopPropagation();
        e.preventDefault();
        var parentDom = $("div.left_group_simple");
        var contentDom = $(".group_main .group_simple");
        var sortId = $(this).attr("sort");
        if (parentDom.length > 1) {
            //左侧移动
            parentDom.each(function (index, element) {
                var objId = $(this).attr("sort");
                if ((objId === sortId) && (index != parentDom.length - 1)) {
                    $(parentDom[index + 1]).after($(this).clone());
                    $(this).remove();
                    return;
                }
            });
            //右侧移动
            contentDom.each(function (index, element) {
                var objId = $(this).attr("sort");
                if ((objId === sortId) && (index != parentDom.length - 1)) {
                    $(contentDom[index + 1]).after($(this).clone());
                    $(this).remove();
                    return;
                }
            });

        }
    });

    //左侧大题上移
    $("body").on("click", ".m-content-up", function (e) {
        e.stopPropagation();
        e.preventDefault();
        var parentDom = $("div.left_group_simple");
        var contentDom = $(".group_main .group_simple");
        var sortId = $(this).attr("sort");
        if (parentDom.length > 1) {
            //左侧移动
            parentDom.each(function (index, element) {
                var objId = $(this).attr("sort");
                if ((objId === sortId) && (index != 0)) {
                    $(parentDom[index - 1]).before($(this).clone());
                    $(this).remove();
                    return;
                }
            });
            //右侧移动
            contentDom.each(function (index, element) {
                var objId = $(this).attr("sort");
                if ((objId === sortId) && (index != 0)) {
                    $(contentDom[index - 1]).before($(this).clone());
                    $(this).remove();
                    return;
                }
            });

        }
    });


});

//试卷验证表单选项
function checkForm_paper() {

    var reg = /^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$/;

    var test_peer_score = true;
    $(".group_main input[name=test_peer_score]").each(function (index, element) {
        if ($(this).val() == "") {
            test_peer_score = false;
            return false;
        }
    });
    var question_per_score = true;
    $(".group_main input[name=per_score]").each(function (index, element) {
        var type = $(this).parents(".group_simple").attr("questionType");
        if (!reg.test($(this).val())) {
            question_per_score = false;
            return false;
        }
    });

    // 检查每道大题下是否有小题
    var group_test_num = true;
    $(".info-board .left_group_simple").each(function (index, element) {
        if ($($(this).find(".test_num")[0]).text() == '0') {
            group_test_num = false;
            return false;
        }
    });
    
    if ($("input[name=per_score]").length == 0 && test_peer_score === false) {
   	   layer.msg("请填写每题分数", {icon: 2})
        return false;
    }
    if (question_per_score === false) {
    	layer.msg("请检查小题分数！", {icon: 2})
        return false;
    }
    
    if (group_test_num === false) {
        layer.msg("每道大题中至少添加一道小题！", {icon: 2})
        return false;
    }

    if ($(".total_score").text() == '0') {
        layer.msg("请至少添加一道试题！", {icon: 2})
        return false;
    }
    if ($("#passScore").val() == null||$("#passScore").val()=="") {
        layer.msg("请输入及格分数！", {icon: 2})
        return false;
    }
    
    return true;
}

//异步提交表单保存试卷
function asyncPaperSub(obj) {
  //  var dataForm = $('#asyncForm_paper').serialize();
    var paperName=$("#paperName").val();
    var courseId=$("#courseId").val();
    var totalScore=$(".total_score").text();
    var passScore=$("#passScore").val();
    //不显示已选择的试题
    var exsit_ids="";
    $("div.group_main .group_simple").each(function (index, element) {
        var commit_divs = $(this).find(".m-example");
        for (var i = 0; i < commit_divs.length; i++) {
        	var perScore=commit_divs.find("input").val();
        	console.log(perScore);
        	var id2Score=perScore+"@"+commit_divs[i].getAttribute("questionid")
        	exsit_ids = exsit_ids + id2Score + ',';
        }
    }); 
    var params={
    		paperName:paperName,
    		courseId:courseId,
    		totalScore:totalScore,
    		exerIds:exsit_ids,
    		passScore:passScore
    } 
    $.ajax({
        type: "POST",
        cache: false,
        headers: {"cache-control": "no-cache"},
        dataType: "json",
        url: "examController/addExam",
        data: params,
        success: function (data) {
           layer.msg(data.message, {
   			  icon: data.code,
   			  time: 2000 //2秒关闭（如果不配置，默认是3秒）
   			}, function(){
   		          if(data.code=="1"){
   		        	  window.location.href=path+"/gotoExamPaperList"
   	              }
   			});   
        },complete: function(XMLHttpRequest, textStatus) {console.log(textStatus); },
    });
}


//根据组卷类型显示不同默认模板及标题
function paperTypeShowTemp() {
    var title = $("#tabTitleText");
    var classification = $("input[name=classification]").val();
    title.text("选题组卷");
    $("div.group_title").append($("#paperTpye1").html());

}

//抽题组卷显示单项分数
function showOptionScore(sortRandom, questionType) {
    $("div.group_main .group_simple").each(function (index, element) {
        var sortDom = $(this).attr("sort");
        var questionContentHtml = "";
        if (sortDom == sortRandom) {

            $(this).find("input[name=test_tittle]").attr("sort", sortRandom);
            $(this).find("input[name=test_peer_score]").attr("sort", sortRandom);

            //多选题显示单项分数选项
            if (questionType == "2") {
                $(this).find("#selection_score").css("display", "inline-block");
                $(this).find("#selection_score span[name=vacant]").remove();
            }
        }
    });
}


//新增试题后创建显示试题内容fn
function createQuestionsViewFn(obj, parentDom, q_type, create_type) {
     var html = "";
     var num = Number(obj.tab_num);
     var per_score;
     per_score = $(parentDom).parents(".group_simple").find("input[name=test_peer_score]").val();
     //内容填充
    try {
            if (obj.OPTION1 != undefined) {
                if (obj.REFERENCEANSWER.indexOf("A")== -1 ){
                    html += '<dd class="a"><em class="icon icon-a_circle_a_outline"></em>' + obj.OPTION1 + '</dd>';
                }else{
                    html += '<dd class="a correctAnswer"><em class="icon icon-a_circle_a"></em>' + obj.OPTION1 + '</dd>';
                }
            }
      } catch (e) {
      }
      try {
            if (obj.OPTION2 != undefined) {
                if (obj.REFERENCEANSWER.indexOf("B")== -1 ){
                    html += '<dd class="b"><em class="icon icon-a_circle_b_outline"></em>' + obj.OPTION2 + '</dd>';
                }else{
                    html += '<dd class="b correctAnswer"><em class="icon icon-a_circle_b"></em>' + obj.OPTION2 + '</dd>';
                }
            }
        } catch (e) {
        }
        try {
            if (obj.OPTION3 != undefined) {
                if (obj.REFERENCEANSWER.indexOf("C")== -1 ){
                    html += '<dd class="c"><em class="icon icon-a_circle_c_outline"></em>' + obj.OPTION3 + '</dd>';
                }else{
                    html += '<dd class="c correctAnswer"><em class="icon icon-a_circle_c"></em>' + obj.OPTION3 + '</dd>';
                }
            }
        } catch (e) {
        }
        try {
            if (obj.OPTION4 != undefined) {
                if (obj.REFERENCEANSWER.indexOf("D")== -1 ){
                    html += '<dd class="d"><em class="icon icon-a_circle_d_outline"></em>' + obj.OPTION4 + '</dd>';
                }else{
                    html += '<dd class="d correctAnswer"><em class="icon icon-a_circle_d"></em>' + obj.OPTION4 + '</dd>';
                }
            }
        } catch (e) {
        }
        try {
            if (obj.OPTION5 != undefined) {
                if (obj.REFERENCEANSWER.indexOf("E")== -1 ){
                    html += '<dd class="e"><em class="icon icon-a_circle_e_outline"></em>' + obj.OPTION5 + '</dd>';
                }else{
                    html += '<dd class="e correctAnswer"><em class="icon icon-a_circle_e"></em>' + obj.OPTION5 + '</dd>';
                }
            }
        } catch (e) {
        }
        try {
            if (obj.OPTION6 != undefined) {
                if (obj.REFERENCEANSWER.indexOf("F")== -1 ){
                    html += '<dd class="f"><em class="icon icon-a_circle_f_outline"></em>' + obj.OPTION6 + '</dd>';
                }else{
                    html += '<dd class="f correctAnswer"><em class="icon icon-a_circle_f"></em>' + obj.OPTION6 + '</dd>';
                }
            }
        } catch (e) {
        }
    	var question_answer=obj.REFERENCEANSWER.replace("#"," ");
        var allHtml = '<div class="m-example questions" questionId="' + obj.ID + '"><dl>' +
            '<dt>' + obj.STEM + '</dt>' + html + '</dl>' +
            '<p class="answer">答案：' + ((question_answer == '' ||question_answer  == 'None') ? '无' : question_answer) + '</p>' +
                  '<span class="m-example-score"><input name="per_score" value="' + per_score + '">分</span>' +
             '<a href="javascript:void(0)" class="m-example-remove"  questionId="' + obj.ID + '"><i class="icons8-trash-can"></i>删除</a>' +
            '</div>';
        $(parentDom).parents(".group_simple").find(".manual-cont").append(allHtml);
        totalTestNumFn($(parentDom).parents(".group_simple").attr("sort"), 1);
        totalScoreFn();
}
//保存试题后清空表单数据
function clearFormFn(parentDom) {
    var parentDom = $(parentDom);
    parentDom.find(".q-ipt-t , .q-ipt-i").val("");
    parentDom.find("div.textareaDom").html("");
}
//联动左右大题信息 type：1左侧分数，2右侧分数，3右侧标题
function changeLeftInfoFn(obj, type, queName) {
    var sortNum = $(obj).attr("sort");
    if (type == 1) {
        $(".group_main input[name=test_peer_score]").each(function (index, element) {
            if ($(this).attr("sort") == sortNum) {
                $(this).val($(obj).val());
                $(this).parents(".group_simple").find("input[name=per_score]").val($(obj).val());
            }
        });
        totalScoreFn();
    } else if (type == 2) {
        $(".info-board input[name=test_peer_score]").each(function (index, element) {
            if ($(this).attr("sort") == sortNum) {
                $(this).val($(obj).val());
            }
        });
        totalScoreFn();
    } else if (type == 3) {
        $(".info-board h3.test_tittle").each(function (index, element) {
            if ($(this).attr("sort") == sortNum) {
                if ($(obj).val() == queName) {
                    $(this).text(queName);
                } else {
                    $(this).text($(obj).val());
                }
            }
        });
    }
}
//计算试题数量
function totalTestNumFn(sortNum, addOrDel, selNum) {
    $(".info-board .test_num").each(function (index, element) {
        if ($(this).attr("sort") == sortNum) {
            var num = Number($(this).text());
            if (addOrDel == 1) { //增加
                $(this).text(num + 1);
            } else if (addOrDel == 2) { //移除
                $(this).text(num - 1);
            } else if (addOrDel == 3) { //选题，抽题，随机模式
                $(this).text(selNum);
            }
        }
    });
}
//计算试卷总分
function totalScoreFn() {
    var totalScore = 0;
    var totalTestNum = 0;
    if ($("input[name=per_score]").length > 0) {
        $(".questions-board .group_simple").each(function (index, element) {
            var type = $(this).attr("questionType");
            if (type == "6") {
                $(this).find(".member-score").each(function (index, element) {
                    totalScore += Number($(this).val());
                });
            } else {
                $(this).find("input[name=per_score]").each(function (index, element) {
                    totalScore += Number($(this).val());
                });
            }
        });
        $(".info-board .group_simple").each(function (index, element) {
            totalTestNum += Number($(this).find(".test_num").text());
        });
    } else {
        $(".info-board .group_simple").each(function (index, element) {
            totalScore += Number($(this).find(".test_num").text()) * Number($(this).find("input[name=test_peer_score]").val());
            totalTestNum += Number($(this).find(".test_num").text());
        });
    }
    $(".info-board .total .total_score").text(totalScore);
    $(".info-board .total .test_total").text(totalTestNum);
}



//选题组卷，显示选择试题对话框
function showSelQuestions(obj) {
    selType = $(obj).parents(".group_simple").attr("questiontype");
    //不显示已选择的试题
    $(obj).parents(".group_main").find(".group_simple").each(function (index, element) {
        var commit_divs = $(this).find(".m-example");

        for (var i = 0; i < commit_divs.length; i++) {
            commit_ids = commit_ids + commit_divs[i].getAttribute("questionid") + ',';
        }
    });
    layui.use('layer', function(){
        var layer = layui.layer;
        layer.open({
     		  type: 2, 
     		  title:"选择试题",
     		  area: ['95%', '95%'],
     		  content:'gotoChoiceExamList' 
     		});
        })
    
    selTr = $(obj).parents(".group_simple");
}


//选题组卷，选择试题对话框点击确定之后执行此函数
//ids是选择试题对话框返回的试题的ids字符串
function selQuestion(ids,type) {
    var tr = selTr; //当前大题区域div
   // list = ids.split(',');
        //异步读取试题数据
        $.ajax({
            type: "POST",
            cache: false,
            headers: {"cache-control": "no-cache"},
            dataType: "json",
            url: "examController/listExerciseByIds",
            data: {ids:ids,type:type},
            async: false,
            success: function (data) {
            	if(data.code==1){
                var jsonData = data.data;
                             //后台读取选中试题信息并显示
                $.each(jsonData, function (index, value) {
                	   //创建添加试题DOM
                    createQuestionsViewFn(value, $(tr).find(".group_title"), 'select');
                });          
              }
            }
        });
}

