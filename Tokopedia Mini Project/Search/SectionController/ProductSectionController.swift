//
//  ProductSectionController.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import Foundation
import IGListKit

class ProductSectionController: ListSectionController {
    var model: ProductModel?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let _ = model, let width = collectionContext?.insetContainerSize.width else { return .zero }
        return CGSize(width: (width - 3) / 2, height: 280)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let model = model,
            let cell = collectionContext?.dequeueReusableCell(of: ItemCollectionViewCell.self, for: self, at: index) as? ItemCollectionViewCell else {
                fatalError("viewModel or cell not set")
        }
        print("impression - \(model.id ?? 0)")
        cell.bindModel(model)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        model = object as? ProductModel
    }
    
}
