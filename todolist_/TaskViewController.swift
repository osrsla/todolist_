//
//  TaskViewController.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import Foundation
import UIKit

class TaskViewController: UIViewController {
    let tableView = UITableView()
//    let headerView = UIView(frame: CGRect(origin: <#T##CGPoint#>, size: <#T##CGSize#>))

    let tasks = ["work1", "work2", "work3", "work4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup() // 설정
        setupLayout() // 오토레이아웃
    }
}

extension TaskViewController {
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self

        view = tableView
    }

    private func setupLayout() {}
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}
