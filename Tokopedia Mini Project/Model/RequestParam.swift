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
    private(set) var official: Bool?
    private(set) var gold: String?
    private(set) var start: String?
    private(set) var rows: String?
    
    init(query: String? = "samsung", minimalPrice: String = "100", maximalPrice: String = "10000000", wholeSale: Bool = false, official: Bool = true, gold: String = "2", start: String? = "0", rows: String? = "10") {
        self.query = query
        self.minimalPrice = minimalPrice
        self.maximalPrice = maximalPrice
        self.wholeSale = wholeSale
        self.official = official
        self.gold = gold
        self.start = start
        self.rows = rows
    }
    
    private enum CodingKeys: String, CodingKey {
        case wholeSale, official, start, rows
        case query = "q"
        case minimalPrice = "pmin"
        case maximalPrice = "pmax"
        case gold = "fshop"
    }
    
    func convertedPrice() -> (lowerPrice: Double, upperPrice: Double) {
        return ((minimalPrice as NSString?)?.doubleValue ?? 0, (maximalPrice as NSString?)?.doubleValue ?? 0)
    }
    
    mutating func updateStartValue(_ start: String) {
        self.start = start
    }
}
