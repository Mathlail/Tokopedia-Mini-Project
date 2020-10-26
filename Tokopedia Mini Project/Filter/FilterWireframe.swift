//
//  FilterWireframe.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 24/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

final class FilterWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init(delegate: FilterDelegate) {
        let moduleViewController = FilterViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = FilterInteractor()
        let presenter = FilterPresenter(wireframe: self, view: moduleViewController, interactor: interactor, delegate: delegate)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension FilterWireframe: FilterWireframeInterface {

    func navigate(to option: FilterNavigationOption) {
        switch option {
        case .close(let completionHandler):
            navigationController?.dismiss(animated: true, completion: {
                completionHandler()
            })
        }
    }
}
