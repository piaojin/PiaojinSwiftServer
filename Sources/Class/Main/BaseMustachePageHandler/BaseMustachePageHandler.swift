//
//  BaseMustachePageHandler.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/5/5.
//
//

import PerfectMustache
class BaseMustachePageHandler : MustachePageHandler{
    // 以下句柄函数必须在程序中实现
    // 当句柄需要将参数值传入模板时会被系统调用。
    // - 参数 context 上下文环境：类型为MustacheWebEvaluationContext，为程序内读取HTTPRequest请求内容而保存的所有信息
    // - 参数 collector 结果搜集器：类型为MustacheEvaluationOutputCollector，用于调整模板输出。比如一个`defaultEncodingFunc`默认编码函数将被安装用于改变输出结果的编码方式。
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        for (key,value) in contxt.webRequest.params(){
            values[key] = value
        }
        /// 等等等等
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}
