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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        setupHeaderView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension TaskViewController {
    private func setup() {
        navigationItem.title = "Task List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseID)
        tableView.rowHeight = TaskCell.rowHeight
        tableView.tableFooterView = UIView()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupHeaderView() {
        let header = TaskHeaderView()

        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size

        tableView.tableHeaderView = header
    }

    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "New Task🏃‍♀️🏃‍♂️💨", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Add New Task!"
        }

        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self, let title = alertController.textFields?.first?.text, !title.isEmpty else {
                return
            }

            let defaultCategory = TaskCategory.none
            let newItem = Task(id: (TaskList.taskList().last?.id ?? -1) + 1, title: title, isCompleted: false, category: defaultCategory)
            TaskList.addTask(newItem)

            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let category = TaskCategory.allCases[indexPath.section]
        let tasksForCategory = TaskList.filterByCategory(category: category)
        let selectedTask = tasksForCategory[indexPath.row]

        let detailVC = DetailViewController()
        detailVC.task = selectedTask
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseID, for: indexPath) as! TaskCell

        let category = TaskCategory.allCases[indexPath.section]
        let tasksForCategory = TaskList.filterByCategory(category: category)
        let task = tasksForCategory[indexPath.row]

        cell.delegate = self

        cell.textLabel?.text = task.title
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TaskCategory.none.toIndex() {
            return TaskList.filterByCategory(category: .none).count
        } else if section == TaskCategory.work.toIndex() {
            return TaskList.filterByCategory(category: .work).count
        } else if section == TaskCategory.life.toIndex() {
            return TaskList.filterByCategory(category: .life).count
        } else {
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return TaskCategory.allCases.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard TaskList.taskList().count != 0 else { return nil }
        guard let category = TaskCategory.categorv(from: section) else { return nil }
        let titelHeader = category.rawValue
        return TaskList.filterByCategory(category: category).isEmpty ? nil : titelHeader
    }
}

extension TaskViewController: TaskCellDelegate {
    func taskCell(_ cell: TaskCell, didToggleCompletionFor task: Task, newCompletedValue: Bool) {
        var updatedTask = task
        updatedTask.isCompleted = newCompletedValue

        TaskList.completeTask(task: updatedTask, isCompleted: newCompletedValue)

        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
