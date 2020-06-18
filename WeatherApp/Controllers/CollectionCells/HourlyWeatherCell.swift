//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 18/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit
import SwiftSVG

class HourlyWeatherCell : UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconView: SVGView!
    @IBOutlet weak var tempLabel: UILabel!
    
    var item: WeatherInfoHourlyViewModel! {
        didSet {
            self.hourLabel.text = item.time
            self.tempLabel.text = item.tempC
            
            // SwiftSVG provides SVGView but its poor and you cant
            // manipulate after it's been created so we have to manually
            // add the view with svg into it upon the creation. This leads us
            // to the point that we have to erase the subviews before add the new icons.
            for view in self.iconView.subviews {
                view.removeFromSuperview()
            }
            
            let weatherView = UIView(SVGNamed: item.icon) { (svgLayer) in
                let rect = CGRect(x: 0, y: 0, width: self.iconView.bounds.width, height: self.iconView.bounds.height)
                svgLayer.fillColor = Constants.Colors.globalTint?.cgColor
                svgLayer.resizeToFit(rect)
            }
            self.iconView.addSubview(weatherView)
        }
    }
}
