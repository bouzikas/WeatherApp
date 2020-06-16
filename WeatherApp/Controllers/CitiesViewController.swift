//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit

class CitiesViewController: UITableViewController {

    private var cityViewModels = [CityViewModel]()
    private var citiesViewModel = CitiesViewModel()
    
    // custom table data source (which derives from @BaseTableViewDataSource)
    fileprivate var citiesDataSource: CityTableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerTableViewCell()
        bind()
    }
    
    func configureUI() {
        self.title = "Cities"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(editTapped(sender:))
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped)
        )
        
        addExtraSeparatorOnTop()
    }
    
    func addExtraSeparatorOnTop() {
        let frame = CGRect(
            x: 20,
            y: 0,
            width: self.tableView.frame.size.width - 20,
            height: 1 / UIScreen.main.scale
        )
        let line = UIView(frame: frame)
        line.backgroundColor = self.tableView.separatorColor
        
        self.tableView.tableHeaderView = line
    }
    
    func registerTableViewCell() {
        
        // configuring our custom DataSource with our custom TableViewCell
        citiesDataSource = CityTableDataSource(
            cellIdentifier: CityTableViewCell.reuseIdentifier
        )
        
        citiesDataSource.delegate = self
        
        // removes extra empty rows from the bottom
        tableView.tableFooterView = UIView()
        
        tableView.tintColor = Constants.Colors.globalTint
        tableView.delegate = citiesDataSource
        tableView.dataSource = citiesDataSource
        tableView.register(
            CityTableViewCell.self,
            forCellReuseIdentifier: CityTableViewCell.reuseIdentifier
        )
    }
}

extension CitiesViewController {
    // MARK: - Retrieve binds
    fileprivate func bind() {
        bindCities()
    }
    
    fileprivate func bindCities() {
        citiesViewModel.fetchAll().bind { [weak self] viewModels in
            guard let self = self, let viewModels = viewModels else { return }
            guard self.citiesDataSource != nil else { return }
            
            self.citiesDataSource.items = viewModels
            self.tableView.reloadData()
            print("CITIES COUNT: \(viewModels.count)")
        }
    }
}

extension CitiesViewController {
    // MARK: - IBActions
    @objc func editTapped(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        sender.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    @objc func addTapped() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(
            withIdentifier: "SearchCityViewController"
        ) as! SearchCityViewController
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
}

extension CitiesViewController: CitySearchDelegate {
    // MARK: - CitySearchDelegate
    func citySelected(item: CityViewModel) {
        CacheDataManager.save(item, with: "\(item.id)")
        
        self.citiesDataSource.items.append(item)
        self.tableView.reloadData()
    }
}

extension CitiesViewController: BaseTableViewDelegate {
    func didSelectRow(item: Any) {
        guard let cityViewModel = item as? CityViewModel else { return }
        print("CITY: \(cityViewModel.name)")
        // open weather info for the selected city
    }
    
    func deletedRow(item: Any) {
        guard let cityViewModel = item as? CityViewModel else { return }
        CacheDataManager.delete("\(cityViewModel.id)")
        print("DELETE CITY: \(cityViewModel.name)")
        // open weather info for the selected city
    }
}
