//
//  Shape.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/19/21.
//

import Foundation

import UIKit

class Shape {
    private var color: UIColor
    private var strokeWidth : CGFloat = 0.0
    private var isFilled : Bool
    
    init(color:UIColor, strokeWidth: CGFloat, isFilled:Bool) {
        self.color = color
        self.strokeWidth = strokeWidth
        self.isFilled = isFilled
    }
    

    func drow(){}
    
    func drowPath(path:UIBezierPath) {
        path.lineWidth = strokeWidth
        color.set();
        (isFilled) ? (path.fill()) : (path.stroke())
    }
    
    
        
}
