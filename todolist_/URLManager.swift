//
//  URLManager.swift
//  todolist_
//
//  Created by SR on 2023/08/30.
//
import UIKit

extension UIImageView {
    func getImageFromURL(url: String, completion: ((Result<Data, Error>) -> ())? = nil) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion?(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ... 299).contains(httpResponse.statusCode)
            else {
                print("Error: invalid response")
                completion?(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("Error: no data")
                completion?(.failure(NetworkError.emptyResponse))
                return
            }
            
            completion?(.success(data))
        }
        task.resume()
    }
}
