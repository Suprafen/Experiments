//
//  TestViewController.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 14.10.22.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    
    var drawView = DrawingView(frame: CGRect())
    
    var drawContainerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(drawContainerView)
        drawContainerView.frame = self.view.bounds
        
        drawView.frame = self.drawContainerView.bounds
        self.drawContainerView.addSubview(drawView)
        drawView.setNeedsLayout()
        
        
    }
}
