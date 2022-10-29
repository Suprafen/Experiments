//
//  TextContainers.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 24.10.22.
//

import Foundation
import UIKit


class TextContainersViewController: UIViewController {
    
    
    var textContainer: NSTextContainer = {
        let textContainer = NSTextContainer(size: CGSize(width: 200, height: 200))
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        
        return textContainer
    }()
    
    
    let layoutManager: NSLayoutManager = {
        let layoutManager = NSLayoutManager()
        
        return layoutManager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        makePreps()
    }
    
    
    let attributedString = NSAttributedString(string: "Something goes here. What it can be?", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
    
    
    
    func makePreps() {
        layoutManager.addTextContainer(textContainer)
        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
                                  textContainer: textContainer)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 2
        
        let textStorage = NSTextStorage(attributedString: attributedString)
        textStorage.addLayoutManager(layoutManager)
        
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
