//
//  StackVC.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/26.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class StackVC: SafeAreaVC {
//    @IBOutlet weak var hostView: DeclareLayoutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let image=UIImage(named: "16")
//        let imageView=UIImageView(image: image)
//        imageView.verticalAlignment = .Center
        //
//        let topStackPanel = StackPanel()
//        topStackPanel.children.append(imageView)
//        topStackPanel.children.append(createInputGrid())
//        topStackPanel.orientation = .Horizontal
        //
//        let textView = UITextView()
//        textView.height = 300
        //
//        let mainStackPanel = StackPanel()
//        mainStackPanel.children.append(topStackPanel)
//        mainStackPanel.children.append(textView)
        //
//        self.hostView.loadUIElement(ele: mainStackPanel)
        
        setupHostView {
            HostView {
                StackPanel {
                    [StackPanel(.orientation <- .Horizontal) {
                        [Image(.image <- UIImage(named: "osx"), .vAlign <- .Center),
                         Grid(.rows <- [.star(1), .star(1), .star(1)], .columns <- [.auto, .star(1, min: 100, max: nil)]) {
                             [Label(.text <- "First"),
                              Label(.text <- "Middle", .gridRowIndex <- 1),
                              Label(.text <- "Last", .gridRowIndex <- 2),
                              TextField(.text <- "First", .gridColumnIndex <- 1),
                              TextField(.text <- "Middle", .gridRowIndex <- 1, .gridColumnIndex <- 1),
                              TextField(.text <- "Last", .gridRowIndex <- 2, .gridColumnIndex <- 1)]
                        }]
                    },
                     Label(.height <- 300)]
                }
            }
        }
    }
    
//    func createInputGrid()->Grid{
//        let label1=UILabel()
//        let label2=UILabel()
//        let label3=UILabel()
//        label1.text="First"
//        label2.text="middle"
//        label3.text="Last"
    //
//        let input1=UITextField()
//        let input2=UITextField()
//        let input3=UITextField()
//        input1.backgroundColor=UIColor.gray
//        input2.backgroundColor=UIColor.gray
//        input3.backgroundColor=UIColor.gray
    //
//        let inputGrid=Grid()
//        inputGrid.children.append(label1)
//        inputGrid.children.append(label2)
//        inputGrid.children.append(label3)
//        inputGrid.children.append(input1)
//        inputGrid.children.append(input2)
//        inputGrid.children.append(input3)
    //
//        inputGrid.rows = [.Star(star: 1, min: nil, max: nil),.Star(star: 1, min: nil, max: nil),.Star(star: 1, min: nil, max: nil)]
//        inputGrid.columns=[.Auto(min: nil, max: nil),.Star(star: 1, min: 100, max: nil)]
    //
//        Grid.setRow(ele: label2, row: 1)
//        Grid.setRow(ele: label3, row: 2)
//        Grid.setRow(ele: input2, row: 1)
//        Grid.setRow(ele: input3, row: 2)
//        Grid.setColumn(ele: input1, column: 1)
//        Grid.setColumn(ele: input2, column: 1)
//        Grid.setColumn(ele: input3, column: 1)
    //
//        return inputGrid
//    }
}
