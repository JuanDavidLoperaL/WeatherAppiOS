//
//  DelegateSettingsTableView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class DelegateSettingsTableView: NSObject, UITableViewDelegate {
    // MARK: - Internal Properties
    var viewModel: SettingsViewModel = SettingsViewModel()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let sectionTitleLabel: UILabel = UILabel()
        sectionTitleLabel.font = .boldSystemFont(ofSize: 15)
        sectionTitleLabel.textColor = .black
        sectionTitleLabel.textAlignment = .left
        view.addSubview(sectionTitleLabel)
        sectionTitleLabel.frame = CGRect(x: 10, y: 0, width: tableView.frame.width, height: 50)
        viewModel.currentSection = section
        sectionTitleLabel.text = viewModel.sectionTitle
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.changeSelection(for: indexPath)
    }
}
