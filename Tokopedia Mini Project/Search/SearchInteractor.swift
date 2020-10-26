//
//  SearchInteractor.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import Foundation
import Alamofire

final class SearchInteractor {
}

// MARK: - Extensions -

extension SearchInteractor: SearchInteractorInterface {
    
    func getProductList(param: RequestParam, completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        let urlProduct = "https://ace.tokopedia.com/search/v2.5/product"
        AF.request(urlProduct, parameters: param).responseDecodable(of: BaseResponse.self) { response in
            switch response.result {
            case .success(let response):
                completion(.success(response.data ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDataFromUserDefault() -> RequestParam {
        if let savedRequestParam = UserDefaults.standard.object(forKey: FilterKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedRequestParam = try? decoder.decode(RequestParam.self, from: savedRequestParam) {
                return loadedRequestParam
            }
        }
        return RequestParam()
    }
}
