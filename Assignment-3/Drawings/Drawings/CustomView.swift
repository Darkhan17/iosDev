//
//  CustomView.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/19/21.
//

import UIKit

class CustomView: UIView{

    
    
    
    var point1 : CGPoint?
    var point2 : CGPoint!
    var drawings = [Shape]()
    var filled : Bool = false
    var shape : String?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
    enum shapes {
        case Circle
        case Rectangle((CGPoint,CGPoint,UIColor,CGFloat,Bool)->Rectangle)
    }
 
    
    
    
    override func draw(_ rect: CGRect) {
        if let p1 = point1{
            let rect = Rectangle.init(p1: p1, p2: point2, color: .green, strokeWidth: 4, isFilled: false)
            drawings.append(rect)
            for item in drawings{
                item.drow()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            point1 = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            point2 = touch.location(in: self)
        }
        setNeedsDisplay()
    }


}

extension Double{
    var cg: CGFloat{
        return CGFloat(self)
    }
}
