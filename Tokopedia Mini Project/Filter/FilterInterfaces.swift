//
//  FilterInterfaces.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 24/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

enum FilterNavigationOption {
    case close(completionHandler: () -> Void)
}

protocol FilterWireframeInterface: WireframeInterface {
    func navigate(to option: FilterNavigationOption)
}

protocol FilterViewInterface: ViewInterface {
    func bindModelToView(_ model: RequestParam)
}

protocol FilterPresenterInterface: PresenterInterface {
    func didSelectApplyAction(minimalPrice: String, maximalPrice: String, wholeSale: Bool, official: Bool, gold: Bool)
}

protocol FilterInteractorInterface: InteractorInterface {
}
