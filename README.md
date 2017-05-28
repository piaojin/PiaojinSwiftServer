# PiaojinSwiftServer
# 基于Perfect的Swift3.1服务器开发案例
# 开发环境 mac os,Xcode8.3,Swift3.1
# 建议先去https://www.perfect.org/docs/gettingStartedFromScratch_zh_CN.html<br>查阅官方文档在往下读<br>
# 1.本项目数据库采用MySql所以必须先安装好MySql<br>
# 2.main.swift文件中引入相关模块<br>
```
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
```
# 3.创建一个路由Routes,我这边封装到一个自定义类中即相当于SpringMVC中的控制器,每个Routes相当于控制器中的处理请求的方法<br>

```
import Foundation
import PerfectHTTP
/// 用于接受请求并根据请求创建响应内容的句柄函数格式。
public typealias RequestHandler = (HTTPRequest, HTTPResponse) -> ()
//创建一个类,类似springMVC中的控制器
public class MainController : NSObject{
    
    let testRequestHandler : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        response.setBody(string: "路由句柄已经收到,hello piaojin!")
        response.completed()
    }
    
    let testRequestHandler2 : RequestHandler = {
        (request : HTTPRequest, response : HTTPResponse)
        in
        response.setBody(string: "路由句柄已经收到,hello piaojin2!")
        response.completed()
    }
    
    //路由,用于处理一个请求
    public lazy var route : Routes = {
        var tempRoute : Routes = Routes()
        //add方法相当于添加一个拦截特定请求的方法
        tempRoute.add(method: .get, uri: "/testRoutes", handler:self.testRequestHandler)
        tempRoute.add(method: .get, uri: "/testRoutes2", handler:self.testRequestHandler2)
        return tempRoute
    }()
    
    public override init() {
        super.init()
    }
}
```


# 4.创建服务器,这块可以查阅官方文档<br>

```
/// MARK: 第1步创建一个服务
// Create HTTP server.
let server = HTTPServer()

/// MARK: 第2步创建一个路由管理控制器相当于springMVC中的控制器(自定义,可以直接跳过,直接创建路由)
let controller : MainController = MainController()

/// MARK: 第3步在服务器上注册路由,路由的注册必须在服务器启动之前(server.start())
server.addRoutes(controller.route)

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
```
任何疑问发邮件:(804488815@qq.com)
# 备注:在编译的过程中很容易出错,个人建议使用命令行编译,链接再用Xcode打开运行,每次修改后如果是小修改可以直接Xcode编译运行,如果是大修改,例如:添加文件,引入其他模块最好用命令行编译,命令行编译可以去官方网站查阅,此处不做重复工作.如果Xcode编译时报错不知道哪里错误,还是得命令行在编译试试.需要注意Swift Package的管理方式,可以去http://www.jianshu.com/p/a5daea3ef144<br>查看,遇到the package has an unsupported layout问题一样可以查看前面的文章(复制黏贴别人的😝,福建文档写的最烂的男人是也!).
