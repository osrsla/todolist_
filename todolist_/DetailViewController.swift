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
    let squareButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        guard let task = task else {
            return
        }

        categoryLabel.text = task.category.rawValue
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        categoryLabel.textColor = .systemGray
        categoryLabel.textAlignment = .center
        categoryLabel.adjustsFontForContentSizeCategory = true

        titleLabel.text = task.title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true

        view.addSubview(categoryLabel)
        view.addSubview(titleLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        categoryLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: titleLabel.topAnchor, multiplier: -1).isActive = true
        categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true

        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))

        editButton.tintColor = .systemBlue
        deleteButton.tintColor = .systemBlue

        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }

    @objc private func editButtonTapped() {
        let editVC = EditViewController()
        editVC.task = task
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

extension DetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TaskCategory.allCases.count
    }
}

extension DetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TaskCategory.allCases[row].rawValue
    }
}
