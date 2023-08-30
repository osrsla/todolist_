//
//  Tasks.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import Foundation

struct Task: Codable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var category: TaskCategory
}

enum TaskCategory: String, CaseIterable, Codable {
    case none
    case work
    case life

    func toIndex() -> Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }

    static func categorv(from index: Int) -> Self? {
        Self.allCases.indices ~= index ? Self.allCases[index] : nil
    }
}
