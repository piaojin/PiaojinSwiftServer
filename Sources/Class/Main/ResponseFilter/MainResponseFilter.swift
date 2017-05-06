//
//  MainResponseFilter.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/5/6.
//
//

import PerfectHTTP
struct MainResponseFilter: HTTPResponseFilter{
    /// 在响应消息头发给客户端浏览器之前调用一次。
    func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()){
        debugPrint("MainResponseFilter_filterHeaders")
        callback(.continue)
    }
    /// 可以不调用，也可以被调用多次，来修改发回给客户端浏览器的消息体内容。
    func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()){
        debugPrint("MainResponseFilter_filterBody")
        callback(.continue)
    }
}
