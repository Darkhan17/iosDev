//
//  Rectangle.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/19/21.
//

import Foundation
import UIKit

class Rectangle: Shape {
    private var p1: CGPoint
    private var p2: CGPoint

    
    
    init(p1:CGPoint, p2:CGPoint, color:UIColor, strokeWidth: CGFloat, isFilled: Bool) {
        self.p1 = p1
        self.p2 = p2
        super.init(color: color, strokeWidth: strokeWidth, isFilled: isFilled)
    }
    
    override func drow(){
        let rect = CGRect(origin: p1, size: CGSize(width: abs(max(p2.x,p1.x) - min(p2.x, p1.x)), height: abs(max(p2.y,p1.y) - min(p1.y, p2.y))))
        let path = UIBezierPath(rect: rect)
        super.drowPath(path: path)
    }
}
