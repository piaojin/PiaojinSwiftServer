//
//  UserController.swift
//  PiaojinSwiftServer
//
//  Created by piaojin on 2017/4/26.
//
//

import PerfectHTTP
//专门用于处理用户的crud操作
class UserController : BaseController{
    //用户服务对象,用于用户的crud操作
    lazy var userService : UserService = {
        return UserServiceImpl()
    }()
    
    //添加一个用户
    let saveUserRequestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        
        var userModel : UserModel = UserModel()
        if userModel.transformParams(params: request.params()){
            do{
                try userModel.save()
                debugPrint("保存用户成功!")
                response.appendBody(string:"保存用户成功!")
            }catch{
                debugPrint("添加用户失败:\(error)")
                response.appendBody(string:"添加用户失败:\(error)")
            }
        }else{
            debugPrint("解析request参数失败!")
        }
        
        response.completed()
    }
    
    override init() {
        super.init()
        self.route.add(method: .get, uri: "/saveUser", handler: self.saveUserRequestHandler)
    }
}
