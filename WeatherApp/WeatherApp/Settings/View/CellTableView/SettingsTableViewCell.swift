//
//  SettingsTableViewCell.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Private UI Properties
    private let itemTextLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let isSelectedImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "check")
        return imageView
    }()
    
    // MARK: - Private Properties
    private var index: Int = 0
    private var section: Int = 0
    private var viewModel: SettingsViewModel = SettingsViewModel()
    
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
extension SettingsTableViewCell: ViewConfiguration {
    func configureUI() {
        contentView.backgroundColor = AppSettingsManager.shared.currentColor.getColor()
    }
    
    func addViews() {
        contentView.addSubview(itemTextLabel)
        contentView.addSubview(isSelectedImageView)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            isSelectedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            isSelectedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            isSelectedImageView.heightAnchor.constraint(equalToConstant: 20),
            isSelectedImageView.widthAnchor.constraint(equalToConstant: 20),
            
            itemTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemTextLabel.trailingAnchor.constraint(equalTo: isSelectedImageView.leadingAnchor, constant: 10)
        ])
    }
}

// MARK: - Internal Functions
extension SettingsTableViewCell {
    func setupCell(viewModel: SettingsViewModel, indexCell: Int, indexSection: Int) {
        self.index = indexCell
        self.viewModel = viewModel
        self.section = indexSection
        self.viewModel.currentSection = indexSection
        self.viewModel.cellIndex = indexCell
        itemTextLabel.text = viewModel.itemTitle
        isSelectedImageView.isHidden = self.viewModel.shouldHideCheckIcon
    }
}
