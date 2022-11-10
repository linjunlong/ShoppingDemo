//
//  ShopStoreLocallyTool.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit
import HandyJSON
class ShopStoreLocallyTool: NSObject {
    func fileHomePath() -> String {
        let homePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if let pathString = homePath.first {
            return pathString
        }
        return ""
    }
    
    // 获取或者新建路径
    func stroagePathInterviewFromSandbox() -> String {
        let directoryPath = fileHomePath() + "PassesStorageDirctory"
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directoryPath) {
            try? fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
        }
        
        let filePathString = directoryPath + "/" + "InterviewQuesionsFile"
        if(!fileManager.fileExists(atPath: filePathString)) {
            fileManager.createFile(atPath: filePathString, contents: nil, attributes: nil)
        }
        return filePathString
    }
    
    // 获取数据
    func getSourceData() -> Array<ShopProductListModel>? {
        let storgePath = self.stroagePathInterviewFromSandbox()
        let fileData = FileHandle.init(forReadingAtPath:  storgePath)
        if let listDataContent = fileData?.readDataToEndOfFile() {
            let jsonStr = String(data: listDataContent, encoding: .utf8)
            do {
                let anydict = try JSONSerialization.jsonObject(with: listDataContent)
                print("anydictfdfd--\(anydict)")
            } catch {
                
            }
            print("listJsonfdf--\(String(describing: jsonStr))")
            let compost: [ShopProductListModel]?  = JSONDeserializer<ShopProductListModel>.deserializeModelArrayFrom(json:jsonStr) as? [ShopProductListModel]
            return compost
        }
        return Array<ShopProductListModel>()
    }
}
