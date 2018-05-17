//
//  MainTabVC.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/7.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildVC()
    }
    
    func setupChildVC() {
        self.viewControllers = [
            createVC(cls: HomeVC.self, title: "首页", inNav: true),
            createVC(cls: CommunityVC.self, title: "沸点", inNav: true)
        ]
    }
    
    func createVC(cls: UIViewController.Type, title: String, inNav: Bool) -> UIViewController {
        var vc = cls.init()
        vc.title = title
        if inNav {
            vc = UINavigationController(rootViewController: vc)
        }
        vc.view.backgroundColor = .white
        let image = #imageLiteral(resourceName: "TabBar_UnSelected").withRenderingMode(.alwaysOriginal)
        let selectedImage = #imageLiteral(resourceName: "TabBar_Selected").withRenderingMode(.alwaysOriginal)
        vc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return vc
    }
}
