//
//  ViewController.swift
//  CustomDetentSheet
//
//  Created by Ivan Pryhara on 17.06.22.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    func configureView() {
        self.view.backgroundColor = .systemOrange
        // Instantiate view
        let view = UINavigationController(rootViewController: ShowedViewController())
        // Configure sheet for the view
        if let sheet = view.sheetPresentationController {
            sheet.detents = [.large(),
                .medium(),
                // Define custom detent which is 10% 
                .custom { context in
                    0.1 * context.maximumDetentValue
                }]
            
            sheet.prefersGrabberVisible = true
        }
        self.present(view, animated: true)
    }
}

