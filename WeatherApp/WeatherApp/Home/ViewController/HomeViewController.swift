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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Protocol ViewModel
extension HomeViewController: HomeViewControllerDelegate {
    func add(annotationInMap: MKPointAnnotation) {
        baseView.add(annotationInMap: annotationInMap)
    }
}

// MARK: - Protocol BaseView
extension HomeViewController: HomeBaseViewDelegate {
    func userTouchInMap(tap: CLLocationCoordinate2D) {
        viewModel.getAnnotation(with: tap)
    }
}
