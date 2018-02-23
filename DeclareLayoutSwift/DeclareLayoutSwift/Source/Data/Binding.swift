//
//  Binding.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/31.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

class Binding : NSObject{
    var path:String
    var source:NSObject!
    
    var target:NSObject
    var targetPropertyName:String
    
//    init(source:NSObject,path:String,target:NSObject,propertyName:String) {
//        self.source = source
//        self.path = path
//        self.target = target
//        self.targetPropertyName = propertyName
//    }
    init(path:String,target:NSObject,propertyName:String) {
        self.path = path
        self.target = target
        self.targetPropertyName = propertyName
    }
    
    func setBinding(){
        source.addObserver(self, forKeyPath: path, options:[.new , .initial], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        SpeedLog.print("receive value changed")
        if let change = change{
            print(change)
            
            let newValue = change[NSKeyValueChangeKey.newKey]
            print(newValue)

        }else{
            print("empty")
        }
        
    }
    
    func test(aa:Int=1,bb:Int=2,cc:Int=3){
        
    }
    
    func test(bb:Int,aa:Int,cc:Int){
        
    }
    
//    func setBinding(target:NSObject,propertyName:String){
//        source.addObserver(self, forKeyPath: path, options: .new, context: nil)
//    }
}
