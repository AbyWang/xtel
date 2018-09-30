/**
 *采用正则表达式获取地址栏参数
 */
 function getQueryString(name){
      var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
      var r = window.location.search.substr(1).match(reg);
      if(r!=null) {
     	 return  decodeURI(r[2]); 
      }else {
     	 return null;
      }
 }
 
 
//添加url参数
 function setParam(url,paramKey,paramVal){
     var andStr = "?";
     var beforeparam = url.indexOf("?");
     if(beforeparam != -1){
         andStr = "&";
     }
     return url + andStr + paramKey + "="+ encodeURIComponent(paramVal);
 }


 Date.prototype.format = function(fmt) { 
     var o = { 
        "M+" : this.getMonth()+1,                 //月份 
        "d+" : this.getDate(),                    //日 
        "h+" : this.getHours(),                   //小时 
        "m+" : this.getMinutes(),                 //分 
        "s+" : this.getSeconds(),                 //秒 
        "q+" : Math.floor((this.getMonth()+3)/3), //季度 
        "S"  : this.getMilliseconds()             //毫秒 
    }; 
    if(/(y+)/.test(fmt)) {
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
    }
     for(var k in o) {
        if(new RegExp("("+ k +")").test(fmt)){
             fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
         }
     }
    return fmt; 
}
 
 
 /**
  * 
  * @param param
  * @returns {Boolean}
  */
 function isOrNotEmpty(param){
 	if(param==""||param==null||param=="undefined"||param==undefined||param=="null"){
 		return false;
 	}else{
 		return true;
 	}
 }