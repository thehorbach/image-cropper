//
//  Global.swift
//  ImageCropping
//
//  Created by Vyacheslav Horbach on 25/11/16.
//  Copyright © 2016 Vjaceslav Horbac. All rights reserved.
//

import Foundation
import UIKit

struct xy {
    var x: CGFloat!
    var y: CGFloat!
    mutating func xy(_x: CGFloat , _y: CGFloat){
        self.x = _x
        self.y = _y
    }
}
enum CROP_TYPE{
    case square, rect3x2,  rect2x3,  rect3x4,  rect4x3,  rect2x5,  rect5x2
    static let divs = [square : 1, rect3x2 : 5, rect2x3 : 5,rect3x4 : 7, rect4x3 : 7, rect2x5 : 7,rect5x2 : 7]
    static let muls = [square : xy(x: 0.5, y: 0.5), rect3x2 : xy(x: 3/5, y: 2/5), rect2x3 : xy(x: 2/5, y: 2/5),rect3x4 : xy(x: 3/7, y: 4/7), rect4x3 : xy(x: 4/7, y: 3/7), rect2x5 : xy(x: 2/7, y: 5/7),rect5x2 : xy(x: 5/7, y: 2/7)]
    static let names = [square : " 1:1 ", rect3x2 : " 3:2 ", rect2x3 : " 2:3 ",rect3x4 : " 3:4 ", rect4x3 : " 4:3 ", rect2x5 : " 2:5 ",rect5x2 : " 5:2 "]
    func Div()-> Int{
        if let ret = CROP_TYPE.divs[self]{
            return ret
        }else{
            return -1
        }
    }
    func Muls()-> xy{
        if let ret = CROP_TYPE.muls[self]{
            return ret
        }else{
            return xy(x: 0.5,y: 0.5)
        }
    }
    func Name()-> String{
        if let ret = CROP_TYPE.names[self]{
            return ret
        }else{
            return "n.a."
        }
    }
}
struct CROP_OPTIONS {
    var Height: CGFloat!
    var Width: CGFloat!
    var Center: CGPoint!
}
struct FRAME {
    var Height: CGFloat!
    var Width: CGFloat!
}
var  _cropoptions: CROP_OPTIONS!
var _frame: CROP_OPTIONS!
var croptype: CROP_TYPE!
