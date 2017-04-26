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

/// MARK: 第1步创建一个服务
// Create HTTP server.
let server = HTTPServer()

/// MARK: 第2步创建一个路由管理控制器相当于springMVC中的控制器(自定义,可以直接跳过,直接创建路由)
let controller : MainController = MainController()

/// MARK: 第3步在服务器上注册路由,路由的注册必须在服务器启动之前(server.start())
server.addRoutes(controller.testRoute)

// Set a listen port of 8080
server.serverPort = 8080

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**
server.documentRoot = "./webroot"

do {
    /// MARK: 第4步启动服务
    // Launch the HTTP server.
    try server.start()
    
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}

