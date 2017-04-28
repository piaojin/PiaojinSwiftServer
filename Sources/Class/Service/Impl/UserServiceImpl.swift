//
//  UserServiceImpl.swift
//  PiaojinSwiftServer
//
//  Created by piaojin on 2017/4/27.
//
//

import Foundation
class UserServiceImpl: UserService {
    lazy var userModel: UserModel = {
        return UserModel()
    }()
    
    //添加用户
    func saveUser(userModel : UserModel){
        do {
            try userModel.save()
        } catch {
            print("添加用户失败,失败原因: \(error)")
        }
    }
}
