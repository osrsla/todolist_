//
//  EditViewController.swift
//  todolist_
//
//  Created by SR on 2023/08/30.
//

import Foundation
import UIKit

class EditViewController: UIViewController {
    var task: Task?
    var selectedCategory: TaskCategory = .none
    
    let stackView = UIStackView()
    let categoryPicker = UIPickerView()
    let titleTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {}
}

extension EditViewController {
    private func setup() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(categoryPicker)
        stackView.addArrangedSubview(titleTextField)
     
        stackView.axis = .vertical
        stackView.spacing = 10
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryPicker.selectRow(TaskCategory.allCases.firstIndex(of: task?.category ?? .none) ?? 0, inComponent: 0, animated: false)
        titleTextField.text = task?.title
        
        titleTextField.placeholder = task?.title
        titleTextField.font = UIFont.preferredFont(forTextStyle: .title1)
      
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 10),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: -10),
            
            categoryPicker.topAnchor.constraint(equalToSystemSpacingBelow: stackView.topAnchor, multiplier: 20),
            categoryPicker.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            categoryPicker.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            categoryPicker.heightAnchor.constraint(equalToConstant: 150),
            
            titleTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 44)
        
        ])
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        saveButton.tintColor = .systemBlue
        
        navigationItem.rightBarButtonItems = [saveButton]
    }
    
    @objc private func saveButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }
                   
        var editedTask = Task(
            id: task?.id ?? 0,
            title: title,
            isCompleted: task?.isCompleted ?? false,
            category: selectedCategory
        )
           
        if let existingTaskIndex = TaskList.taskList().firstIndex(where: { $0.id == editedTask.id }) {
            TaskList.updateTaskList([editedTask])
        } else {
            editedTask.id = (TaskList.taskList().last?.id ?? -1) + 1
            TaskList.addTask(editedTask)
        }
                 
        navigationController?.popViewController(animated: true)
    }
}

extension EditViewController: UIPickerViewDelegate {}

extension EditViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return TaskCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TaskCategory.allCases[row].rawValue
    }
}
