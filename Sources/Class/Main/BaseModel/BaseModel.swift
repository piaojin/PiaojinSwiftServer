//
//  BaseModel.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/4/28.
//
//

import MySQLStORM
import StORM
import PerfectLogger
class BaseModel: MySQLStORM,ModelProtocol{
    
    override func save() throws {
    do {
        if idIsEmpty() {
            try insert(asData(1))
        } else {
            let (idname, idval) = firstAsKey()
            try update(data: asData(1), idName: idname, idValue: idval)
        }
    } catch {
        LogFile.error("Error msg: \(error)", logFile: "./StORMlog.txt")
        throw StORMError.error("\(error)")
    }
  }
    
    override func save(set: (_ id: Any)->Void) throws {
        do {
            if idIsEmpty() {
                let setId = try insert(asData(1))
                set(setId)
            } else {
                let (idname, idval) = firstAsKey()
                try update(data: asData(1), idName: idname, idValue: idval)
            }
        } catch {
            LogFile.error("Error msg: \(error)", logFile: "./StORMlog.txt")
            throw StORMError.error("\(error)")
        }
    }
    
    //父类中的keyIsEmpty()方法在id为nil的时候会报错,而该方法又不可以提供重写,故子类需要重写save并将其中的keyIsEmpty()换成自己写的方法
    public func idIsEmpty() -> Bool {
        let (_, val) = firstAsKey()
        if val is Int {
            if val as! Int == 0 {
                return true
            } else {
                return false
            }
        } else {
            guard let id = val as? String else {
                return true
            }
            
            if id.isEmpty {
                return true
            } else {
                return false
            }
        }
    }
    
    /// MARK: 解析request的参数到self本身,需要子类去重写
    func transformParams(params : [(String, String)]) -> Bool{
        return false
    }
}

extension BaseModel{
    
    public func param(queryParams: [(String, String)], name: String, defaultValue: String? = nil) -> String? {
        for p in queryParams
            where p.0 == name {
                return p.1
        }
        return defaultValue
    }
    
    public func params(named: String, queryParams: [(String, String)]) -> [String] {
        let a = queryParams.filter { $0.0 == named }.map { $0.1 }
        return a
    }
}
