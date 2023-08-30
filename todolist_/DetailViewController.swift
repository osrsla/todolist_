//
//  DetailViewController.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        guard let task = task else {
            return
        }

        let titleLabel = UILabel()
        titleLabel.text = task.title
        // titleLabel을 추가하고 레이아웃을 설정합니다.

        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))

        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }

    @objc private func editButtonTapped() {
        // feat: 편집 버튼이 눌렸을 때의 동작을 구현, 모달로 편집 화면을 표시
    }

    @objc private func deleteButtonTapped() {
        // feat: 삭제 버튼이 눌렸을 때의 동작을 구현,해당 할 일을 삭제하고 이전 화면으로 돌아감
    }
}
