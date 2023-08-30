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
    let categoryLabel = UILabel()
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        guard let task = task else {
            return
        }

        navigationItem.title = "Task Detail"

        categoryLabel.text = task.category.rawValue
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        categoryLabel.textColor = .systemGray
        categoryLabel.textAlignment = .center
        categoryLabel.adjustsFontForContentSizeCategory = true

        titleLabel.text = task.title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .systemGray6

        view.addSubview(categoryLabel)
        view.addSubview(titleLabel)

        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: titleLabel.topAnchor, multiplier: -1),
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            categoryLabel.heightAnchor.constraint(equalToConstant: 70),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),

        ])

        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))

        editButton.tintColor = .systemBlue
        deleteButton.tintColor = .systemBlue

        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }

    @objc private func editButtonTapped() {
        let editVC = EditViewController()
        navigationController?.pushViewController(editVC, animated: true)
    }

    @objc private func deleteButtonTapped() {
        let alertController = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            if let taskToDelete = self?.task {
                TaskList.deleteTask(task: taskToDelete)
                self?.navigationController?.popViewController(animated: true)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
