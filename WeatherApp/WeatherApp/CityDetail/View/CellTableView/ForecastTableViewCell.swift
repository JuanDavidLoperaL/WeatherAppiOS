//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    
    // MARK: - Private UI Properties
    private let dayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.text = "test"
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let windLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let rainChanceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - Private Properties
    private var viewModel: CityDetailViewModel?
    private var index: Int = 0
    
    // MARK: - Internal Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Protocol View Setup
extension ForecastTableViewCell: ViewConfiguration {
    func configureUI() {
        contentView.backgroundColor = AppSettingsManager.shared.currentColor.getColor()
    }
    
    func addViews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(rainChanceLabel)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dayLabel.heightAnchor.constraint(equalToConstant: 25),
            
            temperatureLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            
            humidityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            humidityLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15),
            humidityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            windLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 8),
            windLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15),
            windLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            rainChanceLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 8),
            rainChanceLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 15),
            rainChanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: - Internal Functions
extension ForecastTableViewCell {
    func setupCell(viewModel: CityDetailViewModel, indexCell: Int) {
        self.viewModel = viewModel
        self.index = indexCell
        self.viewModel?.currentCell = self.index
        dayLabel.text = viewModel.nextDays
        temperatureLabel.text = viewModel.nextDaysTemperature
        humidityLabel.text = viewModel.nextDaysHumidity
        windLabel.text = viewModel.nextDaysWind
        rainChanceLabel.text = viewModel.nextDaysRainChances
    }
}
