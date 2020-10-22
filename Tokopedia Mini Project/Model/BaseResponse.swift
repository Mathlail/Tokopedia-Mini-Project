//
//  BaseResponse.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import Foundation

struct BaseResponse: Codable {
    private(set) var data: [ProductModel]?
}
