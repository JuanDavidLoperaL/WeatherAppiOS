//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

protocol CityDetailViewControllerDelegate: AnyObject {
    func setupTodayForecast()
    func reloadTableView()
    func errorInRequest()
}

final class CityDetailViewController: UIViewController {
    
    // MARK: - Private UI Properties
    let baseView: CityDetailBaseView = CityDetailBaseView()
    
    // MARK: - Private Properties
    private let viewModel: CityDetailViewModel
    
    // MARK: - Internal Init
    init(viewModel: CityDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        viewModel.delegate = self
        viewModel.getWeather()
        self.title = "\(viewModel.cityName) Details"
        baseView.setViewModelInTableView(viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension CityDetailViewController: CityDetailViewControllerDelegate {
    func setupTodayForecast() {
        DispatchQueue.main.async { [self] in
            baseView.setupInitialInformation(with: StringsText.CityDetail.todayForecast,
                                             temperature: viewModel.todayTemperature,
                                             principalInformation: viewModel.todayPrincipalInformation)
        }
    }
    
    func reloadTableView() {
        baseView.reloadTableView()
    }
    
    func errorInRequest() {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: "Error", message: "We got a error trying fetch the city data, check if you internet connection is ok and try again", preferredStyle: .alert)
            let alertOk: UIAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(alertOk)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
