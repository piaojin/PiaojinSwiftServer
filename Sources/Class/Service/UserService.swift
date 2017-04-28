//
//  UserService.swift
//  PiaojinSwiftServer
//
//  Created by piaojin on 2017/4/27.
//
//

import Foundation

//这边模仿spring中的方式来划分服务层,即service使声明,impl是实现,搞过java后台肯定知道
protocol UserService : class{
    var userModel : UserModel {get}
    //添加用户
    func saveUser(userModel : UserModel)
}
