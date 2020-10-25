//
//  HelpScreenViewController.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import WebKit
import UIKit

final class HelpScreenViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private let webView: WKWebView = {
        let webView: WKWebView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - Internal Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Protocol View Setup
extension HelpScreenViewController: ViewConfiguration {
    func configureUI() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.backgroundColor = AppSettingsManager.shared.currentColor.getColor()
        webView.loadHTMLString("<html><head></head><body><p>Hello, welcome to Weather App<br> This follow the steps for App Work correctly<br> 1) If you want to add bookmarked place in the map, you just need to hold tap in map for one second<br> 2) If you want to delete some bookmarked place, you just need to tap edit button and after delete button<br> 3) You can tap in settings button to change some settings like units and background color<br> 4) If you tap in some city in the list, so you can go to the detail screen and see the forecast for that city</p></body></html>", baseURL: nil)
    }
    
    func addViews() {
        view.addSubview(webView)
    }
    
    func contrainsViews() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - WKWebView Delegate
extension HelpScreenViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugPrint("Error in HTML: \(error.localizedDescription)")
    }
}

extension HelpScreenViewController: WKUIDelegate {
}
