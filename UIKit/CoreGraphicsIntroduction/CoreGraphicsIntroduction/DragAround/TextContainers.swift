//
//  TextContainers.swift
//  CoreGraphicsIntroduction
//
//  Created by Ivan Pryhara on 24.10.22.
//

import Foundation
import UIKit


class TextContainersViewController: UIViewController {
    
    let textStorage: NSTextStorage = {
        let attributedString = NSAttributedString(string: "Something goes here. What it can be?", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        
        let textStorage = NSTextStorage(attributedString: attributedString)
        
        return textStorage
    }()
    
    let layoutManager: NSLayoutManager = {
        let layoutManager = NSLayoutManager()
        
        return layoutManager
    }()
    
    let textContainer: NSTextContainer = {
        let textContainer = NSTextContainer(size: CGSize(width: 100, height: 100))
        textContainer.lineBreakMode = .byClipping
        textContainer.maximumNumberOfLines = 7
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        
        return textContainer
    }()
    
    let secondTextContainer: NSTextContainer = {
        let textContainer = NSTextContainer(size: CGSize(width: 100, height: 100))
        textContainer.lineBreakMode = .byClipping
        textContainer.maximumNumberOfLines = 7
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        
        return textContainer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    
        viewsSetup()
    }
    
    func viewsSetup() {
        
        textStorage.addLayoutManager(layoutManager)
        
        layoutManager.addTextContainer(textContainer)
        layoutManager.addTextContainer(secondTextContainer)
        
        
        let firstTextView = UITextView(frame: CGRect(x: 30, y: 400, width: 70, height: 200), textContainer: textContainer)
        
        let secondTextView = UITextView(frame: CGRect(x: 200, y: 400, width: 70, height: 200), textContainer: secondTextContainer)
        
//        secondTextView.is
        
        view.addSubview(firstTextView)

        view.addSubview(secondTextView)
        
    }
    
    func textSetup() {
        
    }
    
    @objc func changeText() {
        print("TextStorage: \(textStorage)")
    }
}
