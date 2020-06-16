//
//  UITableView+Extension.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let frame = CGRect(
            x: self.center.x,
            y: self.center.y,
            width: self.bounds.size.width,
            height: self.bounds.size.height
        )
        let emptyView = UIView(frame: frame)
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = self.tintColor
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        messageLabel.textColor = self.tintColor
        messageLabel.font = .systemFont(ofSize: 14)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        messageLabel.widthAnchor.constraint(equalToConstant: 165).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
