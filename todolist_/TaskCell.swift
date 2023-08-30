//
//  TaskCell.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
    let titleLabel = UILabel()
    let squareButton = UIButton()
    
    var task: Task? {
        didSet {
            updateUI()
        }
    }
    
    static let reuseID = "Cell"
    static let rowHeight: CGFloat = 100
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskCell {
    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(squareButton)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = task?.title
        
        squareButton.setImage(UIImage(systemName: "square"), for: .normal)
        squareButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        squareButton.backgroundColor = .systemBackground
        squareButton.addTarget(self, action: #selector(squareButtonTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        squareButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            squareButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            squareButton.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: -10),
            squareButton.widthAnchor.constraint(equalToConstant: 48),
            squareButton.heightAnchor.constraint(equalToConstant: 48)

        ])
    }

    private func updateUI() {
        titleLabel.text = task?.title
         
        if task?.isCompleted == true {
            squareButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
        } else {
            squareButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @objc private func squareButtonTapped(_ sender: Any) {
        guard var task = task else { return }
        
        let newCompletedValue = !task.isCompleted
        task.isCompleted = newCompletedValue
        
        TaskList.completeTask(task: task, isCompleted: newCompletedValue)
        
        updateUI()
        
        NotificationCenter.default.post(name: Notification.Name("TaskCompletedStatusChanged"), object: nil)
    }
}
