//
//  HomeBaseView.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//
import MapKit
import UIKit

protocol HomeBaseViewDelegate: AnyObject {
    func userTouchInMap(tap: CLLocationCoordinate2D)
}

final class HomeBaseView: UIView {
    
    // MARK: - Private UI Properties
    private let mainMap: MKMapView = {
        let map: MKMapView = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let citiesContainer: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let filterTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.placeholder = StringsText.Home.filterText
        return textField
    }()
    
    private let citiesListCollectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: StringsText.Home.cityCellIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Private Properties
    private let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    private var datasourceCitiesCollectionView: DatasourceCitiesCollectionView = DatasourceCitiesCollectionView()
    private var delegateCitiesCollectionView: DelegateCitiesCollectionView = DelegateCitiesCollectionView()
    
    // MARK: - Delegate
    weak var delegate: HomeBaseViewDelegate?
    
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
extension HomeBaseView: ViewConfiguration {
    func configureUI() {
        self.backgroundColor = .yellow
        setupGestureRecognizer()
    }
    
    func addViews() {
        self.addSubview(mainMap)
        self.addSubview(citiesContainer)
        citiesContainer.addSubview(filterTextField)
        citiesContainer.addSubview(citiesListCollectionView)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            mainMap.topAnchor.constraint(equalTo: self.topAnchor),
            mainMap.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainMap.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainMap.heightAnchor.constraint(equalToConstant: self.frame.height * 0.60),
            
            citiesContainer.topAnchor.constraint(equalTo: mainMap.bottomAnchor),
            citiesContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            citiesContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            citiesContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            filterTextField.topAnchor.constraint(equalTo: citiesContainer.topAnchor, constant: 8),
            filterTextField.leadingAnchor.constraint(equalTo: citiesContainer.leadingAnchor, constant: 16),
            filterTextField.trailingAnchor.constraint(equalTo: citiesContainer.trailingAnchor, constant: -16),
            filterTextField.heightAnchor.constraint(equalToConstant: 35),
            
            citiesListCollectionView.topAnchor.constraint(equalTo: filterTextField.bottomAnchor, constant: 8),
            citiesListCollectionView.leadingAnchor.constraint(equalTo: citiesContainer.leadingAnchor, constant: 16),
            citiesListCollectionView.trailingAnchor.constraint(equalTo: citiesContainer.trailingAnchor, constant: -16),
            citiesListCollectionView.bottomAnchor.constraint(equalTo: citiesContainer.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Private Functions
extension HomeBaseView: UIGestureRecognizerDelegate {
    
    private func setupGestureRecognizer() {
        longPressGesture.addTarget(self, action: #selector(userTouchInMap(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.allowableMovement = 15
        longPressGesture.delegate = self
        mainMap.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func userTouchInMap(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: mainMap)
            let tapPoint = mainMap.convert(point, toCoordinateFrom: self)
            delegate?.userTouchInMap(tap: tapPoint)
        }
    }
}

// MARK: - Internal Functions
extension HomeBaseView {
    func add(annotationInMap: MKPointAnnotation) {
        mainMap.addAnnotation(annotationInMap)
    }
    
    func setViewModelInCollectionView(viewModel: HomeViewModel) {
        datasourceCitiesCollectionView.viewModel = viewModel
        delegateCitiesCollectionView.viewModel = viewModel
        citiesListCollectionView.delegate = delegateCitiesCollectionView
        citiesListCollectionView.dataSource = datasourceCitiesCollectionView
        citiesListCollectionView.reloadData()
    }
    
    func reloadCitiesList() {
        citiesListCollectionView.reloadData()
    }
}
