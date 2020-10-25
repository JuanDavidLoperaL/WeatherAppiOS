//
//  DatasourceCitiesCollectionView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class DatasourceCitiesCollectionView: NSObject, UICollectionViewDataSource {
    
    // MARK: - Internal Properties
    var viewModel: HomeViewModel = HomeViewModel()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getSetionsAmountInCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemsAmountInCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CityCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: StringsText.Home.cityCellIdentifier, for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(viewModel: viewModel, currentIndexCell: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
}
