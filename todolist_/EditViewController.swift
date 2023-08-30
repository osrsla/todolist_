//
//  EditViewController.swift
//  todolist_
//
//  Created by SR on 2023/08/30.
//

import UIKit

class EditViewController: UIViewController {
    let data = [".none", ".work", ".life"]
    
    let taskLable = UILabel()
    var titleTextField = UITextField()
    var selectCategoryButton = UIButton(type: .system)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
    }
}

extension EditViewController {
    private func setup() {
        
        navigationItem.title = "Edit"
        
        
        taskLable.text = "task"
        taskLable.font = UIFont.systemFont(ofSize: 16)
        taskLable.textAlignment = .center
        taskLable.numberOfLines = 0
        taskLable.textColor = UIColor.systemGray
        
        titleTextField.placeholder = "original text"
        titleTextField.textAlignment = .center
       
        titleTextField.borderStyle = .roundedRect
   
        selectCategoryButton.setTitle("Select Category", for: .normal)
        selectCategoryButton.backgroundColor = .systemBlue
        selectCategoryButton.tintColor = .systemBackground
        selectCategoryButton.addTarget(self, action: #selector(selectCategoryButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(taskLable)
        view.addSubview(titleTextField)

        view.addSubview(selectCategoryButton)

        taskLable.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        selectCategoryButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            taskLable.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20),
            taskLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskLable.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            taskLable.heightAnchor.constraint(equalToConstant: 48),
            
            titleTextField.topAnchor.constraint(equalToSystemSpacingBelow: taskLable.bottomAnchor, multiplier: 3),
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleTextField.heightAnchor.constraint(equalToConstant: 48),
            
            selectCategoryButton.topAnchor.constraint(equalToSystemSpacingBelow: titleTextField.bottomAnchor, multiplier: 3),
            selectCategoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectCategoryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        
            selectCategoryButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    @objc private func selectCategoryButtonTapped() {
        let alertController = UIAlertController(title: "Select a Category", message: nil, preferredStyle: .actionSheet)
        
        for category in data {
            let action = UIAlertAction(title: category, style: .default) { _ in
                self.handleSelectedCategory(category)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func handleSelectedCategory(_ category: String) {
        print("Selected category: \(category)")
    }
}
