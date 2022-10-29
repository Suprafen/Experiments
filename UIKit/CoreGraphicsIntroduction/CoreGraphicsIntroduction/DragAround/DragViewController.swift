//
//  DragViewController.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 16.10.22.
//

import Foundation
import UIKit

class DragViewController: UIViewController {
    
    var isDragging = false
    
    var textViews: [Int : DragableTextView] = [:]
    
    // These points desrcibe location inside view
    // While ignoring parent-view-location
    var startX: CGFloat = 0
    var startY: CGFloat = 0
    
    private let textView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
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
    
    
    private let addTextElementButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(systemName: "character"), for: .normal)
        button.addTarget(nil, action: #selector(addTextElement), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(myView)
        view.addSubview(textView)
        view.addSubview(addTextElementButton)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            addTextElementButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addTextElementButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
//    @objc func userDragged(gesture: UIPanGestureRecognizer) {
//        let loc = gesture.location(in: self.view)
//        self.textView.center = loc
//    }
    
    @objc func addTextElement() {
        let numberOfElements = textViews.count
        
        let textView = DragableTextView(frame: CGRect(x: 0, y: 0, width: 100, height: 70),
                                        index: numberOfElements,
                                        text: "Your Text Here")
        
        textViews[numberOfElements] = textView
        
        view.addSubview(textView)
        
        textView.center = view.center
//x
//        let tapGesture = UITapGestureRecognizer(target: textView, action: #selector(userTapped(gesture:sender:)))
//
//        textView.addGestureRecognizer(tapGesture)
//
//        let panGesture = UIPanGestureRecognizer(target: textView, action: #selector(userDragged(gesture:sender:)))
//
//        textView.addGestureRecognizer(panGesture)
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

extension DragViewController {
    
//    @objc func userTapped(gesture: UITapGestureRecognizer, sender: DragableTextView) {
//        let insideLocation = gesture.location(ofTouch: 0, in: view)
//
//        startX = insideLocation.x
//        startY = insideLocation.y
//    }
//
//    @objc func userDragged(gesture: UIPanGestureRecognizer, sender: DragableTextView) {
//        // LOCATION MUST BE PARENT!!!!
//        // Means that we need to drag somethnig around in the bigger view.
//        // So at the moment you're trying to move little view inside itself.
//
//        // Either write a delegate or move dragging logic to parent view controller.
//        let loc = gesture.location(in: self.view)
//
////        self.frame.origin.x = loc.x - startX
////        self.frame.origin.y = loc.y - startY
//
//        sender.frame.origin = CGPoint(x: loc.x - sender.startX, y: loc.y - sender.startY)
////        self.frame.origin = loc
//    }

}
