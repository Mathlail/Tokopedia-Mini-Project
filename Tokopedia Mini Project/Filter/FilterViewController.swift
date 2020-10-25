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
        view.closeButton.addTarget(self, action: #selector(didSelectCloseShopTypes(_:)), for: .touchUpInside)
        view.goldMerchantButton.addTarget(self, action: #selector(didSelectShopTypeButton(_:)), for: .touchUpInside)
        view.officialMerchantButton.addTarget(self, action: #selector(didSelectShopTypeButton(_:)), for: .touchUpInside)
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
        filterView.setupStackView([.officialStore, .goldMerchant])
        shopTypeView.setupStackView([.goldMerchant])
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
        
    }
    
    @objc func didTapShopTypeView(_ sender: UITapGestureRecognizer) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}

        UIView.transition(with: window, duration: 0.5, options: .curveEaseIn, animations: {
            window.addSubview(self.shopTypeView)
        }, completion: nil)
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
        presenter.didSelectApplyAction(minimalPrice: String(filterView.priceSlider.lowerValue), maximalPrice: String(filterView.priceSlider.upperValue), wholeSale: filterView.wholeSaleSwitch.isOn, official: filterView.getSelectedShopType().officialMerchant, gold: filterView.getSelectedShopType().goldMerchant)
    }
}

// MARK: - Extensions -

extension FilterViewController: FilterViewInterface {
}
