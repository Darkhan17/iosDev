//
//  Pen.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/19/21.
//

import Foundation
import UIKit

class Pen: Shape {
    private var p1: CGPoint
    private var p2: CGPoint
    
    
    init(p1:CGPoint, p2:CGPoint, color:UIColor, strokeWidth: CGFloat, isFilled:Bool){
        self.p1 = p1
        self.p2 = p2
        super.init(color: color, strokeWidth: strokeWidth, isFilled: isFilled)
    }
    
    override func drow() {
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        super.drowPath(path: path)
    }
}
