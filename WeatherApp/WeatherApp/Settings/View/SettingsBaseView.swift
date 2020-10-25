//
//  SettingsBaseView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class SettingsBaseView: UIView {
    
    // MARK: - Private UI Properties
    private let settingsTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: StringsText.Settings.settingsCellIdentifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    // MARK: - Private Properties
    private let datasourceTableView: DatasourceSettingsTableView = DatasourceSettingsTableView()
    private let delegateTableView: DelegateSettingsTableView = DelegateSettingsTableView()
    
    // MARK: - Internal Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Protocol View Setup
extension SettingsBaseView: ViewConfiguration {
    func configureUI() {
        self.backgroundColor = AppSettingsManager.shared.currentColor.getColor()
    }
    
    func addViews() {
        addSubview(settingsTableView)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Internal Functions
extension SettingsBaseView {
    func setViewModelInTableView(viewModel: SettingsViewModel) {
        datasourceTableView.viewModel = viewModel
        delegateTableView.viewModel = viewModel
        settingsTableView.delegate = delegateTableView
        settingsTableView.dataSource = datasourceTableView
        settingsTableView.reloadData()
    }
    
    func reloadTableView() {
        settingsTableView.reloadData()
    }
}
