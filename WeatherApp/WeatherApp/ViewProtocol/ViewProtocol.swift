//
//  ViewProtocol.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

protocol ViewConfiguration {
    func setup()
    func addViews()
    func contrainsViews()
    func configureUI()
}

extension ViewConfiguration {
    func setup() {
        addViews()
        contrainsViews()
        configureUI()
    }
    
    func configureUI() {}
}
