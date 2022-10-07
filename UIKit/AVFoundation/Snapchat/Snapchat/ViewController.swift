//
//  ViewController.swift
//  Snapchat
//
//  Created by Ivan Pryhara on 5.10.22.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    private let showVideoStreamButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.buttonSize = .medium
        config.image = UIImage(systemName: "camera")
        
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        view.addSubview(showVideoStreamButton)

        showVideoStreamButton.addTarget(self, action: #selector(showVideoStream), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            showVideoStreamButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showVideoStreamButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func showVideoStream() {
        let controllerToPresent = VideoStreamViewController()
        if let sheet = controllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 15
        }
        
        self.present(controllerToPresent, animated: true)
        
    }
}
