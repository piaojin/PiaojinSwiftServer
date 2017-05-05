//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

/// MARK: 第1步创建一个服务实例
let server = HTTPServer()

/// MARK: 第2步创建一个路由管理控制器相当于springMVC中的控制器(自定义,可以直接跳过,直接创建路由)
let userController : UserController = UserController()

/// MARK: 第3步在服务器上注册路由,路由的注册必须在服务器启动之前(server.start())
server.addRoutes(userController.route)

// Set a listen port of 8080
server.serverPort = 8080

// Set a document root.
// 这是可选的。如果你不想提供静态内容,不设置这个。设置文档根目录会自动添加一个静态文件处理程序 /**
server.documentRoot = "./webroot"
do {
    /// MARK: 第4步启动服务
    try server.start()
    
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}

