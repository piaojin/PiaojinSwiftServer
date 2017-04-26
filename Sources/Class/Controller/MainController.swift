//
//  MainController.swift
//  PiaojinSwiftService
//
//  Created by 飘金 on 2017/4/26.
//
//

import Foundation
import PerfectHTTP
/// 用于接受请求并根据请求创建响应内容的句柄函数格式。
public typealias RequestHandler = (HTTPRequest, HTTPResponse) -> ()
//创建一个类,类似springMVC中的控制器
public class MainController : NSObject{
    let requestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        response.setBody(string: "路由句柄已经收到,hello piaojin!")
        response.completed()
    }
    
    //路由,用于处理一个请求
    public var testRoute : Routes = Routes()
    
    public override init() {
        testRoute.add(method: .get, uri: "/testRoutes", handler:requestHandler)
        super.init()
    }
}
