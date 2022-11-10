//
//  ShopProductListVC.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit
import MJRefresh
class ShopProductListVC: UIViewController {
    
    var myTableView: UITableView?
    var resultArray: [ShopProductListModel] = [ShopProductListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "Shop"
        self.setUpSubViews()
        self.requestPageList()
        
    }
    
    func setUpSubViews() {
        let myTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), style: .plain)
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
        
        let headerRefresh = MJRefreshNormalHeader {
            self.requestPageList()
        }
        headerRefresh.stateLabel?.isHidden = true
        headerRefresh.lastUpdatedTimeLabel?.isHidden = true
        myTableView.mj_header = headerRefresh
        self.myTableView = myTableView
        
    }
    
    func requestPageList() {
        ShopProductListNetWork.requestPageContentList { [weak self] resultArrayTH in
            self?.myTableView?.mj_header?.endRefreshing()
            self?.resultArray = resultArrayTH
            self?.myTableView?.reloadData()
        }
    }
    
}

extension ShopProductListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultCell: ShopProductListCell = tableView.dequeueReusableCell(withIdentifier: ShopProductListCell.description(), for: indexPath) as! ShopProductListCell
        let itemModel: ShopProductListModel = self.resultArray[indexPath.row]
        resultCell.recePageModel(dataModel: itemModel)
        resultCell.selectRowNum = indexPath.row
        resultCell.selectRowIndex = { [self] (selectRow) -> Void in
            var result:[ShopProductListModel] = [ShopProductListModel]()
            for cellRow in 0..<resultArray.count {
                let itemModel: ShopProductListModel = resultArray[cellRow]
                if cellRow == selectRow{
                    itemModel.isCollection = !itemModel.isCollection
                    self.handleSelectItem(itemModel)
                    
                }
                result.append(itemModel)
            }
            resultArray = result
            self.myTableView?.reloadData()
        }
        return resultCell
    }
    
    func handleSelectItem(_ itemModel: ShopProductListModel) {
        let shopRoot = self.getCurrentWindow().rootViewController as? ShopRootTabbarVC
        let collectionShop = shopRoot?.collectionVC
        var arraySource = collectionShop?.resultArray
        if itemModel.isCollection {
            arraySource?.append(itemModel)
        } else {
            for index in 0..<(arraySource?.count ?? 0) {
                let selectModel = arraySource?[index]
                if selectModel?.id == itemModel.id {
                    arraySource?.remove(at: index)
                    break
                }
            }
        }
        collectionShop?.refreshPageList(listArray: arraySource ?? [ShopProductListModel]())
    }
    
    func getCurrentWindow() -> UIWindow {
        var window: UIWindow? = nil
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.connectedScenes
                .filter( {$0.activationState == .foregroundActive})
                .map({ $0 as? UIWindowScene})
                .compactMap({ $0 })
                .last?.windows
                .last
        } else {
            window = UIApplication.shared.keyWindow
        }
        return window ?? UIWindow()
    }
}

extension ShopProductListVC : UITableViewDelegate {
    
}
