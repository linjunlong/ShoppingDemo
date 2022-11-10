//
//  ShowProductListModel.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit
import HandyJSON
class ShopProductListModel: HandyJSON {
    var isCollection :Bool = false
    var cover: String = ""
    var id: Int?
    var name: String?
    var price: Double?
    var rating: Int?
    var images: [String]?
    // 必须实现一个空方法
    required init(){}
    
}
