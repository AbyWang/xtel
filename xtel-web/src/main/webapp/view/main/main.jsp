<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo user=(UserInfo)session.getAttribute("userInfo");
String userName=user.getUserName();
Integer userType=user.getUserType();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>远程教育管理平台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="favicon.ico">
    <link rel="stylesheet" href="plug-in/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="view/main/css/index.css" media="all" />
</head>
<body class="main_body">
    <div class="layui-layout layui-layout-admin">
        <!-- 顶部 -->
        <div class="layui-header header">
            <div class="layui-main mag0">
                <a href="#" class="logo">远程教学平台</a>
                <!-- 显示/隐藏菜单 -->
                <a href="javascript:;" class="seraph hideMenu icon-caidan"></a>
                <!-- 天气信息 -->
               <ul class="layui-nav mobileTopLevelMenus" mobile>
                    <li class="layui-nav-item" data-menu="contentManagement">
                        <a href="javascript:;"><i class="seraph icon-caidan"></i></a>
                        <dl class="layui-nav-child">
                            <dd class="layui-this" data-menu="userCenter"><a href="javascript:;"><i class="layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>用户中心</cite></a></dd>
                             <dd class="layui-this" data-menu="teachCenter"><a href="javascript:;"><i class="seraph layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>教师中心</cite></a></dd>
                            <dd  class="layui-this"  data-menu="adminCenter"><a href="javascript:;"><i class="seraph icon-icon10" data-icon="icon-icon10"></i><cite>管理中心</cite></a></dd>
                        </dl>
                    </li>
                </ul>
                 <ul class="layui-nav topLevelMenus" pc>
                    <li class="layui-nav-item layui-this" data-menu="userCenter">
                        <a href="javascript:;"><i class="layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>学员中心</cite></a>
                    </li>
                     <li class="layui-nav-item" data-menu="teachCenter" pc>
                        <a href="javascript:;"><i class="seraph layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>教师中心</cite></a>
                    </li>
                    <li class="layui-nav-item " data-menu="adminCenter" pc  id="adminCenter">
                        <a href="javascript:;"><i class="seraph icon-icon10" data-icon="icon-icon10"></i><cite>管理中心</cite></a>
                    </li>
                </ul>
                <div class="weather" >
                    <div id="tp-weather-widget"></div>
                    <script>(function(T,h,i,n,k,P,a,g,e){g=function(){P=h.createElement(i);a=h.getElementsByTagName(i)[0];P.src=k;P.charset="utf-8";P.async=1;a.parentNode.insertBefore(P,a)};T["ThinkPageWeatherWidgetObject"]=n;T[n]||(T[n]=function(){(T[n].q=T[n].q||[]).push(arguments)});T[n].l=+new Date();if(T.attachEvent){T.attachEvent("onload",g)}else{T.addEventListener("load",g,false)}}(window,document,"script","tpwidget","//widget.seniverse.com/widget/chameleon.js"))</script>
                    <script>tpwidget("init", {
                        "flavor": "slim",
                        "location": "WX4FBXXFKE4F",
                        "geolocation": "enabled",
                        "language": "zh-chs",
                        "unit": "c",
                        "theme": "chameleon",
                        "container": "tp-weather-widget",
                        "bubble": "disabled",
                        "alarmType": "badge",
                        "color": "#FFFFFF",
                        "uid": "U9EC08A15F",
                        "hash": "039da28f5581f4bcb5c799fb4cdfb673"
                    });
                    tpwidget("show");</script>
                </div>
                <!-- 顶部右侧菜单 -->
                <ul class="layui-nav top_menu">

                    <li class="layui-nav-item" pc>
                        <a href="javascript:;" class="clearCache"><i class="layui-icon" data-icon="&#xe640;">&#xe640;</i><cite>清除缓存</cite><span class="layui-badge-dot"></span></a>
                    </li>
                   <!--   <li class="layui-nav-item lockcms" pc>
                        <a href="javascript:;"><i class="seraph icon-lock"></i><cite>锁屏</cite></a>
                    </li>-->
                    <li class="layui-nav-item" id="userInfo">
                     <a href="javascript:;"><img src="images/face.jpg" class="layui-nav-img userAvatar" width="35" height="35"><cite class="adminName"><%=userName%></cite></a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:void;" ><i class="seraph icon-ziliao" data-icon="icon-ziliao"></i><cite>个人资料</cite></a></dd>
                            <dd><a href="javascript:;" data-url="gotoChangePwd"><i class="seraph icon-xiugai" data-icon="icon-xiugai"></i><cite>修改密码</cite></a></dd>
                              <dd pc><a href="javascript:;" class="changeSkin"><i class="layui-icon">&#xe61b;</i><cite>更换皮肤</cite></a></dd>
                            <dd><a href="javascript:logout();" class="signOut"><i class="seraph icon-tuichu"></i><cite>退出</cite></a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 左侧导航 -->
        <div class="layui-side layui-bg-black">
            <div class="user-photo">
                <a class="img" title="我的头像" ><img src="images/face.jpg"></a>
                <p>你好！<span class="userName"><%=userName%></span>, 欢迎登录</p>
            </div>
            <div class="navBar layui-side-scroll" id="navBar">
                <ul class="layui-nav layui-nav-tree">
                    <li class="layui-nav-item layui-this">
                        <a href="javascript:;" data-url="page/main.html"><i class="layui-icon" data-icon=""></i><cite>后台首页</cite></a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 右侧内容 -->
        <div class="layui-body layui-form">
            <div class="layui-tab mag0" lay-filter="bodyTab" id="top_tabs_box">
                <ul class="layui-tab-title top_tab" id="top_tabs">
                    <li class="layui-this" lay-id=""><i class="layui-icon">&#xe68e;</i> <cite>后台首页</cite></li>
                </ul>
                <ul class="layui-nav closeBox">
                  <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon caozuo">&#xe643;</i> 页面操作</a>
                    <dl class="layui-nav-child">
                      <dd><a href="javascript:;" class="refresh refreshThis"><i class="layui-icon">&#x1002;</i> 刷新当前</a></dd>
                      <dd><a href="javascript:;" class="closePageOther"><i class="seraph icon-prohibit"></i> 关闭其他</a></dd>
                      <dd><a href="javascript:;" class="closePageAll"><i class="seraph icon-guanbi"></i> 关闭全部</a></dd>
                    </dl>
                  </li>
                </ul>
                <div class="layui-tab-content clildFrame">
                    <div class="layui-tab-item layui-show">
                        <iframe src="view/main/main_index2.jsp"></iframe>
                    </div>
                </div>
            </div>
        </div>
        <!-- 底部
        <div class="layui-footer footer">
            <p><span>copyright @2018 信通网易</span></p>
        </div> -->
    </div>

    <!-- 移动导航 -->
    <div class="site-tree-mobile"><i class="layui-icon">&#xe602;</i></div>
    <div class="site-mobile-shade"></div>
    <script src="plug-in/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="plug-in/layui/layui.js"></script>
    <script type="text/javascript" src="view/main/js/main.js"></script>
 <!-- <script type="text/javascript" src="view/main/js/leftNav.js"></script>   -->   
    <script type="text/javascript" src="view/main/js/cache.js"></script>
   <script>
   var userType="<%=userType%>";
   if(userType==2){
	   $("#adminCenter").addClass("layui-hide"); 
   }
   </script>
</body>
</html>
