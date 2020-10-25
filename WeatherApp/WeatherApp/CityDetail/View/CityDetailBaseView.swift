//
//  CityDetailBaseView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class CityDetailBaseView: UIView {
    
    // MARK: - Private UI Properties
    private let dayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let todayForecastStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private let nextFourDaysLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = StringsText.CityDetail.nextDays
        return label
    }()
    
    private let nextDaysTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: StringsText.CityDetail.forecastCellIdentifier)
        return tableView
    }()
    
    // MARK: - Private Properties
    private var datasourceTableView: DatasourceNextDaysTableView = DatasourceNextDaysTableView()
    private var delegateTableView: DelegateNextDaysTableView = DelegateNextDaysTableView()
    
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
extension CityDetailBaseView: ViewConfiguration {
    func configureUI() {
        self.backgroundColor = AppSettingsManager.shared.currentColor.getColor()
    }
    
    func addViews() {
        addSubview(dayLabel)
        addSubview(temperatureLabel)
        addSubview(todayForecastStackView)
        addSubview(nextFourDaysLabel)
        addSubview(nextDaysTableView)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            dayLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            dayLabel.heightAnchor.constraint(equalToConstant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            
            todayForecastStackView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            todayForecastStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            todayForecastStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            todayForecastStackView.heightAnchor.constraint(equalToConstant: 70),
            
            nextFourDaysLabel.topAnchor.constraint(equalTo: todayForecastStackView.bottomAnchor, constant: 15),
            nextFourDaysLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            nextDaysTableView.topAnchor.constraint(equalTo: nextFourDaysLabel.bottomAnchor, constant: 10),
            nextDaysTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nextDaysTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nextDaysTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Internal Functions
extension CityDetailBaseView {
    func setupInitialInformation(with day: String,
                                 temperature: String,
                                 principalInformation: [(headerName: String, value: String)]) {
        dayLabel.text = day
        temperatureLabel.text = temperature
        setupTodayForecastStackView(principalInformation: principalInformation)
    }
    
    func setViewModelInTableView(viewModel: CityDetailViewModel) {
        datasourceTableView.viewModel = viewModel
        delegateTableView.viewModel = viewModel
        nextDaysTableView.dataSource = datasourceTableView
        nextDaysTableView.delegate = delegateTableView
        nextDaysTableView.reloadData()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [self] in
            nextDaysTableView.reloadData()
        }
    }
}

// MARK: - Private Functions
extension CityDetailBaseView {
    private func setupTodayForecastStackView(principalInformation: [(headerName: String, value: String)]) {
        principalInformation.forEach { information in
            let view: UIView = createForecastCardView(with: information.headerName,
                                                      weatherInformation: information.value)
            view.backgroundColor = .white
        }
    }
    
    private func createForecastCardView(with title: String, weatherInformation: String) -> UIView {
        let titleLabel: UILabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.text = title
        let informationLabel: UILabel = UILabel()
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.textColor = .black
        informationLabel.font = .systemFont(ofSize: 15)
        informationLabel.text = weatherInformation
        let viewCard: UIView = UIView()
        viewCard.translatesAutoresizingMaskIntoConstraints = false
        todayForecastStackView.addArrangedSubview(viewCard)
        viewCard.addSubview(titleLabel)
        viewCard.addSubview(informationLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewCard.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: viewCard.centerXAnchor),
            
            informationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            informationLabel.centerXAnchor.constraint(equalTo: viewCard.centerXAnchor)
        ])
        return viewCard
    }
}
