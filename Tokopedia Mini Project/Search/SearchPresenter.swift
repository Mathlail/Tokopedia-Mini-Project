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
        print(param)
        _interactor.getProductList(param: param) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.showData(data)
                if !data.isEmpty { self?._startIndex += data.count }
                print(self?._startIndex)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showData(_ data: [ListDiffable]) {
        _dataProduct.append(contentsOf: data)
        _view.showData(_dataProduct)
    }
    
}

// MARK: - Extensions -

extension SearchPresenter: SearchPresenterInterface {
    func viewDidLoad() {
        fetchData(refresh: true)
    }
    
    func requestLoadMore() {
        fetchData()
    }
}
