//
//  DragableTextView.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 16.10.22.
//

import Foundation
import UIKit

class DragableTextView: UIView {
    
    var index: Int
    var text: String = "Your text here"
    
    var startX: CGFloat = 0
    var startY: CGFloat = 0
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.backgroundColor = .gray.withAlphaComponent(0.2)
        return textView
    }()
    
    init(frame: CGRect, index: Int, text: String) {
        self.index = index
        self.text = text
        super.init(frame: frame)
        
        self.addSubview(textView)
        
        textView.text = self.text
        textView.frame = self.frame
        
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(userDragged(gesture:)))
        self.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userTapped(gesture:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Selectors
extension DragableTextView {
    
    @objc func userTapped(gesture: UITapGestureRecognizer) {
        let insideLocation = gesture.location(ofTouch: 0, in: self)
        
        startX = insideLocation.x
        startY = insideLocation.y
    }
    
    @objc func userDragged(gesture: UIPanGestureRecognizer) {
        // LOCATION MUST BE PARENT!!!!
        // Means that we need to drag somethnig around in the bigger view.
        // So at the moment you're trying to move little view inside itself.
        
        // Either write a delegate or move dragging logic to parent view controller.
        guard let parentView = self.superview else { return }
        print("ParentView: ", parentView)
        let loc = gesture.location(in: parentView)
        
//        self.frame.origin.x = loc.x - startX
//        self.frame.origin.y = loc.y - startY
        
        self.frame.origin = CGPoint(x: loc.x - startX, y: loc.y - startY)
//        self.frame.origin = loc
        
        
    }
    
}
