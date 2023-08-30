//
//  UIImageView + Extention.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
