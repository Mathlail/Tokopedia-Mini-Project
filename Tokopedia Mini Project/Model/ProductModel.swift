//
//  SearchModel.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import Foundation
import IGListKit

class ProductModel: Codable {
    private(set) var id: Int?
    private(set) var name: String?
    private(set) var price: String?
    private(set) var imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, price
        case imageUrl = "image_uri"
    }
}

extension ProductModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id ?? 0)
    }
}

extension ProductModel: Equatable {
    public static func ==(lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ProductModel: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return (id ?? 0) as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ProductModel else { return false }
        return self.id == object.id && self.name == object.name
    }
}
