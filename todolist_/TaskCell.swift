//
//  TaskCell.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import Foundation
import UIKit

protocol TaskCellDelegate: AnyObject {
    func taskCell(_ cell: TaskCell, didToggleCompletionFor task: Task, newCompletedValue: Bool)
}

class TaskCell: UITableViewCell {
    weak var delegate: TaskCellDelegate?

    let titleLabel = UILabel()
    let completionSwitch = UISwitch()

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
        completionSwitch.addTarget(self, action: #selector(completionSwitchValueChanged), for: .valueChanged)
        contentView.addSubview(titleLabel)
        contentView.addSubview(completionSwitch)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = task?.title

        completionSwitch.addTarget(self, action: #selector(completionSwitchValueChanged), for: .valueChanged)
    }

    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        completionSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),

            completionSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            completionSwitch.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: -20),
            completionSwitch.widthAnchor.constraint(equalToConstant: 48),
            completionSwitch.heightAnchor.constraint(equalToConstant: 48)

        ])
    }

    private func updateUI() {
        titleLabel.text = task?.title
        completionSwitch.isOn = task?.isCompleted ?? false
    }

    @objc private func completionSwitchValueChanged(_ sender: UISwitch) {
        guard let task = task else { return }

        let newCompletedValue = sender.isOn

        delegate?.taskCell(self, didToggleCompletionFor: task, newCompletedValue: newCompletedValue)
    }
}
