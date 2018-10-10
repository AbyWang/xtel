$(function () {


    //显示答题卡?
    $("#numberCardBtn").click(function (e) {
        e.stopPropagation();
        e.preventDefault();

        $("#numberCardModal").modal();
    });

    //点击答题卡跳转至对应�?,使用了锚点跳�?
    //位置调整90（因为有顶栏），并关闭答题卡
    $("#numberCardModal .modal-body .box").click(function (e) {

        $("#numberCardModal").modal('hide');
        setTimeout(function () {
            var scrollTop = $("html").scrollTop();

            $("html").animate({scrollTop:scrollTop-90},200);
        },100);

    });


    //固定组合�?
    $("body").on("click", ".operation-icon.icon-pushpin", function () {
        $(".stuckMenu.isStuck").removeClass("isStuck").removeClass("stuckMenu").attr("style","");
        $(this).removeClass("icon-pushpin").addClass("icon-pushpined")
            .attr("title","解锁题干").attr("data-original-title","解锁题干");
        $(this).find(".icon").removeClass("icon-p_exam_fix_de").addClass("icon-p_exam_fix_se");
        $(this).parents(".question-comb").stickUp();
    });

    //取消固定
    $("body").on("click", ".operation-icon.icon-pushpined", function () {
        $(".stuckMenu.isStuck").removeClass("isStuck").removeClass("stuckMenu").attr("style","");
        $(this).removeClass("icon-pushpined").addClass("icon-pushpin")
            .attr("title","固定题干").attr("data-original-title","固定题干");
        $(this).find(".icon").removeClass("icon-p_exam_fix_se").addClass("icon-p_exam_fix_de");
        $(".question-insert-list").css("margin-top",0);
    });

    
    //*******************************手动判分**********************************
    //更改正确错误状�?
    $(".operation-check .icon").click(function (e) {
        e.preventDefault();
        var _this = $(this);

        if(!$(_this).hasClass("icon-checked")){
            $(_this).parent(".operation-check").find(".icon-checked").removeClass("icon-checked");
            $(_this).addClass("icon-checked");
        }
    });

//    //自动算分
//    $("body").on("input change", ".operation-check .question-score", function () {
//        var _this = $(this);
//        var reg = /^\d+(\.\d+)?$/;
//
//        var examScore = parseFloat($("#examScore").text());
//        console.log(examScore);
//        var initialScore = parseFloat($(_this).attr("data-score"));
//        var nowScore = reg.test($(_this).val()) ? parseFloat($(_this).val()) : 0;
//
//        examScore = examScore - initialScore + nowScore;
//        $("#examScore").text(examScore);
//        $(_this).attr("data-score", nowScore);
//    });

    //保存
    $("#saveCheckResultsBtn").click(function () {
        if(checkResultsForm()){
            var dataJson = {};
        	var examId = '<%=request.getAttribute("examId")%>' ;
        	var paperId = '<%=request.getAttribute("paperId")%>' ;
            dataJson = {
                "performance": $("#examScore").text(),
                "examId": examId,
                "paperId":paperId
            };
            $.ajax({
                type: "POST",
                cache : false,
                headers: { "cache-control": "no-cache" },
                dataType: "json",
                url:path+ "/examController/saveUserPerformance",
                data: dataJson,
                success: function(msg){
                 layui.use('layer',function(){
            	   layer=layui.layer;
                	layer.msg(data.message, {
                        icon: data.code,
                        time: 2000 //2秒关闭（如果不配置，默认是3秒）
                        }, function(){
                             if(data.code=="1"){
                            	 window.location.href="<%=path%>/gotoExamPlanList";
                             }
                       });   
                })
                }               
            });

        }
    });

    //检查输入合�?
    function checkResultsForm() {
        var reg = /^\d+(\.\d+)?$/;
        var status = true;

        $(".operation-check .question-score").each(function (index, element) {
            if(!reg.test($(this).val())){
                status = false;
                alert("分数需为非负数，否则作0分处理?");
                return false;
            }
        });
        return status;
    }


   

    //*******************************手动判分**********************************
});