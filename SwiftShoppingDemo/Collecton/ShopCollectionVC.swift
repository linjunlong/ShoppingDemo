//
//  ShopCollectionVC.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit

class ShopCollectionVC: UIViewController {
    var myTableView : UITableView?
    var resultArray : [ShopProductListModel] = [ShopProductListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "Collection"
        self.view.backgroundColor = .white
        
        self.loadMainPageView()
    }
    
    func loadMainPageView() {
        let myTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0),style: .plain)
        myTableView.register(ShopProductListCell.self, forCellReuseIdentifier: ShopProductListCell.description())
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
        NSLayoutConstraint.activate([
            myTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            myTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            myTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.myTableView = myTableView
    }
    
    func refreshPageList(listArray: [ShopProductListModel]) {
        let storeTool = ShopStoreLocallyTool()
        let arraySource = storeTool.getSourceData()
        self.resultArray = listArray
        self.myTableView?.reloadData()
    }
}

extension ShopCollectionVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultCell : ShopProductListCell = tableView.dequeueReusableCell(withIdentifier: ShopProductListCell.description(), for: indexPath) as! ShopProductListCell
        let itemModel : ShopProductListModel = self.resultArray[indexPath.row]
        resultCell.recePageModel(dataModel: itemModel)
        resultCell.selectRowNum = indexPath.row
        resultCell.selectRowIndex = {
            [self](selectRow) -> Void in
            var result : [ShopProductListModel] = [ShopProductListModel]()
            for cellRow in 0..<resultArray.count {
                let itemModel: ShopProductListModel = resultArray[cellRow]
                if cellRow == selectRow {
                    itemModel.isCollection = !itemModel.isCollection
                }
                result.append(itemModel)
            }
            resultArray = result
            self.myTableView?.reloadData()
        }
        return resultCell
        
    }
    
    
}

extension ShopCollectionVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
