//
//  Circle.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/19/21.
//

import Foundation
import UIKit

class Circle : Shape {
    private var radius: CGFloat = 0.0
    private var circleCenter: CGPoint
 
    
    init(point1:CGPoint, point2:CGPoint, withSome color: UIColor, and strokeWidth : CGFloat, isFilled : Bool) {
        self.circleCenter = CGPoint(x:(max(point2.x,point1.x) - min(point2.x,point1.x)), y: (max(point2.y,point1.y) - min(point1.y,point2.y)))
        self.radius = sqrt(pow((point1.x - point2.x),2)+pow((point1.y-point2.y),2))/2
        super.init(color: color, strokeWidth: strokeWidth, isFilled: isFilled)
    }
    
    
    override func drow() {
        let path = UIBezierPath(arcCenter :circleCenter,
                                radius: radius,
                                startAngle: 0,
                                endAngle : 2*Double.pi.cg,
                                clockwise: true)
        super.drowPath(path: path)
    }
    
}
