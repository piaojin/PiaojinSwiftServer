//
//  LoginController.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/5/5.
//
//

import PerfectHTTP
import PerfectMustache

class LoginController: BaseController {

    //登录页面
    let loginRequestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        
        debugPrint("loginRequestHandler")
        // 获得符合通配符的请求路径
        request.path = ResourceConst.login
        // 用文档根目录初始化静态文件句柄
        let handler = StaticFileHandler(documentRoot: ResourceConst.webRoot)
        // 用我们的根目录和路径
        // 修改集触发请求的句柄
        handler.handleRequest(request: request, response: response)
    }
    
    //登录验证
    let loginCheckRequestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        
        debugPrint("loginCheckRequestHandler")
        
        var userModel : UserModel = UserModel()
        if userModel.transformParams(params: request.params()){
            if userModel.name == "piaojin" && userModel.pwd == "123"{
                //登录成功重定向到欢迎页面
                mustacheRequest(request: request, response: response, handler: WelcomePageHanler(), templatePath: ResourceConst.webRoot
                     + ResourceConst.welcome)
            }else{
                response.appendBody(string:"登录失败!")
            }
        }else{
            print("解析request参数失败!")
        }
    }
    
    override init() {
        super.init()
        //跳转登录页面
        self.route.add(method: .get, uri: "/login", handler: self.loginRequestHandler)
        //登录验证
        self.route.add(method: .post, uri: "/loginCheck", handler: self.loginCheckRequestHandler)
    }
    
}
