//
//  FilterViewController.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 24/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

final class FilterViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: FilterPresenterInterface!
    
    lazy var filterView: FilterView = {
        let view = FilterView()
        let shopTypeGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShopTypeView(_:)))
        view.shopTypeView.addGestureRecognizer(shopTypeGesture)
        view.applyButton.addTarget(self, action: #selector(didSelectApplyButton(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var shopTypeView: ShopTypeView = {
        let view = ShopTypeView(frame: UIScreen.screenBounds)
        view.isHidden = true
        view.closeButton.addTarget(self, action: #selector(didSelectCloseShopTypes(_:)), for: .touchUpInside)
        view.goldMerchantButton.addTarget(self, action: #selector(didSelectShopTypeButton(_:)), for: .touchUpInside)
        view.officialMerchantButton.addTarget(self, action: #selector(didSelectShopTypeButton(_:)), for: .touchUpInside)
        view.applyButton.addTarget(self, action: #selector(didSelectApplyShopTypeButton(_:)), for: .touchUpInside)
        view.resetButton.addTarget(self, action: #selector(didSelectResetShopTypeButton(_:)), for: .touchUpInside)
        return view
    }()

    // MARK: - Lifecycle -
    
    override func loadView() {
        view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        setupRightNavigationBar(withTitle: "Reset")
        setupLeftNavigationBar(withImage: #imageLiteral(resourceName: "ic_close"))
        presenter.viewDidLoad()
    }
    
    func setupLeftNavigationBar(withImage image: UIImage!) {
        let barButtonItem = UIBarButtonItem(image: image,
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapLeftBarButtonItem(_:)))
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    func setupRightNavigationBar(withTitle title: String) {
        let barButtonItem = UIBarButtonItem(title: title,
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapRightBarButtonItem(_:)))
        barButtonItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.tokopediaGreen,
                                              NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)], for: UIControl.State())
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func didTapLeftBarButtonItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapRightBarButtonItem(_ sender: UIBarButtonItem) {
        filterView.removeStackViewSubview(0)
        filterView.removeStackViewSubview(1)
        filterView.bindModel(RequestParam())
    }
    
    @objc func didTapShopTypeView(_ sender: UITapGestureRecognizer) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}

        UIView.transition(with: window, duration: 0.25, options: .curveEaseIn, animations: {
            var merchantTypes = [MerchantType]()
            for (index, value) in [self.filterView.getSelectedShopType().goldMerchant, self.filterView.getSelectedShopType().officialMerchant].enumerated() {
                if value {
                    if index == 0 {
                        merchantTypes.append(.goldMerchant)
                    } else {
                        merchantTypes.append(.officialStore)
                    }
                }
            }
            self.shopTypeView.setupStackView(merchantTypes)
            window.addSubview(self.shopTypeView)
        }, completion: { (completed) in
            if completed {
                self.shopTypeView.isHidden = false
                
            }
        })
    }

    @objc func didSelectCloseShopTypes(_ sender: UIButton) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}

        UIView.transition(with: window, duration: 0.5, options: .curveEaseOut, animations: {
            self.shopTypeView.removeFromSuperview()
        }, completion: nil)
    }
    
    @objc func didSelectShopTypeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func didSelectApplyButton(_ sender: UIButton) {
        presenter.didSelectApplyAction(minimalPrice: filterView.getsliderPrice().lowerPrice, maximalPrice: filterView.getsliderPrice().upperPrice, wholeSale: filterView.wholeSaleSwitch.isOn, official: filterView.getSelectedShopType().officialMerchant, gold: filterView.getSelectedShopType().goldMerchant)
    }
    
    @objc func didSelectApplyShopTypeButton(_ sender: UIButton) {
        for (index, value) in [shopTypeView.goldMerchantButton, shopTypeView.officialMerchantButton].enumerated() {
            if value.isSelected {
                if index == 0 {
                    if !filterView.getSelectedShopType().goldMerchant {
                        filterView.setupStackView([.goldMerchant])
                    }
                } else {
                    if !filterView.getSelectedShopType().officialMerchant {
                        filterView.setupStackView([.officialStore])
                    }
                }
            } else {
                if index == 0 {
                    filterView.removeStackViewSubview(0)
                } else {
                    filterView.removeStackViewSubview(1)
                }
            }
        }
        didSelectCloseShopTypes(sender)
    }
    
    @objc func didSelectResetShopTypeButton(_ sender: UIButton) {
        [shopTypeView.goldMerchantButton, shopTypeView.officialMerchantButton].forEach { (button) in
            button.isSelected = true
        }
    }
}

// MARK: - Extensions -

extension FilterViewController: FilterViewInterface {
    func bindModelToView(_ model: RequestParam) {
        filterView.bindModel(model)
    }
}
