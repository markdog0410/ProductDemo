//
//  MainTabBarViewController.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/16.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MemberViewController())
        let vc3 = UINavigationController(rootViewController: CartViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "cart")
        vc3.tabBarItem.image = UIImage(systemName: "gear")

        
        vc1.title = "首頁"
        vc2.title = "購物車"
        vc3.title = "設定"
        
        
        tabBar.tintColor = .systemGreen
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }

}
