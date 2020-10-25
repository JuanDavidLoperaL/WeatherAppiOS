//
//  DatasourceSettingsTableView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class DatasourceSettingsTableView: NSObject, UITableViewDataSource {
    // MARK: - Internal Properties
    var viewModel: SettingsViewModel = SettingsViewModel()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSectionInTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numerOfRowInTableView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: StringsText.Settings.settingsCellIdentifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(viewModel: viewModel, indexCell: indexPath.row, indexSection: indexPath.section)
        return cell
    }
}
