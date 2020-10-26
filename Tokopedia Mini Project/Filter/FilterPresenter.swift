//
//  FilterPresenter.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 24/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

public let FilterKey = "FilterKey"
protocol FilterDelegate: class {
    func filterApplied()
}

final class FilterPresenter {

    // MARK: - Private properties -

    private unowned let _view: FilterViewInterface
    private let _wireframe: FilterWireframeInterface
    private let _interactor: FilterInteractorInterface
    weak var _delegate: FilterDelegate?

    // MARK: - Lifecycle -

    init(wireframe: FilterWireframeInterface, view: FilterViewInterface, interactor: FilterInteractorInterface, delegate: FilterDelegate) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        _delegate = delegate
    }
}

// MARK: - Extensions -

extension FilterPresenter: FilterPresenterInterface {
    func didSelectApplyAction(minimalPrice: String, maximalPrice: String, wholeSale: Bool, official: Bool, gold: Bool) {
        let filterParam = RequestParam(minimalPrice: minimalPrice, maximalPrice: maximalPrice, wholeSale: wholeSale, official: official, gold: gold ? "2" : "0")
        let encoder = JSONEncoder()
        if let encodedParam = try? encoder.encode(filterParam) {
            UserDefaults.standard.set(encodedParam, forKey: FilterKey)
        }
        _wireframe.navigate(to: .close(completionHandler: { [weak self] in
            self?._delegate?.filterApplied()
        }))
    }
    
    func viewDidLoad() {
        if let savedRequestParam = UserDefaults.standard.object(forKey: FilterKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedRequestParam = try? decoder.decode(RequestParam.self, from: savedRequestParam) {
                _view.bindModelToView(loadedRequestParam)
            }
        }
    }
}
