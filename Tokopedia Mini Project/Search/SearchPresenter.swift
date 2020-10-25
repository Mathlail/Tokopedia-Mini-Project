//
//  SearchPresenter.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit
import IGListKit

final class SearchPresenter {

    // MARK: - Private properties -

    private unowned let _view: SearchViewInterface
    private let _wireframe: SearchWireframeInterface
    private let _interactor: SearchInteractorInterface
    
    private var _dataProduct = [ListDiffable]()
    private var _startIndex = 0

    // MARK: - Lifecycle -

    init(wireframe: SearchWireframeInterface, view: SearchViewInterface, interactor: SearchInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
    
    func fetchData(refresh: Bool = false) {
        if refresh { _startIndex = 0 }
        let param = RequestParam(query: "samsung", minimalPrice: "1000", maximalPrice: "1000", wholeSale: true, official: false, gold: "2", start: String(_startIndex), rows: "10")
        _interactor.getProductList(param: param) { [weak self] (result) in
            self?._view.showLoader(false)
            switch result {
            case .success(let data):
                self?.showData(refresh, data)
                if !data.isEmpty { self?._startIndex += data.count }
            case .failure(let error):
                self?._wireframe.showAlert(withTitle: "Ooops...", message: error.localizedDescription, cancelButtonTitle: "Cancel", confirmButtonTitle: "Retry") { [weak self] (_) in
                    self?.fetchData(refresh: true)
                }
            }
        }
    }
    
    func showData(_ refresh: Bool, _ data: [ListDiffable]) {
        if refresh { _dataProduct.removeAll() }
        _dataProduct.append(contentsOf: data)
        _view.showData(_dataProduct)
    }
    
}

// MARK: - Extensions -

extension SearchPresenter: SearchPresenterInterface {
    func viewDidLoad() {
        _view.showLoader(true)
        fetchData(refresh: true)
    }
    
    func requestLoadMore() {
        fetchData()
    }
    
    func requestRefresh() {
        fetchData(refresh: true)
    }
    
    func didSelectFilterAction() {
        _wireframe.navigate(to: .filter)
    }
}
