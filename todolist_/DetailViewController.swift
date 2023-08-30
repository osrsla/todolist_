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

        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }

    @objc private func editButtonTapped() {
        let actionSheet = UIViewController()
        actionSheet.view.backgroundColor = .systemBackground

        let titleLabel = UILabel()
        titleLabel.text = "Edit Task"
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionSheet.view.addSubview(titleLabel)

        let textField = UITextField()
        textField.placeholder = "Edit Task Title"
        textField.text = task?.title
        textField.adjustsFontForContentSizeCategory = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        actionSheet.view.addSubview(textField)

        let categoryPicker = UIPickerView()
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        actionSheet.view.addSubview(categoryPicker)

        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        actionSheet.view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: actionSheet.view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: actionSheet.view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: actionSheet.view.trailingAnchor, constant: -20),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: actionSheet.view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: actionSheet.view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40),

            categoryPicker.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            categoryPicker.leadingAnchor.constraint(equalTo: actionSheet.view.leadingAnchor),
            categoryPicker.trailingAnchor.constraint(equalTo: actionSheet.view.trailingAnchor),
            categoryPicker.heightAnchor.constraint(equalToConstant: 200),

            saveButton.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: actionSheet.view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: actionSheet.view.bottomAnchor, constant: -20)
        ])

        actionSheet.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)

        present(actionSheet, animated: true, completion: nil)
    }

    @objc private func saveButtonTapped() {
      
    }

    @objc private func deleteButtonTapped() {
        let alertController = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in

            // (TaskList.removeTask 함수 구현 필요)

            self?.navigationController?.popViewController(animated: true)
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
