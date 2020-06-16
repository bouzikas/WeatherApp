//
//  BaseTableViewDataSource.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit

protocol BaseTableViewDelegate: class {
    func didSelectRow(item: Any)
    func deletedRow(item: Any)
}

class BaseTableViewDataSource<T: BaseTableViewCell<ModelView>, ModelView>: NSObject, UITableViewDataSource, UITableViewDelegate {

    private var cellIdentifier: String?
    
    public weak var delegate: BaseTableViewDelegate?
    
    public var items = [ModelView]()
    
    init(cellIdentifier: String) {
        super.init()
        
        self.cellIdentifier = cellIdentifier
    }
    
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier!,
            for: indexPath
        ) as! BaseTableViewCell<ModelView>
        
        cell.item = items[indexPath.row]
        
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        cell.contentView.backgroundColor = .white
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(item: items[indexPath.row])
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            delegate?.deletedRow(item: items[indexPath.row])
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
