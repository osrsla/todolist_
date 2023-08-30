//
//  URLManager.swift
//  todolist_
//
//  Created by SR on 2023/08/30.
//

import Foundation

//class URLManager {
//    static let shared = URLManager()
//    let url = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!
//
//    private init() { }
//    
//    func getJsonData(path: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        let task = URLSession.shared.dataTask(with: url.appending(path: path))
//{ data, response, error in
//            if let error {
//                print("Error: \(error.localizedDescription)")
//                completion(.failure(NetworkError.unknown(error.localizedDescription)))
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                print("Error: invalid response")
//                completion(.failure(NetworkError.invalidResponse))
//                return
//            }
//            
//            guard let data = data else {
//                print("Error: no data")
//                completion(.failure(NetworkError.emptyResponse))
//                return
//            }
//            completion(.success(data))
//        }
//        task.resume()
//    }
//}
