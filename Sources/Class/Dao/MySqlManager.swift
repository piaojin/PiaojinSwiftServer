//
//  MySqlManager.swift
//  PiaojinSwiftService
//
//  Created by 飘金 on 2017/4/26.
//
//

import Foundation
import PerfectHTTP
import PerfectLib
import MySQL

class MySqlManager: NSObject {

    //连接的数据库地址
    let testHost = "127.0.0.1"
    //数据库登录的用户名
    let testUser = "root"
    // PLEASE change to whatever your actual password is before running these tests
    //登录数据库的密码
    let testPassword = "1234"
    //要连接的数据库
    let database = "swift_test"
    //执行数据库一些列操作的对象
    let dataMysql = MySQL()
    
    //测试数据库是否可以连接成功,并执行一条查询语句
    public func useMysql(_ request: HTTPRequest, response: HTTPResponse) {
        
        /// MARK: 1.连接数据库
        // need to make sure something is available.
        guard dataMysql.connect(host: testHost, user: testUser, password: testPassword ) else {
            Log.info(message: "Failure connecting to data server \(testHost)")
            return
        }
        
        defer {
            /// MARK: 5.关闭数据库连接
            dataMysql.close()  // defer ensures we close our db connection at the end of this request
        }
        
        /// MARK: 2.选择数据库并且执行sql语句
        //set database to be used, this example assumes presence of a users table and run a raw query, return failure message on a error
        guard dataMysql.selectDatabase(named: database) && dataMysql.query(statement: "select * from swift_table limit 1") else {
            Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
            
            return
        }
        
        /// MARK: 3.获取到SQL语句执行返回的结果集
        //store complete result set
        let results = dataMysql.storeResults()
        
        //setup an array to store results
        var resultArray = [[String?]]()
        
        while let row = results?.next() {
            resultArray.append(row)
            
        }
        
        /// MARK: 4.返回结果集给数据访问者
        //return array to http response
        response.appendBody(string: "<html><title>Mysql Test</title><body>\(resultArray.debugDescription)</body></html>")
        response.completed()
        
    }
    
}
