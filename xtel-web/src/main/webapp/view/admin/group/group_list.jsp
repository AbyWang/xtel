<%@page import="com.cdxt.xtel.pojo.sys.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo user=(UserInfo)session.getAttribute("userInfo");
String groupName=user.getGroupName();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>群组管理</title>
    <script type="text/javascript">var path = "<%=path%>";</script>

    <link href="plug-in/ace/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="plug-in/font-awesome/css/font-awesome.css" rel="stylesheet" />
	<link rel="stylesheet" href="plug-in/ace/assets/css/ace.min.css" />
	<link rel="stylesheet" href="plug-in/ace/assets/css/ace-rtl.min.css" />
	<link rel="stylesheet" href="plug-in/ace/assets/css/ace-skins.min.css" />
	<link rel="stylesheet" href="plug-in/ace/assets/css/datepicker.css" />
	<link rel="stylesheet" href="plug-in/ace/assets/css/chosen.css" />
	<link rel="stylesheet" href="plug-in/layui/css/layui.css">
	<script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
	
	<script type="text/javascript" src="plug-in/layui/layui.js"></script>
	<script src="plug-in/ace/assets/js/ace-extra.min.js"></script>
	<script src="plug-in/ace/assets/js/bootstrap.min.js"></script>
	<script src="plug-in/ace/assets/js/typeahead-bs2.min.js"></script>
	<script src="plug-in/ace/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="plug-in/ace/assets/js/jquery.ui.touch-punch.min.js"></script>
	<script src="plug-in/ace/assets/js/markdown/markdown.min.js"></script>
	<script src="plug-in/ace/assets/js/markdown/bootstrap-markdown.min.js"></script>
	<script src="plug-in/ace/assets/js/jquery.hotkeys.min.js"></script>
	<script src="plug-in/ace/assets/js/bootstrap-wysiwyg.min.js"></script>
	<script src="plug-in/ace/assets/js/bootbox.min.js"></script>
	<script src="plug-in/ace/assets/js/ace-elements.min.js"></script>
	<script src="plug-in/ace/assets/js/ace.min.js"></script>
	<script src="plug-in/ace/assets/js/chosen.jquery.min.js"></script>

	<script src="plug-in/ace/assets/js/fuelux/data/fuelux.tree-sampledata.js"></script>
	<script src="plug-in/ace/assets/js/fuelux/fuelux.tree.min.js"></script>
	<script src="plug-in/ace/assets/js/ace-elements.min.js"></script>
  </head>
  <body>
	<div class="row">
		<div class="col-xs-12">
			<div class="row">
				<div class="col-sm-6" style="width:100%;">
					<div class="widget-box">
						<div class="widget-header header-color-blue2">
							<h4 class="lighter smaller">群组管理</h4>
						</div>
						<div class="widget-body">
							<div class="widget-main padding-8">
								<div id="menuTree" class="tree"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<style>
	#contextMenu{
	   display:none;
	   position: absolute;
	}
	</style>
	<ul id="contextMenu" class="ui-menu ui-widget ui-widget-content ui-corner-all"
		role="menu" tabindex="0" aria-activedescendant="ui-id-5">
		<li id='menuAdd' class="ui-menu-item" role="presentation"
			aria-disabled="true"><a href="javascript:void(0);" id="ui-id-3"
			class="ui-corner-all" tabindex="-1" role="menuitem"  onclick='addMenu();'>新增</a></li>
		<li id='menuEdit' class="ui-menu-item" role="presentation"><a href="javascript:void(0);"
			id="ui-id-4" class="ui-corner-all" tabindex="-1" role="menuitem" onclick='editMenu();'>修改</a>
		</li>
		<li id='menuDelete' class="ui-menu-item" role="presentation"><a href="javascript:void(0);"
			id="ui-id-5" class="ui-corner-all" tabindex="-1" role="menuitem" onclick='deleteMenu();'>删除</a>
		</li>
		<li id='menuAddRoot' class="ui-menu-item" role="presentation"><a href="javascript:void(0);"
			id="ui-id-6" class="ui-corner-all" tabindex="-1" role="menuitem" onclick='addRootMenu();'>新增根节点</a>
		</li>
	</ul>
	<div id="addDiv" style="display:none">
	    <form class="layui-form layui-form-pane"  style="margin:20px 20px 20px 20px">
            <div class="layui-form-item"  id="parent">
                <div class="input-group" >
                  <label class="layui-form-label ">上级群组：</label>
                  <div class="layui-input-block">
                  <input type="text" name="parentId" id="parentId"  class="layui-input hidden" >
                  <input type="text" name="parentLeaf" id="parentLeaf"  class="layui-input  hidden" >
                  <input type="text" name="parentName" id="parentName"  class="layui-input layui-disabled" disabled="disabled">
                 </div>
                </div>
            </div>
		    <div class="layui-form-item">
		        <div class="input-group" >
		          <label class="layui-form-label ">群组名称：</label>
		            <div class="layui-input-block">
		              <input type="text" name="groupId" id="groupId"  class="layui-input hidden">
				    <input type="text" name="groupName" id="groupName" required  lay-verify="required" placeholder="请输入群组名称" autocomplete="off" class="layui-input">
			      </div>
               </div>
		    </div>
		 </form>
	</div>
	<script type="text/javascript">
	    var currDom = null;
	    var currData = null;
	    var groupName="<%=groupName%>";
	    layui.use(['form','layer','laydate','table','laytpl'],function(){
	        var form = layui.form,
	            layer = parent.layer === undefined ? layui.layer : top.layer,
	            $ = layui.jquery,
	            laydate = layui.laydate,
	            laytpl = layui.laytpl,
	            table = layui.table;
	        
	    });
	    $(function(){
	        $.ajax({
				url : "<%=path%>/group/getGroupTree",
				data : {},
				type : 'post',
				async: false,
				dataType : 'json',
				success : function(data) {
				    var treeData = new DataSourceTree({
						data : data.data
					});
					var treee = $('#menuTree').ace_tree(
					{
						dataSource : treeData,
						multiSelect : true,
						loadingHTML : '<div class="tree-loading"><i class="icon-refresh icon-spin blue"></i></div>',
						'open-icon' : 'icon-minus',
						'close-icon' : 'icon-plus',
						'selectable' : false,
						'selected-icon' : 'icon-ok',
						'unselected-icon' : 'icon-remove'
					});
					document.getElementById("menuTree").oncontextmenu = function(e){
						　return false;
					};
					$(document).on("click", function (e) {
					  var contextMenu = $("#contextMenu");
					  if(e.target!=contextMenu[0]){
					     contextMenu.hide();
					  }
					});
				},
				error : function() {
				    layerUI.showMsg({content:"系统异常，请重试！"});
				}
			});
			
	    })
	    
	    //右键操作
	    function rightClick(evt, data){
	           currDom = $(evt);
               currData = data;
               console.log(currDom);
	           if(data.type=="folder"){
	        		$("#menuDelete").hide();
	           }else{
	        	   $("#menuDelete").show();
	           }
			//   var className = $(currDom).attr("class");
			   var x = 0;
			   var y = 0;
			   x = currDom.offset().left;
			   y = currDom.offset().top
			   $("#contextMenu").css({
				  top:y+10,
				  left:x+event.clientX-20
			   });
			   $("#contextMenu").show();
	    }
	    //添加菜单
	    function addMenu(){
	     var content = $("#addDiv").html();
	     layer.open({
				type:1,
				title:"群组添加",
			    skin: 'layui-layer-molv',
				area: ['350px', '250px'],
				content:content,
				btn: ['添加', '取消'],
			    yes:function(layero, index){
		            var parentId = $("#parentId").val(); 
                    var groupName = $("#groupName").val(); 
                    var parentLeaf = $("#parentLeaf").val(); 
                    if(groupName.trim().length==0){
                    	 layer.msg("请输入群组名称", {icon: 2})
                    	 return;
                    }
			    	var params={
			    	   parentId:parentId,
			    	   groupName:groupName,
			    	   parentLeaf:parentLeaf
			    	}
	                doSave(params);
			    },
			    //这里必须清空  否则页面ID重复   会发生意想不到的问题
			    success:function(){
			        $("#addDiv").empty();
	                $("#parentId").val(currData.id);
			        $("#parentName").val(currData.name);
	                if(currData.type==="folder"){
	                	$("#parentLeaf").val(0);
	                }else{
	            	  $("#parentLeaf").val(1);
	               }
			    },
			    //这里重新将影藏div中的内容回写，否则再次打开弹出框时将没有内容
			    end:function(){
			       $("#addDiv").html(content);
			    }
			});
	    }
	    //添加根节点菜单
	    function addRootMenu(){
	      var content = $("#addDiv").html();
	      layer.open({
              type:1,
              title:"群组添加",
              skin: 'layui-layer-molv',
              area: ['350px', '250px'],
              content:content,
              btn: ['添加', '取消'],
              yes:function(layero, index){
                  var parentId = $("#parentId").val(); 
                  var groupName = $("#groupName").val(); 
                  var parentLeaf = $("#parentLeaf").val(); 
                  var params={
                     parentId:parentId,
                     groupName:groupName,
                     parentLeaf:parentLeaf
                  }
                  doSave(params);
              },

			    //这里必须清空  否则页面ID重复   会发生意想不到的问题
               success:function(){
                  $("#addDiv").empty();
                  $("#parentName").val(groupName);
                  $("#parentLeaf").val(0);
                },
			    //这里重新将影藏div中的内容回写，否则再次打开弹出框时将没有内容
			    end:function(){
			       $("#addDiv").html(content);
			    }
			});
	    }
	    
	    //修改 菜单
	    function editMenu(){
	    	$("#parent").hide();
	          var content = $("#addDiv").html();
	          layer.open({
	              type:1,
	              title:"群组修改",
	              skin: 'layui-layer-molv',
	              area: ['350px', '180px'],
	              content:content,
	              btn: ['添加', '取消'],
	              yes:function(layero, index){
	                  var groupId = $("#groupId").val(); 
	                  var groupName = $("#groupName").val(); 
	                  var parentLeaf = $("#parentLeaf").val(); 
	                  var params={
	                     groupId:groupId,
	                     groupName:groupName,
	                     parentLeaf:parentLeaf
	                  }
	                 if(groupName.trim().length==0){
	                      layer.msg("请输入群组名称", {icon: 2})
	                       return;
	                  }
	                  doUpdate(params);
	              },
	                //这里必须清空  否则页面ID重复   会发生意想不到的问题
	               success:function(){
	                  $("#addDiv").empty();
	                  $("#groupName").val(currData.name);
	                  $("#groupId").val(currData.id);
	                  if(currData.type==="folder"){
	                      $("#parentLeaf").val(0);
	                    }else{
	                      $("#parentLeaf").val(1);
	                   }
	                },
	                //这里重新将影藏div中的内容回写，否则再次打开弹出框时将没有内容
	                end:function(){
	                   $("#addDiv").html(content);
	                   $("#parent").show();
	                }
	            });
	    }
	    
	    //删除菜单
	    function deleteMenu(){
	    	layer.confirm('你确定要删除这条数据吗？', {icon: 3, skin: 'layui-layer-molv', title:'提示'},
	    		 function(index){
				   $.ajax({
						url : "<%=path%>/group/deleteGroup",
						data : {id:currData.id,parentId:currData.parentId},
						type : 'post',
						async: false,
						dataType : 'json',
						success : function(data) {
							showMsg(data);
							if(data.code==1){
		                     refreshNode(); 
			            	}			
						},
						error : function() {
							 layer.msg("系统异常", {icon: 2})
						}
					})
				    layer.close(index);
				})
			}

	    
	      //假定你的信息提示方法为showmsg， 在方法里可以接收参数msg，当然也可以接收到o及cssctl;
	       var showMsg=function(data){
	           layer.msg(data.message, {
	               icon: data.code
	             })
	       };
	       
	        //修改
	       function doUpdate(params){
	            $.ajax({
	                url : "<%=path%>/group/updateGroup",
	                data : params,
	                type : 'post',
	                async: false,
	                dataType : 'json',
	                success : function(data) {
	                    layer.close(layer.index); 
	                    showMsg(data);
	                    if(data.code==1){
	                    	if($("#parentLeaf").val()==0){
	                    		location.reload();
	                    	}else{
	                    	   refreshNode();
	                    	}  
	                    }
	                },
	                error : function() {
	                     layer.msg("系统异常", {icon: 2})
	                }
	            });
	         }
	    
	    //保存
	     function doSave(params){
	        var success = false;
	        $.ajax({
				url : "<%=path%>/group/addGroup",
				data : params,
				type : 'post',
				async: false,
				dataType : 'json',
				success : function(data) {
					layer.close(layer.index); 
	                showMsg(data);
					if(data.code==1){
					   if($("#parentLeaf").val()==0){
					     refreshNode();
					   }else{
						   location.reload();
					   }
	            	}
				},
				error : function() {
		             layer.msg("系统异常", {icon: 2})
				}
			});
			return success;
	     }
	    //节点刷新当前节点
	    function refreshNode(){
	       var rootFolder = getRootFolder(currDom);
	       if(rootFolder==null) return;
	       var iClassName = rootFolder.find("i").attr("class");
	       //如果当前节点没有展开则不进行刷新
	       if(iClassName=="icon-plus") return;
	       //这里点击两次模拟刷新节点
	       rootFolder.find(".tree-folder-header").trigger("click");
	       rootFolder.find(".tree-folder-header").trigger("click");
	    }
	    //刷新根节点
	    function refreshRootNode(){
	      $(".layui-tab-content").load("<%=path%>/view/group/group_list.jsp");
	    }
	    //获取当前点击的根节点
	    function getRootFolder(currDom){
	        var className = currDom.attr("class");
	        console.log(currDom.parent());
	        if(className=="tree-folder"){
	         return currDom;
	        }
	       return getRootFolder(currDom.parent());
	    }
	</script>
</body>
</html>
