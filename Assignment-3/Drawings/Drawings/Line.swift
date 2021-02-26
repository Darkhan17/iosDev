//
//  Line.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/19/21.
//

import Foundation
import UIKit


class Line: Shape {
    private var p1: CGPoint
    private var p2: CGPoint
    
    
    init(p1:CGPoint, p2:CGPoint, color: UIColor, strokeWidth: CGFloat, isFilled: Bool) {
        self.p1=p1;
        self.p2=p2;
        super.init(color: color, strokeWidth: strokeWidth, isFilled: isFilled)
    }
    
    override func drow() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:p1.x,y:p1.y))
        path.addLine(to: CGPoint(x:p2.x, y:p2.y))
        super.drowPath(path: path)
    }
}
