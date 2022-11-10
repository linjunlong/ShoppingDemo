//
//  ShopManagerApi.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit
import Moya

enum ShopManagerApi {
    case requestPageListData
}

extension ShopManagerApi : TargetType {
    var baseURL: URL{
        return URL.init(string: "https://gitee.com/xiaoyouxinqing/Learn-iOS-from-Zero/raw/main/API/") ?? URL(fileURLWithPath: "")
    }
    
    var path: String {
        switch self {
        case .requestPageListData:
            return "Shopping/iPhone_1.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestPageListData:
            return .get
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .requestPageListData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type":"application/json",
            "version":"1.0.0"
        ]
    }
    
    ///单元测试
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
}

