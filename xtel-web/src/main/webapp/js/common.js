/**
 * 初始化 BootStrap Table 的封装
 *
 * 约定：toolbar的id为 (bstableId + "Toolbar")
 *
 * @author fengshuonan
 */
(function () {
    var BSTable = function (bstableId, url, columns) {
        this.btInstance = null;                 //jquery和BootStrapTable绑定的对象
        this.bstableId = bstableId;
        this.url = url;
        this.method = "get";
        this.paginationType = "server";         //默认分页方式是服务器分页,可选项"client"
 //       this.toolbarId = bstableId + "Toolbar";
        this.columns = columns;
        this.height = 665;                      //默认表格高度665
        this.data = {};
        this.queryParams = {}; // 向后台传递的自定义参数
        
    };


    BSTable.prototype = {
        /**
         * 初始化bootstrap table
         */
        init: function () {
            var tableId = this.bstableId;
            this.btInstance =
                $('#' + tableId).bootstrapTable({
                    contentType: "application/x-www-form-urlencoded",
                    url: this.url,              //请求地址
                    method: this.method,        //ajax方式,post还是get
                    ajaxOptions: {              //ajax请求的附带参数
                        data: this.data
                    },
    	            toolbar: '#toolbar',       
                    sidePagination: this.paginationType,   //分页方式：client客户端分页，server服务端分页（*）
                    columns: this.columns,      //列数组
                    striped: true,                      //是否显示行间隔色
    	            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
    	            pagination: true,                   //是否显示分页（*）
    	            sortable: true,                     //是否启用排序
    	            sortOrder: "asc",                   //排序方式
    	            queryParams: BSTable.queryParams,//传递参数（*）
    	            pageNumber:1,                       //初始化加载第一页，默认第一页
    	            pageSize: 10,                       //每页的记录行数（*）
    	            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
    	            strictSearch: true,
    	            showColumns: true,                  //是否显示所有的列
    	            showRefresh: true,                  //是否显示刷新按钮
    	            minimumCountColumns: 2,             //最少允许的列数
    	            clickToSelect: true,                //是否启用点击选中行
    	            height : $(window).height()-35,   //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
    	            uniqueId: "id",                   //每一行的唯一标识，一般为主键列
    	            showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
    	            cardView: false,                    //是否显示详细视图
    	            detailView: false,                   //是否显示父子表
    	  	        showExport: true,                    //显示到处按钮
                    smartDisplay:false,//
                });
            return this;
        },
        /**
         * 向后台传递的自定义参数
         * @param param
         */
        setQueryParams: function (param) {
            this.queryParams = param;

        },
        /**
         * 设置分页方式：server 或者 client
         */
        setPaginationType: function (type) {
            this.paginationType = type;
        },

        /**
         * 设置ajax post请求时候附带的参数
         */
        set: function (key, value) {
            if (typeof key == "object") {
                for (var i in key) {
                    if (typeof i == "function")
                        continue;
                    this.data[i] = key[i];
                }
            } else {
                this.data[key] = (typeof value == "undefined") ? $("#" + key).val() : value;
            }
            return this;
        },

        /**
         * 设置ajax post请求时候附带的参数
         */
        setData: function (data) {
            this.data = data;
            return this;
        },

        /**
         * 清空ajax post请求参数
         */
        clear: function () {
            this.data = {};
            return this;
        },

        /**
         * 刷新 bootstrap 表格
         * Refresh the remote server data,
         * you can set {silent: true} to refresh the data silently,
         * and set {url: newUrl} to change the url.
         * To supply query params specific to this request, set {query: {foo: 'bar'}}
         */
        refresh: function (parms) {
            if (typeof parms != "undefined") {
                this.btInstance.bootstrapTable('refresh', parms);
            } else {
                this.btInstance.bootstrapTable('refresh');
            }
        }
    };

    
    //得到查询的参数
    BSTable.queryParams = function (params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
           limit: params.limit,   //页面大小
           offset: params.offset,  //页码
           pageSize:this.pageSize,
           pageNo:this.pageNumber,
        };
        var params = $("#searchForm").serializeArray();  
        for( x in params ){  
            temp[params[x].name] = params[x].value;  
        } 
      return temp;
    };
    window.BSTable = BSTable;

}());