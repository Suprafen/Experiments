//
//  CapturedPhotoViewController.swift
//  Snapchat
//
//  Created by Ivan Pryhara on 8.10.22.
//

import Foundation
import UIKit

protocol CapturedPhotoDelegate {
    func getPhoto(_ image: UIImage)
}

class CapturedPhotoController: UIViewController {
    
    var image: UIImage
    
    var delegate: CapturedPhotoDelegate?
    
    let presentedPhotoView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let dismissButton: UIButton = {
        var buttonConfig = UIButton.Configuration.plain()
        let button = UIButton()
        buttonConfig.title = "Dismiss"
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(dismissView), for: .touchUpInside)
        
        return button
    }()
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) {
        fatalError("Oh nooo!!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentedPhotoView.image = image
        view.addSubview(presentedPhotoView)
        view.addSubview(dismissButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presentedPhotoView.frame = view.frame
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

   
}

//MARK: Selectors
extension CapturedPhotoController {
    @objc func dismissView() {
        delegate?.getPhoto(image)
        self.dismiss(animated: true)
    }
}
