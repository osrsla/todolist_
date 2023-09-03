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
    var bellButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchRandomCatImage()
    }
}

extension CatViewController {
    private func setup() {
        navigationItem.title = "🐈🐈‍⬛ Cat 🐈‍⬛🐈"
        
        view.addSubview(imageView)
        view.addSubview(bellButton)

        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        bellButton.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        bellButton.tintColor = .systemYellow
        bellButton.addTarget(self, action: #selector(bellButtonTapped), for: .touchUpInside)
        bellButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            bellButton.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 2),
            bellButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),      
        ])
    }
    
    @objc private func bellButtonTapped() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        bellButton.layer.add(animation, forKey: "shake")
    }
    
    private func fetchRandomCatImage() {
        let apiURL = URL(string: "https://api.thecatapi.com/v1/images/search")!
        
        URLSession.shared.dataTask(with: apiURL) { data, _, error in
            if let error = error {
                self.handleError(error, for: "fetching random cat image")
                return
            }
            
            if let data = data,
               let catData = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
               let catImageURLString = catData.first?["url"] as? String,
               let catImageURL = URL(string: catImageURLString)
            {
                self.loadCatImage(from: catImageURL)
            } else {
                self.handleInvalidDataResponse(for: "fetching random cat image")
            }
        }.resume()
    }
    
    private func loadCatImage(from url: URL) {
        imageView.getImageFromURL(url: url.absoluteString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                self.handleError(error, for: "loading cat image")
            }
        }
    }
    
    private func handleError(_ error: Error, for action: String) {
        print("Error \(action): \(error)")
        // Handle the error appropriately (show an alert, etc.)
    }
    
    private func handleInvalidDataResponse(for action: String) {
        print("Error \(action): Invalid data response")
        // Handle the error appropriately (show an alert, etc.)
    }
}
