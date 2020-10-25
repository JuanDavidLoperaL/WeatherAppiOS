//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import MapKit
import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func add(annotationInMap: MKPointAnnotation)
    func editButton(shouldShow: Bool)
    func changeEditButton(text: String)
    func remove(annotation: MKPointAnnotation)
    func reloadCitiesList()
    func navigateToCityDetail(with cityInfo: LocationInfo)
    func errorInAnnotation()
}

final class HomeViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private let baseView: HomeBaseView = HomeBaseView(frame: .zero)
    
    // MARK: - Private Properties
    private let viewModel: HomeViewModel
    
    // MARK: - Internal Init
    init(viewModel: HomeViewModel = HomeViewModel()) {
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
        baseView.delegate = self
        baseView.setViewModelInCollectionView(viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Protocol ViewModel
extension HomeViewController: HomeViewControllerDelegate {
    func errorInAnnotation() {
        let alert: UIAlertController = UIAlertController(title: "Error", message: "We got a error trying to add the bookmark, please be sure that you are tapping in the correct place and try again", preferredStyle: .alert)
        let alertOk: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func add(annotationInMap: MKPointAnnotation) {
        baseView.add(annotationInMap: annotationInMap)
    }
    
    func reloadCitiesList() {
        baseView.reloadCitiesList()
    }
    
    func editButton(shouldShow: Bool) {
        baseView.editButton(shouldShow: shouldShow)
    }
    
    func changeEditButton(text: String) {
        baseView.changeEditButton(text: text)
    }
    
    func remove(annotation: MKPointAnnotation) {
        baseView.remove(annotation: annotation)
    }
    
    func navigateToCityDetail(with cityInfo: LocationInfo) {
        let viewModel: CityDetailViewModel = CityDetailViewModel(cityInfo: cityInfo)
        let cityDetail: CityDetailViewController = CityDetailViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(cityDetail, animated: true)
    }
}

// MARK: - Protocol BaseView
extension HomeViewController: HomeBaseViewDelegate {
    func userTouchInMap(tap: CLLocationCoordinate2D) {
        viewModel.getAnnotation(with: tap)
    }
    
    func editButtonTouched() {
        viewModel.editButtonTouched()
    }
    
    func settingsButtonTouched() {
        let settingsViewController: SettingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func helpButtonTouched() {
        let helpViewController: HelpScreenViewController = HelpScreenViewController()
        self.navigationController?.pushViewController(helpViewController, animated: true)
    }
    
    func filterTexting(word: String) {
        viewModel.filter(by: word)
    }
}
