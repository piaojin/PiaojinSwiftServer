//
//  WelcomePageHanler.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/5/5.
//
//

import PerfectMustache
class WelcomePageHanler: BaseMustachePageHandler {
    //转换Mustache页面模板
     override func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector){
        super.extendValuesForResponse(context: contxt, collector: collector)
    }
}
