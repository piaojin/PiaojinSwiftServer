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
    
    let testRequestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        response.setBody(string: "路由句柄已经收到,hello piaojin!")
        response.completed()
    }
    
    //路由,用于处理一个请求
    public lazy var route : Routes = {
        var tempRoute : Routes = Routes()
        //add方法相当于添加一个拦截特定请求的方法
        tempRoute.add(method: .get, uri: "/testRoutes", handler:self.testRequestHandler)
        return tempRoute
    }()
    
    init() {
        
    }
}
