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
   
    let circleButton = UIButton()
    
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
    
        contentView.addSubview(circleButton)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Task Name"
        
        circleButton.setImage(UIImage(systemName: "circle"), for: .normal)
        circleButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        circleButton.setTitleColor(UIColor.systemIndigo, for: .normal)
        circleButton.backgroundColor = .systemBackground
        circleButton.addTarget(self, action: #selector(circleButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
      
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            circleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleButton.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: -1),
            circleButton.widthAnchor.constraint(equalToConstant: 24),
            circleButton.heightAnchor.constraint(equalToConstant: 24)

        ])
    }
    
    @objc private func circleButtonTapped() {
        print("Circle button tapped")
        circleButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
       
    }
}
