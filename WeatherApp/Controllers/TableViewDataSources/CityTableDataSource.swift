//
//  CityTableDataSource.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit

class CityTableDataSource: BaseTableViewDataSource<BaseTableViewCell<CityViewModel>, CityViewModel> {
    
    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard items.count != 0 else {
            tableView.setEmptyView(
                title: "No Cities",
                message: "Click + to add cities and get weather information"
            )
            return 0
        }
        tableView.restore()
        
        return items.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .default
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! CityTableViewCell
        
        cell.item = items[indexPath.row]
        cell.tag = indexPath.row
        
        return cell
    }
}
