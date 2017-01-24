////用于创建NA服务
//function jbService(service, action, params) {
//    this.service = service;
//    this.action = action;
//    if (params) {
//        this.params = params;
//    }
//}
//
//判断当前的机器类型：安卓和ios
var u = navigator.userAgent;
var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端

function setupWebViewJavascriptBridge(callback) {

    if (isiOS) {

        if (window.WebViewJavascriptBridge) {
            return callback(WebViewJavascriptBridge);
        }
        if (window.WVJBCallbacks) {
            return window.WVJBCallbacks.push(callback);
        }
        window.WVJBCallbacks = [callback];
        var WVJBIframe = document.createElement('iframe');
        WVJBIframe.style.display = 'none';
        WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
        document.documentElement.appendChild(WVJBIframe);
        setTimeout(function () {
            document.documentElement.removeChild(WVJBIframe)
         }, 0)
     }
     if (isAndroid) {
         if (window.WebViewJavascriptBridge) {
  
           callback(WebViewJavascriptBridge)
         } else {
            document.addEventListener(
                        'WebViewJavascriptBridgeReady'
                        , function () {
                        callback(WebViewJavascriptBridge)
                        },
                        false
                        );
         }
     }
}

setupWebViewJavascriptBridge(function (bridge) {
                           
    if (isAndroid) {
        //Android
        bridge.init(function (message, responseCallback) {});
    }
                           
})

//Methods
//网络服务
function network(){
                      
    var obj = {
        service:'JKJS.http',
        action:'post',
        params:{
            api:'http://gc.ditu.aliyun.com/geocoding',
            params:{a:'北京'}
        }
    }
  window.WebViewJavascriptBridge.callHandler('requestService', obj, function (response) {
                                             
    //iOS回调response为Object类型  Android回调response为Json字符串类型
     var type = typeof response
                                             
     if (type == "string") {
        //Android
        response = JSON.parse(response);
        alert(response)
     } else if (type == "object") {
        //iOS
        alert(JSON.stringify(response))
     }
  })
}
                      
//缓存服务
function setCache(){

    var obj = {
        service:'JKJS.cache',
        action:'set',
        params:{
          key:'testCache',
          params:{a:'北京'}
        }
     }
    window.WebViewJavascriptBridge.callHandler('requestService', obj, function (response) {
                                               
        var type = typeof response
                                             
        if (type == "string") {
         //Android
         response = JSON.parse(response);
         alert(response)
        } else if (type == "object") {
         //iOS
         alert(JSON.stringify(response))
        }
    })

}
                      
function getCache(){
    var obj = {
        service:'JKJS.cache',
        action:'get',
        params:{key:'testCache'}
    }
   window.WebViewJavascriptBridge.callHandler('requestService', obj, function (response) {
                                         
         var type = typeof response
         
         if (type == "string") {
         //Android
         response = JSON.parse(response);
         alert(response)
         } else if (type == "object") {
         //iOS
         alert(JSON.stringify(response))
         }
    })
}
                      
