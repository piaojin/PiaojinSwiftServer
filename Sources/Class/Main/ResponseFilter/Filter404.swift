//
//  Filter404.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/5/6.
//
//

import PerfectHTTP
import PerfectMustache
struct Filter404: HTTPResponseFilter{
    func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        callback(.continue)
    }
    
    func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        if case .notFound = response.status {
            response.setBody(string: "page \(response.request.path) not fuond.".stringByEncodingHTML)
            response.setHeader(.contentLength, value: "\(response.bodyBytes.count)")
            callback(.done)
        } else {
            callback(.continue)
        }
    }
}
