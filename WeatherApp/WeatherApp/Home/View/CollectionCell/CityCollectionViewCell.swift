//
//  CityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private UI Properties
    private let containerStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let containerCityInfoView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let deleteItemButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(StringsText.Home.deleteItemInCitiesCollectionView, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.backgroundColor = .red
        return button
    }()
    
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
        deleteItemButton.addTarget(self, action: #selector(deleteItem), for: .touchDown)
    }
}

// MARK: - Protocol View Setup
extension CityCollectionViewCell: ViewConfiguration {
    func configureUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func addViews() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(deleteItemButton)
        containerStackView.addArrangedSubview(containerCityInfoView)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(cityLocationLabel)
        contentView.addSubview(rightArrowImageView)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            deleteItemButton.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 8),
            deleteItemButton.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 8),
            deleteItemButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            deleteItemButton.widthAnchor.constraint(equalToConstant: 40),
            
            cityNameLabel.topAnchor.constraint(equalTo: containerCityInfoView.topAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: containerCityInfoView.leadingAnchor, constant: 8),
            cityNameLabel.trailingAnchor.constraint(equalTo: containerCityInfoView.trailingAnchor, constant: -30),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            cityLocationLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 5),
            cityLocationLabel.leadingAnchor.constraint(equalTo: containerCityInfoView.leadingAnchor, constant: 8),
            cityLocationLabel.trailingAnchor.constraint(equalTo: containerCityInfoView.trailingAnchor, constant: -30),
            cityLocationLabel.heightAnchor.constraint(equalToConstant: 40),
            
            rightArrowImageView.topAnchor.constraint(equalTo: containerCityInfoView.topAnchor,constant: 8),
            rightArrowImageView.trailingAnchor.constraint(equalTo: containerCityInfoView.trailingAnchor),
            rightArrowImageView.bottomAnchor.constraint(equalTo: containerCityInfoView.bottomAnchor),
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
        deleteItemButton.isHidden = viewModel?.isEditing ?? true
        cityNameLabel.text = viewModel?.cityName ?? StringsText.Home.notInfo
        cityLocationLabel.text = viewModel?.cityLocation ?? StringsText.Home.notInfo
    }
    
    @objc
    private func deleteItem() {
        viewModel?.deleteItem(at: index)
    }
}
