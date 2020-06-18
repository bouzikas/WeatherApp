//
//  DayWeatherInfoTableCell.swift
//  WeatherApp
//
//  Created by Dimitris Bouzikas on 18/06/2020.
//  Copyright © 2020 Bouzikas. All rights reserved.
//

import UIKit


class DayWeatherInfoTableCell : UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items = [WeatherInfoHourlyViewModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
}

extension DayWeatherInfoTableCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let total = items.count
        print("Total: \(total)")
        return total
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HourlyWeatherCell",
            for: indexPath
        ) as! HourlyWeatherCell

        cell.item = items[indexPath.row]
        return cell
    }
}

extension DayWeatherInfoTableCell : UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemsPerRow: CGFloat = 6.2
        let hardCodedPadding: CGFloat = 5.0
        
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
