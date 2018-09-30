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
            var questionInfoList=[];
            var dataJson = {};

            $(".operation-check .question-score").each(function (index, element) {
                var _this = $(this);
                var _parent = $(_this).parents(".question-content");
                var _checkDom = $(_this).parents(".operation-check").find(".icon-checked");
                var questionId = $(_parent).attr("data-id");
                var score = $(_this).val();
                var mix = $(_parent).hasClass("question-insert") ? 1 : 0;
                var combId = $(_parent).hasClass("question-insert") ? $(_parent).attr("data-comb-id") : '';
                var error = '';

                if(_checkDom.length>0){
                    if($(_checkDom).hasClass("icon-right")){
                        error = 'right';
                    }else {
                        error = 'error';
                    }
                }

                questionInfoList[index]= {
                    "id":questionId,
                    "score": score,
                    "isOk": error,
                    "mix": mix,
                    "combId": combId
                }
            });

            dataJson = {
                "examInfoId": exam_info_id,
                "examResultsId": exam_results_id,
                "userName": checkUserName,
                "questionInfoList": JSON.stringify(questionInfoList)
            };

            $.ajax({
                type: "POST",
                cache : false,
                headers: { "cache-control": "no-cache" },
                dataType: "json",
                url: "/exam/manmade_exam_ending",
                data: dataJson,
                success: function(msg){
                    if(msg.success){
                        //判断是否生成证书
                        if(msg.bizContent.isGrantCertificate){
                            certificateType(msg.bizContent.pollType);
                        }else{
                            alert("保存成功");
                        }
                    }else{
                        alert("操作失败，请联系管理员！");
                    }
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
                alert("分数需为非负数，否则作0分处�?");
                return false;
            }
        });
        return status;
    }

    //判断出什么类型的证书
    function certificateType(pollType){
        var tipTitle = '';
        var btnTitle = '';

        switch (pollType){
            case 'add':
                tipTitle = '分数已保存，考生分数已符合证书发放规则，是否要发放证书？';
                btnTitle = '发放';
                break;
            case 'del':
                tipTitle = '分数已保存，考生分数不符合证书发放规则，是否要收回证�?? ';
                btnTitle = '收回';
                break;
            case 'update':
                tipTitle = '分数已保存，需要更新考生证书，是否立即更新？';
                btnTitle = '更新';
                break;
            default:
                window.location.reload();
                return true;
        }

        $("#certificateModal .modal-body .modal-title").html(tipTitle);
        $("#certificateBtn").text(btnTitle).attr("data-type", pollType);
        $("#certificateModal").modal();
    }

    //证书点击发放／收回／更新�?
    $("#certificateBtn").click(function(){
        var pollType = $(this).attr("data-type");

        $.ajax({
            type: "POST",
            cache : false,
            headers: { "cache-control": "no-cache" },
            dataType: "json",
            url: "/exam/exam_grant_certificate",
            data: {
                "examInfoId":exam_info_id,
                "examResultsId":exam_results_id,
                "pollType": pollType
            },
            success: function(msg){
                $("#certificateModal").modal('hide');
            }
        });
    });


    //*******************************手动判分**********************************
});