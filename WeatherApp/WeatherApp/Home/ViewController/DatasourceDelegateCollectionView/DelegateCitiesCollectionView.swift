//
//  DelegateCitiesCollectionView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class DelegateCitiesCollectionView: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Internal Properties
    var viewModel: HomeViewModel = HomeViewModel()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.itemSelected = indexPath.item
    }
}
