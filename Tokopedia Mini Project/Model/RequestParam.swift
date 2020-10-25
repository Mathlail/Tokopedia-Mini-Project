//
//  RequestParam.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import Foundation

struct RequestParam: Codable {
    private(set) var query: String?
    private(set) var minimalPrice: String?
    private(set) var maximalPrice: String?
    private(set) var wholeSale: Bool?
    private(set) var official: Bool
    private(set) var gold: String?
    private(set) var start: String?
    private(set) var rows: String?
    
    private enum CodingKeys: String, CodingKey {
        case wholeSale, official, start, rows
        case query = "q"
        case minimalPrice = "pmin"
        case maximalPrice = "pmax"
        case gold = "fshop"
    }
}
