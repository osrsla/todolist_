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
    var completionSwitch = UISwitch()

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
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TaskCell {
    private func setup() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = task?.title

        completionSwitch.isOn = false
        completionSwitch.addTarget(self, action: #selector(completionSwitchValueChanged), for: .valueChanged)
    }

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(completionSwitch)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        completionSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),

            completionSwitch.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            completionSwitch.leadingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 15),

            completionSwitch.widthAnchor.constraint(equalToConstant: 24),
            completionSwitch.heightAnchor.constraint(equalToConstant: 24)

        ])
    }

    private func updateUI() {
        titleLabel.text = task?.title
        completionSwitch.isOn = task?.isCompleted ?? false
    }

    @objc private func completionSwitchValueChanged(_ sender: UISwitch) {
        guard let task = task else { return }
        if sender.isOn {
            TaskList.completeTask(task: task, isCompleted: true)

        } else {
            TaskList.completeTask(task: task, isCompleted: false)
        }
    }
}
