//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 17/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit
import SwiftSVG

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherWrapperView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    public var cityViewModel: CityViewModel!
    
    fileprivate var listOfDayWeatherInfo = [WeatherInfoViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        bind()
    }
    
    fileprivate func loadData() {
        cityLabel.text = cityViewModel.name
    }
    
    fileprivate func bind() {
        _ = cityViewModel.fetchWeatherInfo().bind { [weak self] (weatherInfoViewModel) in
            guard let self = self, let weatherInfo = weatherInfoViewModel else { return }
            self.currentTempLabel.text = weatherInfo.current.tempC
            self.conditionLabel.text = weatherInfo.current.desc
            
            let weatherView = UIView(SVGNamed: weatherInfo.current.icon) { (svgLayer) in
                let rect = CGRect(
                    x: 0,
                    y: 0,
                    width: self.weatherWrapperView.bounds.width,
                    height: self.weatherWrapperView.bounds.height
                )
                svgLayer.fillColor = Constants.Colors.globalTint?.cgColor
                svgLayer.resizeToFit(rect)
            }
            self.weatherWrapperView.addSubview(weatherView)
            
            self.listOfDayWeatherInfo = weatherInfo.weatherInfos
            self.tableView.reloadData()
        }
        
        cityViewModel.error.bind { [weak self] error in
            guard let self = self, error != nil else { return }
            
            let alert = UIAlertController(
                title: "Alert",
                message: "There are no weather information for this city",
                preferredStyle: UIAlertController.Style.alert
            )
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: UIAlertAction.Style.default,
                    handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }
                )
            )

            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return listOfDayWeatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listOfDayWeatherInfo[section].date
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherInfoTableCell") as! DayWeatherInfoTableCell
        cell.items = listOfDayWeatherInfo[indexPath.row].hourly
        return cell
    }
}
