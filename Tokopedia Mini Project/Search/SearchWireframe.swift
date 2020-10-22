//
//  SearchWireframe.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

final class SearchWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = SearchViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension SearchWireframe: SearchWireframeInterface {

    func navigate(to option: SearchNavigationOption) {
    }
}
