//
//  ShopRootTabbarVC.swift
//  SwiftShoppingDemo
//
//  Created by superfly on 2022/10/23.
//

import UIKit
class ShopRootTabbarVC: UITabBarController {
    let collectionVC = ShopCollectionVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMainPage()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadMainPage() {
        
        let listVC = ShopProductListVC()
        
        
        let meVC = ShopMeVC()
        
        if let shopImage = UIImage(named: "shop_home") {
            self.showNavigationView(listVC, "shop", shopImage, 0)
        }
        
        if let collectionImage = UIImage(named: "shop_collection") {
            self.showNavigationView(collectionVC, "collection", collectionImage, 1)
        }
        
        if let meImage = UIImage(named: "shop_me") {
            self.showNavigationView(meVC, "me", meImage, 2)
        }
        
        
    }
    
    func showNavigationView(_ childViewController: UIViewController, _ title: String, _ itemImage: UIImage , _ itemTag : Int) {
        childViewController.tabBarItem = UITabBarItem(title: title, image: itemImage, tag: itemTag)
        let normalNav = UINavigationController.init(rootViewController: childViewController)
        self.addChild(normalNav)
    }
}


