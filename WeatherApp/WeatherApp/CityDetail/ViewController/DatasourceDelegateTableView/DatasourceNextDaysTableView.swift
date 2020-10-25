//
//  DatasourceNextDaysTableView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import UIKit

final class DatasourceNextDaysTableView: NSObject, UITableViewDataSource {
    
    // MARK: - Internal Properties
    var viewModel: CityDetailViewModel?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSectionInTableView ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowInTableView ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ForecastTableViewCell = tableView.dequeueReusableCell(withIdentifier: StringsText.CityDetail.forecastCellIdentifier, for: indexPath) as? ForecastTableViewCell, let viewModel = viewModel else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: viewModel, indexCell: indexPath.row)
        return cell
    }
}
