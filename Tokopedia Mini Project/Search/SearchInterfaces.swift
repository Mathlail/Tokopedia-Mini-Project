//
//  SearchInterfaces.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

enum MerchantType: String {
    case officialStore = "Official Store"
    case goldMerchant = "Gold Merchant"
}

enum SearchNavigationOption {
    case filter(delegate: FilterDelegate)
}

protocol SearchWireframeInterface: WireframeInterface {
    func navigate(to option: SearchNavigationOption)
}

protocol SearchViewInterface: ViewInterface {
    
}

protocol SearchPresenterInterface: PresenterInterface {
    func didSelectFilterAction()
}

protocol SearchInteractorInterface: InteractorInterface {
    func getProductList(param: RequestParam, completion: @escaping (Result<[ProductModel], Error>) -> Void)
    func getDataFromUserDefault() -> RequestParam
}
