//
//  BaseController.swift
//  PiaojinSwiftService
//
//  Created by piaojin on 2017/4/26.
//
//

import PerfectHTTP
/// 用于接受请求并根据请求创建响应内容的句柄函数格式。
public typealias RequestHandler = (HTTPRequest, HTTPResponse) -> ()
//创建一个类,类似springMVC中的控制器
class BaseController {
    
    let mainRequestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        // 获得符合通配符的请求路径
        request.path = ResourceConst.index
        debugPrint(request.path)
        // 用文档根目录初始化静态文件句柄
        let handler = StaticFileHandler(documentRoot: ResourceConst.webRoot)
        // 用我们的根目录和路径
        // 修改集触发请求的句柄
        handler.handleRequest(request: request, response: response)
    }
    
    //用于全局跳转到指定的页面
    let redirectRequestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        
        request.path = "Pages/" + request.path
        debugPrint(request.path)
        // 用文档根目录初始化静态文件句柄
        let handler = StaticFileHandler(documentRoot: ResourceConst.webRoot)
        // 用我们的根目录和路径
        // 修改集触发请求的句柄
        handler.handleRequest(request: request, response: response)
    }
    
    //路由,用于处理一个请求
    public lazy var route : Routes = {
        var tempRoute : Routes = Routes()
        //add方法相当于添加一个拦截特定请求的方法
        tempRoute.add(method: .get, uri: "/", handler:self.mainRequestHandler)
        tempRoute.add(method: .get, uri: "/index.html", handler:self.mainRequestHandler)
        tempRoute.add(method: .get, uri: "/*", handler:self.redirectRequestHandler)
        return tempRoute
    }()
    
    init() {
        
    }
}
