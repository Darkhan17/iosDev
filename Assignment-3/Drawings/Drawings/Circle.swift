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
 
    
    init(with radius:CGFloat, and circleCenter:CGPoint, withSome color: UIColor, and strokeWidth : CGFloat, isFilled : Bool) {
        self.circleCenter = circleCenter
        self.radius = radius
        super.init(color: color, strokeWidth: strokeWidth, isFilled: isFilled)
    }
    
    
    override func drow() {
        let path = UIBezierPath(arcCenter : circleCenter,
                                radius: radius,
                                startAngle: 0,
                                endAngle : 2*Double.pi.cg,
                                clockwise: true)
        super.drowPath(path: path)
    }
    
}
