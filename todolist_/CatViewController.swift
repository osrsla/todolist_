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

//// UIView.animate 메서드를 사용하여 요소의 위치를 이동합니다.
//UIView.animate(withDuration: 0.5) {
//    self.myView.frame.origin.x += 100 // x축으로 100만큼 이동합니다.
//}
//
//// UIView.animate 메서드를 사용하여 요소의 크기를 조절합니다.
//UIView.animate(withDuration: 0.5) {
//    self.myView.frame.size = CGSize(width: 200, height: 200) // 요소의 크기를 200x200으로 조절합니다.
//}
//
//// UIView.animate 메서드를 사용하여 요소의 투명도를 조절합니다.
//UIView.animate(withDuration: 0.5) {
//    self.myView.alpha = 0.5 // 요소의 투명도를 0.5로 조절합니다.
//}
