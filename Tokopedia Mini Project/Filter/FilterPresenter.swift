//
//  FilterPresenter.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 24/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

public let FilterKey = "FilterKey"

final class FilterPresenter {

    // MARK: - Private properties -

    private unowned let _view: FilterViewInterface
    private let _wireframe: FilterWireframeInterface
    private let _interactor: FilterInteractorInterface

    // MARK: - Lifecycle -

    init(wireframe: FilterWireframeInterface, view: FilterViewInterface, interactor: FilterInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

// MARK: - Extensions -

extension FilterPresenter: FilterPresenterInterface {
    func didSelectApplyAction(minimalPrice: String, maximalPrice: String, wholeSale: Bool, official: Bool, gold: Bool) {
        let filterParam = RequestParam(query: nil, minimalPrice: minimalPrice, maximalPrice: maximalPrice, wholeSale: wholeSale, official: official, gold: gold ? "2" : "0", start: nil, rows: nil)
        let encoder = JSONEncoder()
        if let encodedParam = try? encoder.encode(filterParam) {
            UserDefaults.standard.set(encodedParam, forKey: FilterKey)
        }
    }
}
