//
//  CellSegue.swift
//  Animation
//
//  Created by Khamitov Darkhan on 4/3/21.
//

import UIKit

class CellSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    override func perform() {
        self.destination.view.transform = CGAffineTransform(scaleX: 0.005, y: 0.005)
        self.destination.view.center = self.source.view.center
        self.destination.transitioningDelegate = self
        self.source.view.superview?.addSubview(self.destination.view)
        UIView.animate(withDuration: 0.8, animations: {
            self.destination.view.transform = CGAffineTransform.identity
        }, completion: {_ in self.source.present(self.destination, animated: false, completion: nil)})
    }
}
