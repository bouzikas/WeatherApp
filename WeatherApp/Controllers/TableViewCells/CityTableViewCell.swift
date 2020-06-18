//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit

class CityTableViewCell: BaseTableViewCell<CityViewModel> {

    lazy var stateLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var cityLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .label
        label.backgroundColor = .clear
        return label
    }()
    
    override var item: CityViewModel! {
        didSet {
            stateLabel.text = item.country
            cityLabel.text = item.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CityTableViewCell {
    
    fileprivate func setupUI() {
        addSubviews()
        addConstraints()
    }

    fileprivate func addSubviews() {
        contentView.addSubview(stateLabel)
        contentView.addSubview(cityLabel)
    }
    
    fileprivate func addConstraints() {
        stateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 10).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
}
