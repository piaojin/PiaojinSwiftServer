# PiaojinSwiftServer
# 基于Perfect的Swift3.1服务器开发案例
# 开发环境 mac os,Xcode8.3,Swift3.1
# 建议先去https://www.perfect.org/docs/gettingStartedFromScratch_zh_CN.html查阅官方文档在往下读<br>
# 1.本项目数据库采用MySql所以必须先安装好MySql<br>
# 2.main.swift文件中引入相关模块<br>
import PerfectLib<br>
import PerfectHTTP<br>
import PerfectHTTPServer<br>
# 3.创建一个路由Routes,我这边封装到一个自定义类中即相当于SpringMVC中的控制器,每个Routes相当于控制器中的处理请求的方法<br>

import Foundation<br>
import PerfectHTTP<br>
/// 用于接受请求并根据请求创建响应内容的句柄函数格式。<br>
public typealias RequestHandler = (HTTPRequest, HTTPResponse) -> ()<br>
//创建一个类,类似springMVC中的控制器<br>
public class MainController : NSObject{<br>
    let requestHandler : RequestHandler = {<br>
        (request : HTTPRequest, response : HTTPResponse)<br>
        in<br>
        response.setBody(string: "路由句柄已经收到,hello piaojin!")<br>
        response.completed()<br>
    }<br>
    
    //路由,用于处理一个请求<br>
    public var testRoute : Routes = Routes()<br>
    
    public override init() {<br>
        testRoute.add(method: .get, uri: "/testRoutes", handler:requestHandler)<br>
        super.init()<br>
    }<br>
}<br>


# 4.创建服务器,这块可以查阅官方文档<br>

/// MARK: 第1步创建一个服务<br>
// Create HTTP server.<br>
let server = HTTPServer()<br>

/// MARK: 第2步创建一个路由管理控制器相当于springMVC中的控制器(自定义,可以直接跳过,直接创建路由)<br>
let controller : MainController = MainController()<br>

/// MARK: 第3步在服务器上注册路由,路由的注册必须在服务器启动之前(server.start())<br>
server.addRoutes(controller.testRoute)<br>

// Set a listen port of 8080<br>
server.serverPort = 8080<br>

// Set a document root.<br>
// This is optional. If you do not want to serve static content then do not set this.<br>
// Setting the document root will automatically add a static file handler for the route /**<br>
server.documentRoot = "./webroot"<br>

do {<br>
    /// MARK: 第4步启动服务<br>
    // Launch the HTTP server.<br>
    try server.start()<br>
    
} catch PerfectError.networkError(let err, let msg) {<br>
    print("Network error thrown: \(err) \(msg)")<br>
}<br>
任何疑问发邮件:(804488815@qq.com)<br>
# 备注:在编译的过程中很容易出错,个人建议使用命令行编译,链接再用Xcode打开运行,每次修改后如果是小修改可以直接Xcode编译运行,如果是大修改,引入其他模块最好用命令行编译,命令行编译可以去官方网站查阅,此处不做重复工作.需要注意Swift Package的管理方式,可以去http://www.jianshu.com/p/a5daea3ef144查看,遇到the package has an unsupported layout问题一样可以查看前面的文章(复制黏贴别人的😝,福建文档写的最烂的男人是也!).
