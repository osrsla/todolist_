//
//  TaskHeaderView.swift
//  todolist_
//
//  Created by SR on 2023/08/29.
//

import UIKit

class TaskHeaderView: UIView {
    let contentView = UIView()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 24)
    } // 높이 필수!
    
    private func setup() {
        addSubview(contentView)
     
        contentView.backgroundColor = .systemGray4
       
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            
        ])
    }
}
