//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func reloadTableView()
}

final class SettingsViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private let baseView: SettingsBaseView = SettingsBaseView()
    
    // MARK: - Private Properties
    private let viewModel: SettingsViewModel
    
    // MARK: - Internal Init
    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringsText.Settings.navigationBarTitle
        baseView.setViewModelInTableView(viewModel: viewModel)
        viewModel.createSections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Protocol SettingsViewControllerDelegate
extension SettingsViewController: SettingsViewControllerDelegate {
    func reloadTableView() {
        baseView.reloadTableView()
    }
}
