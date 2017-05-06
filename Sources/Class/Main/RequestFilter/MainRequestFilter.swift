//
//  MainRequestFilter.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/5/6.
//
//

import PerfectHTTP
struct MainRequestFilter: HTTPRequestFilter{
    /// 在请求完全被服务器接收到后，在转向任何处理器前执行过滤程序。
    func filter(request: HTTPRequest, response: HTTPResponse, callback: (HTTPRequestFilterResult) -> ()){
        debugPrint("进入MainRequestFilter过滤器:\(request.path)")
        callback(.continue(request, response))
    }
}
