//
//  TableVC.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/1.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit
import DeclareLayoutSwift

class TableVC: SafeAreaVC, TableElementDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UIElement {
        let text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomIndex = arc4random_uniform(UInt32(text.count))
        let index = text.index(text.startIndex, offsetBy: Int(randomIndex))
        let randString: String = String(text[...index])

        return Grid(.columns <= [.auto(min: 50), .star(1)], .padding <= Insets(vertical: 8, horizontal: 20)) {
//            [ViewElement {
//                UILabel(.text <= String(indexPath.row))
//            },
            [Label(.text <= String(indexPath.row)),
             Label(.gridColumnIndex <= 1,.text <= randString,.numberOfLines <= 0)]
//             ViewElement(.gridColumnIndex <= 1) {
//                let text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//                let randomIndex = arc4random_uniform(UInt32(text.count))
//                let index = text.index(text.startIndex, offsetBy: Int(randomIndex))
//                //                let string:String = String(text[...index])
//                let label = UILabel(.text <= String(text[...index]))
//                label.numberOfLines = 0
//                //                label.lineBreakMode = .byCharWrapping
//                return label
//            }]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHostView {
            HostView {
                TableElement(.delegate <= self)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
