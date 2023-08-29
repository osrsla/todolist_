//
//  CatViewController.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import Foundation
import UIKit

class CatViewController: UIViewController {
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension CatViewController {
    private func setup() {
        view.addSubview(imageView)
        imageView.image = UIImage(systemName: "photo")

        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 240),
            imageView.heightAnchor.constraint(equalToConstant: 240),
        ])
    }
}
