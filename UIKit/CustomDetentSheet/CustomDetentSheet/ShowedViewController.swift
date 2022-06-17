//
//  ShowedViewController.swift
//  CustomDetentSheet
//
//  Created by Ivan Pryhara on 17.06.22.
//

import UIKit


class ShowedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        
        let searchView = UISearchBar()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchView)
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 30),
            searchView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
}
    
