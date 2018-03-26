//
//  MainTabVC.swift
//  Dingding
//
//  Created by 黄周鸿 on 2018/3/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildVC()
    }

    func setupChildVC() {
        self.viewControllers = [createVC(cls: MessageVC.self, title: "消息", inNav: true),
        createVC(cls: WorkVC.self, title: "工作", inNav: true)]
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
