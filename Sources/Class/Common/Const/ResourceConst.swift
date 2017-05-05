//
//  ResourceConst.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/5/5.
//
//

import Foundation
struct ResourceConst {
    //静态资源根目录,用于存放html,js,css等文件
    static let webRoot : String = NSHomeDirectory() + "/Desktop/PiaojinSwiftServer/Sources/WebRoot/"
    //登录页面
    static let login : String = "Pages/login.html"
    //欢迎页面
    static let welcome : String = "Pages/welcome.html"
}
