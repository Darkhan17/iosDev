//
//  Triangle.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/19/21.
//

import Foundation
import UIKit


class Triangle: Shape {
    private var firstPoint : CGPoint
    private var secondPoint : CGPoint
    
    init(firstPoint: CGPoint ,secondPoint : CGPoint, color: UIColor, strokeWidth: CGFloat, isFilled: Bool) {
        self.firstPoint = firstPoint
        self.secondPoint = secondPoint
        super.init(color: color, strokeWidth: strokeWidth, isFilled: isFilled)
    }
    
    
    override func drow() {
        let triangle = UIBezierPath()
        triangle.move(to: CGPoint(x: firstPoint.x, y: firstPoint.y))
        triangle.addLine(to: CGPoint(x: firstPoint.x, y: secondPoint.y))
        triangle.addLine(to: CGPoint(x: secondPoint.x, y: secondPoint.y))
        triangle.close()
        super.drowPath(path: triangle)
    }
}
