//
//  BaseTableViewCell.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit

class BaseTableViewCell<ModelView>: UITableViewCell {
    var item: ModelView!
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
