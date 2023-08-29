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

    let tasks = ["work1", "work2", "work3", "work4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup() // 설정
        setupHeaderView() // 오토레이아웃
    }
}

extension TaskViewController {
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseID)
        tableView.rowHeight = TaskCell.rowHeight
        tableView.tableFooterView = UIView()

        view = tableView
    }

    private func setupHeaderView() {
        let header = TaskHeaderView()

        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size

        tableView.tableHeaderView = header
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseID, for: indexPath) as! TaskCell
        return cell
//        let cell = UITableViewCell()
//        cell.textLabel?.text = tasks[indexPath.row]
//        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}
