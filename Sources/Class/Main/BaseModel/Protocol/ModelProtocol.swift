//
//  ModelProtocol.swift
//  PiaojinSwiftServer
//
//  Created by 飘金 on 2017/4/28.
//
//

import Foundation

protocol ModelProtocol {
    /// MARK: 解析request的参数返回模型对象
    func transformParams(params : [(String, String)]) -> Bool
}
