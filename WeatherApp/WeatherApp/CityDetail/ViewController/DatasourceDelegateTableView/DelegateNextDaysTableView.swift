//
//  DelegateNextDaysTableView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import UIKit

final class DelegateNextDaysTableView: NSObject, UITableViewDelegate {
    
    // MARK: - Internal Properties
    var viewModel: CityDetailViewModel?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
