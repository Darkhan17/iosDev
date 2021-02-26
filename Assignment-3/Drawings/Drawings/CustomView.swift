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
    var color : UIColor = .green
    var colorButton : String = "green"
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
    
    func getColor() {
        switch colorButton {
        case "green":
            color = UIColor.green
        case "yellow":
            color = UIColor.yellow
        case "red":
            color = UIColor.red
        default:
            break
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        if let p1 = point1{
            getColor()
            switch shape {
            case "circle":
                drawings.append(Circle.init(point1: p1, point2: point2, withSome: color, and: 4, isFilled: filled))
            case "rectangle":
                drawings.append(Rectangle.init(p1: p1, p2: point2, color: color, strokeWidth: 4, isFilled: filled))
            case "triangle":
                drawings.append(Triangle.init(firstPoint: p1, secondPoint: point2, color: color, strokeWidth: 4, isFilled: filled))
            case "line":
                drawings.append(Line.init(p1: p1, p2: point2, color: color, strokeWidth: 4, isFilled: filled))
            default:
                break
            }
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
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let movedPoint = touches.first?.location(in: self)
        
        if (shape == "pen"){
            if let p1 = point1{
            getColor()
            drawings.append(Pen.init(p1: p1, p2: movedPoint!, color: .red, strokeWidth: 4, isFilled: filled))
            point1 = movedPoint
            }
        }
    }

}

extension Double{
    var cg: CGFloat{
        return CGFloat(self)
    }
}
