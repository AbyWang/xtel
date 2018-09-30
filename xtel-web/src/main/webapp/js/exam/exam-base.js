$(function () {
    // initial tooltip
    $('[data-toggle="tooltip"]').tooltip();
    // initial popover
    $('[data-toggle="popover"]').popover();

    //椤甸潰鍔犺浇瀹屾瘯
    $(function () {
        $("#spinnerLoading").addClass("hidden");
    });

    // ajaxstart with loading shown
    $( document ).ajaxStart(function() {
        $("#spinnerLoading").removeClass("hidden");
    });
    // ajaxstop with loading hidden
    $( document ).ajaxStop(function() {
        $("#spinnerLoading").addClass("hidden");
    });





    //灞曞紑鐘舵€佷笅涓嶇幇瀹炴彁绀哄崱
    if($(".sidebar-fold").hasClass("icon-unfold")){
        $('.sidebar-nav [data-toggle="tooltip"]').tooltip('destroy');
    }

    // fold sidebar
    $("#sidebar-fold").click(function(e) {
        e.stopPropagation();
        e.preventDefault();
        if($(this).hasClass("icon-unfold")){
            // fold sidebar
            $(this).removeClass("icon-unfold").addClass("icon-fold").attr("title","灞曞紑瀵艰埅").attr("data-original-title","灞曞紑瀵艰埅");
            $(this).find(".icons8").removeClass("icons8-icon").addClass("icons8-icon-3");
            $(".viewFrameWork").removeClass("sidebar-full").addClass("sidebar-min");
            document.cookie = "ksxFoldState=fold; path =; domain=;";
            $('.sidebar-inner [data-toggle="tooltip"]').tooltip();
        }else if ($(this).hasClass("icon-fold")) {
            // unfold sidebar
            $(this).removeClass("icon-fold").addClass("icon-unfold").attr("title","鏀惰捣瀵艰埅").attr("data-original-title","鏀惰捣瀵艰埅");
            $(this).find(".icons8").removeClass("icons8-icon-3").addClass("icons8-icon");
            $(".viewFrameWork").removeClass("sidebar-min").addClass("sidebar-full");
            document.cookie = "ksxFoldState=unfold; path =; domain=;";
            /*$('.sidebar-inner [data-toggle="tooltip"]').tooltip();*/
            $('.sidebar-nav [data-toggle="tooltip"]').tooltip('destroy');
        }
    });

    //涓€绾у鑸搴旀ā鍧楁樉绀烘縺娲荤姸鎬�
    $(function () {
        //褰撳墠鍦板潃
        var current_url = window.location.href;
        //瀵艰埅搴斿綋婵€娲婚」(榛樿涓洪椤�)
        var current_item = 'exam';
        //鏌ヨ鐘舵€�
        var query_status = false;
        //鎵€鏈夊甫瀵艰埅椤甸潰url缁撴瀯鍒楄〃
        var url_list = {
            "history": ["/exam/history","/exam/wrong_topic"],
            "course": ["course/show", "exam/file_mgr","course/mine","course/study/"],
            "certificate": ["certificate/certificate_mine"]
        };

        for(var o in url_list){
            var item_list = url_list[o];

            for(var i=0; i< item_list.length; i++){
                if(current_url.indexOf(item_list[i])!=-1){
                    query_status = true;
                    break;
                }
            }

            if(query_status){
                current_item = o;
                break;
            }
        }

        $(".sidebar-trans .nav-item.nav-item-"+current_item).addClass("nav-item-active");
    });

    //瀵艰埅鏍忔悳绱㈤厤缃�
    $(function () {
        //褰撳墠鍦板潃
        var current_url = window.location.href;
        var _form = $("#searchForm");
        //榛樿涓哄綋鍓嶈€冭瘯鍒楄〃椤垫悳绱紝涓嶅垪鍏ラ厤缃綋涓�
        //url:褰撳墠璺緞锛宯ame:鎼滅储name锛宻tatus:瑕佷笉瑕佹樉绀�
        var search_list = [
            {url: 'exam/history', name: 'name', method: 'get', action: '/exam/history_search',
                status: true},
            {url: 'exam/wrong_topic', status: false},
            {url: 'course/show', status: false},
            {url: 'exam/file_mgr', name: 'name', method: '', action: '', status: true},
            {url: 'certificate/certificate_mine', status: false}
        ];

        for(var i=0; i<search_list.length; i++){
            if(current_url.indexOf(search_list[i].url)!=-1){
                if(search_list[i].status){
                    $(".status-item.item-search").removeClass("hidden");
                    $(_form).attr("method", search_list[i].method).attr("action", search_list[i].action);
                    $(_form).find(".item-key-input").attr("name", search_list[i].name);
                }else{
                    $(".status-item.item-search").addClass("hidden");
                }
            }
        }

    });

    //鎼滅储
    $("#searchBtn").click(function(e){
        $("#searchForm").submit();
    });

    $("#searchForm .item-key-input").keydown(function(e){
        if(e.keyCode==13){
            $("#searchForm").submit();
        }
    });


    //瀵艰埅鏍忎釜浜轰腑蹇�
    $("#userInfoBtn").click(function (e) {
        e.stopPropagation();
        e.preventDefault();

        $("#userInfoModal").modal();
    });

    //瀵艰埅鏍忎慨鏀瑰瘑鐮�
    $("#setPasswordBtn").click(function (e) {
        e.stopPropagation();
        e.preventDefault();

        $("#setPasswordModal").modal();
    });



});

//涓嫳鏂囧垏鎹�
function switchLang(lang) {
    //en:english
    //zh-CN:Chinese
    $.ajax( {
        type:"post",
        url:"/account/set_cookie",
        dataType:"json",
        data: "cookieName=language&cookieValue=" + lang + "&expiresTime=86400",
        success:function(msg){
            window.location.href = window.location.href+"?"+Math.random();
        }
    });

}

// set cookie
function setCookie(cookieName, cookieValue, expiresTime){
    $("#spinnerLoading").addClass("hide");

    $.ajax( {
        type:"post",
        url:"/account/set_cookie",
        dataType:"json",
        data: "cookieName=" + cookieName + "&cookieValue=" + cookieValue + "&expiresTime=" + expiresTime,
        success:function(msg){
            $("#spinnerLoading").removeClass("hide");
            return msg;
        },
        error:function (msg) {
            $("#spinnerLoading").removeClass("hide");
        }
    });

}


// get cookie
function getCookie(c_name){
    if(document.cookie.length>0){
        c_start=document.cookie.indexOf(c_name + "=")
        if(c_start!=-1){
            c_start=c_start + c_name.length+1;
            c_end=document.cookie.indexOf(";",c_start);
            if (c_end==-1){
                c_end=document.cookie.length
            }
            return unescape(document.cookie.substring(c_start,c_end));
        }
    }
    return "";
}

// 鑾峰彇url涓弬鏁�
function getQueryString(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    }
    return '';
}

//澶勭悊aliyun oss url闂锛岃繘琛寀ri缂栫爜
function aliyunEncodeURI(url) {

}
// 閫€鍑虹櫥褰�(娓呯┖cookie,session&&sessionId)
$("#logoutBtn").click(function (e) {
    e.preventDefault();

    $("#logoutModal").modal();
});

//纭閫€鍑虹櫥褰�
$("#confirmLogoutBtn").click(function () {
    $.ajax({
        type: "POST",
        cache : false,
        dataType: "json",
        url: "/account/logout",
        success: function(msg){
            var jump_url = msg.bizContent.url;
            window.location.href = jump_url;

        }
    });
});
