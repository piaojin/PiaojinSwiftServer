//
//  UserModel.swift
//  PiaojinSwiftServer
//
//  Created by piaojin on 2017/4/27.
//
//

import Foundation
import MySQLStORM
import StORM
import PerfectLogger
public enum RoleType : Int{
    case userType//普通用户
    case adminType//管理员
}

class UserModel : BaseModel{
    // ⚠️注意⚠️：第一个属性将成为主索引字段，所以应该是ID。
    var id : Int!
    
    var name : String = ""
    
    var pwd : String = ""
    
    var role : Int = 0
    
    /// 数据类对象与数据库的属性绑定
    /// 为了能够让新编写的数据类正常工作，比如查询数据并把结果记录集转换成为对象数组等等，请一定要在您的数据类中增加以下两个函数：
    override public func to(_ this: StORMRow) {
        self.id = this.data["id"] as? Int
        
        if let tempName = this.data["name"] as? String{
            self.name = tempName
        }
        
        if let tempPwd = this.data["pwd"] as? String{
             self.pwd = tempPwd
        }
    
        if let tempRole = this.data["role"] as? Int {
            self.role = tempRole
        }
    }
    
    func rows() -> [UserModel] {
        var rows = [UserModel]()
        for i in 0..<self.results.rows.count {
            let row = UserModel()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        return rows
    }
    
    //告诉数据库该Model对应的表
    override public func table() -> String {
        return "User"
    }

    /// MARK: 解析request的参数返回模型对象
    override func transformParams(params : [(String, String)]) -> Bool{
        guard params.count > 0 else{
            return false
        }
        
        let tempName = self.param(queryParams: params, name: "name", defaultValue: "nil-name")
        let tempPwd = self.param(queryParams: params, name: "pwd")
        let tempId = self.param(queryParams: params, name: "id")
        let tempRoleType = self.param(queryParams: params, name: "role")
        
        if let tempId = tempId{
            self.id = Int(tempId)
        }
        
        if let tempName = tempName{
            self.name = tempName
        }
        
        if let tempPwd = tempPwd{
            self.pwd = tempPwd
        }
        
        if let tempRoleType = tempRoleType{
            self.role = Int(tempRoleType)!
        }
         return true
    }
}
