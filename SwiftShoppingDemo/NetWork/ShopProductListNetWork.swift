//
//  ShopProductListNetWork.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit
import Moya
import HandyJSON
class ShopProductListNetWork: NSObject {
    typealias requestDataListCallBack = (_ resultArray : [Any]) -> ()
    typealias successCallBack = (_ resultArray : [ShopProductListModel]) -> Void
    static func requestPageContentList(_ resultCallArray : successCallBack?) {
        let provider = MoyaProvider<ShopManagerApi>()
        provider.request(.requestPageListData) {result in
            switch result{
            case .success(let respon):
                // 解析数据
                let data = try? respon.mapJSON()
                let compost: [ShopProductListModel] = try! JSONDeserializer<ShopProductListModel>.deserializeModelArrayFrom(json: respon.mapString()) as! [ShopProductListModel]
                print("errfddfdfdfdfor:\(String(describing: compost))")
                resultCallArray!(compost)
            case .failure(let error):
                print("error:\(error.localizedDescription)")
                
            }
        }
    }
    
}
