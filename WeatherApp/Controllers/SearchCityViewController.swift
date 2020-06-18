//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 16/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit
import SearchTextField

protocol CitySearchDelegate: class {
    func citySelected(item: CityViewModel)
}

class SearchCityViewController: UIViewController {
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var searchIcon: UIImageView!
    
    fileprivate let minCharactersNumberToStartFiltering = 3
    fileprivate var cityViewModels = [CityViewModel]()
    
    weak var delegate: CitySearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHandlers()
        prepareForDarkMode()
    }
    
    // MARK: - Helper functions
    
    func prepareForDarkMode() {
        // SearchTextField lib doesnt handle dark them automatically
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                searchTextField.theme = .darkTheme()
            } else {
                searchTextField.theme = .lightTheme()
            }
        } else {
            searchTextField.theme = .lightTheme()
        }
    }
    
    fileprivate func setupHandlers() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
        searchTextField.minCharactersNumberToStartFiltering = minCharactersNumberToStartFiltering
        searchTextField.tableBottomMargin = 5.0
        searchTextField.theme.cellHeight = 70
        searchTextField.forceNoFiltering = true
        
        /**
         * Update data source when the user stops typing.
         * It's useful when you want to retrieve results from a remote server while typing
         * (but only when the user stops doing it)
         */
        searchTextField.userStoppedTypingHandler = {
            guard let searchTerm = self.searchTextField.text,
                searchTerm.count > self.minCharactersNumberToStartFiltering else {
                return
            }
            
            // Show the loading indicator
            self.searchTextField.showLoadingIndicator()
            
            // retrieve the cities
            CitiesViewModel.shared.search(withTerm: searchTerm) { [weak self] (error, viewModels) in
                guard error == nil, viewModels != nil else { return }
                self?.searchTextField.filterItems(viewModels!.map {
                    return SearchTextFieldItem(title: $0.name, subtitle: $0.country)
                })
                // replace
                self?.cityViewModels = viewModels!
                self?.searchTextField.stopLoadingIndicator()
            }
        }
        
        // Handle item selection - Default behaviour: item title set to the text field
        searchTextField.itemSelectionHandler = { [weak self] filteredResults, itemPosition in
            if let item = self?.cityViewModels[itemPosition] {
                self?.delegate?.citySelected(item: item)
            }
            
            self?.searchTextField.hideResultsList()
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

extension SearchCityViewController: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate
    
    @objc func textFieldDidChange() {
        if let term = searchTextField.text, term.count == 0 {
            searchIcon.isHidden = false
        } else {
            searchIcon.isHidden = true
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
