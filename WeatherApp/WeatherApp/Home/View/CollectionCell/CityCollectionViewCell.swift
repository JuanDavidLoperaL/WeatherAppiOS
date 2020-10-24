//
//  CityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private UI Properties
    private let cityNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let cityLocationLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rightArrow")
        return imageView
    }()
    
    // MARK: - Private Properties
    private var viewModel: HomeViewModel?
    private var index: Int = 0
    
    // MARK: - Internal Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func draw(_ rect: CGRect) {
        setup()
    }
}

// MARK: - Protocol View Setup
extension CityCollectionViewCell: ViewConfiguration {
    func configureUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func addViews() {
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(cityLocationLabel)
        contentView.addSubview(rightArrowImageView)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            cityLocationLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 5),
            cityLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cityLocationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            cityLocationLabel.heightAnchor.constraint(equalToConstant: 40),
            
            rightArrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            rightArrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightArrowImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}

// MARK: - Internal Functions
extension CityCollectionViewCell {
    func setupCell(viewModel: HomeViewModel, currentIndexCell: Int) {
        self.viewModel = viewModel
        self.index = currentIndexCell
        self.viewModel?.cellIndex = self.index
        setupInfo()
    }
}

// MARK: - Private Function
extension CityCollectionViewCell {
    private func setupInfo() {
        cityNameLabel.text = viewModel?.cityName ?? StringsText.Home.notInfo
        cityLocationLabel.text = viewModel?.cityLocation ?? StringsText.Home.notInfo
    }
}
