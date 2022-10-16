//
//  DragViewController.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 16.10.22.
//

import Foundation
import UIKit

class DragViewController: UIViewController {
    
    
    private let textView: UITextField = {
        let textView = UITextField(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
        textView.text = "Hello, world. WE gonna drag you."
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .blue.withAlphaComponent(0.1)
        
        return textView
    }()
    
    
    private let myView: UIView = {
        let view = UIView(frame: CGRect(x: 200, y: 300, width: 200, height: 200))
        view.backgroundColor = .black
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    
    var isDragging = false
    
    // These points desrcibe location inside view
    // While ignoring parent-view-location
    var startX: CGFloat = 0
    var startY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(myView)
    }
}

extension DragViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let point = touch.location(in: myView)

        startX = point.x
        startY = point.y
        
        if myView.bounds.contains(point) {
            isDragging = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else { return }
        
        // need to know location in the parent view
        
        let location = touch.location(in: view)
        
        // Depends on where dragable view is located on parent view
        // We calculate it's origin by formula
        // (Current location in the parent) - start point inside the dragable view  = new origin for current view
        myView.frame.origin.x = location.x - startX
        myView.frame.origin.y = location.y - startY
        
        // This approach helps to use start position as a control point to drag dragable view
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
    }
}
