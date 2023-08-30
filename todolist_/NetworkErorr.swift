//
//  NetworkErorr.swift
//  todolist_
//
//  Created by SR on 2023/08/30.
//

import Foundation

enum NetworkError: Error {
    case emptyResponse
    case invalidResponse
    case unknown(String)
}
