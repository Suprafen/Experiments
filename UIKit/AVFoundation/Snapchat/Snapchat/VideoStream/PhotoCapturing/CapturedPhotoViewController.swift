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
    
    let doneButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        let image =  UIImage(systemName: "arrow.up")?.withRenderingMode(.alwaysTemplate)
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(dismissView), for: .touchUpInside)
        
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward.circle"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(dismissView), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        view.addSubview(blackView)
        
        view.addSubview(buttonsStack)

        buttonsStack.addArrangedSubview(dismissButton)
        buttonsStack.addArrangedSubview(doneButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presentedPhotoView.frame = view.frame
        
        NSLayoutConstraint.activate([
            
            blackView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonsStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
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
