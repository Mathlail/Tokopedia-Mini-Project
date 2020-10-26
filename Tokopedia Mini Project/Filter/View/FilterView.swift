//
//  FilterView.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 24/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit
import WARangeSlider

class FilterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var minLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.text = "Minimum Price"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var maxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        label.text = "Maximum Price"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var minPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rp. 100"
        return label
    }()
    
    lazy var maxPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rp. 10.000.000"
        return label
    }()
    
    lazy var priceSlider: RangeSlider = {
        let slider = RangeSlider(frame: CGRect.zero)
        slider.trackHighlightTintColor = .tokopediaGreen
        slider.thumbBorderColor = .tokopediaGreen
        slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
        slider.lowerValue = 0
        slider.upperValue = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var wholeSaleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.text = "Whole Sale"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var wholeSaleSwitch: UISwitch = {
        let uiSwitch = UISwitch(frame: CGRect.zero)
        uiSwitch.onTintColor = .tokopediaGreen
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    lazy var shopTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.text = "Shop Type"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var shopTypeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var shopTypeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icons-next").withTintColor(UIColor.tokopediaGreen), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()

    lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .tokopediaGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    func setupViews(){
        addSubview(topView)
        addSubview(applyButton)
        topView.addSubview(minLabel)
        topView.addSubview(maxLabel)
        topView.addSubview(minPriceLabel)
        topView.addSubview(maxPriceLabel)
        topView.addSubview(separatorView)
        topView.addSubview(priceSlider)
        topView.addSubview(wholeSaleLabel)
        topView.addSubview(wholeSaleSwitch)
        
        addSubview(bottomView)
        bottomView.addSubview(shopTypeView)
        shopTypeView.addSubview(shopTypeLabel)
        shopTypeView.addSubview(shopTypeButton)
        bottomView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            applyButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            applyButton.heightAnchor.constraint(equalToConstant: 50),
            
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            minLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 15),
            minLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 15),
            minLabel.trailingAnchor.constraint(equalTo: maxLabel.trailingAnchor, constant: -15),
            
            maxLabel.topAnchor.constraint(equalTo: minLabel.topAnchor),
            maxLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -15),
            
            minPriceLabel.leadingAnchor.constraint(equalTo: minLabel.leadingAnchor),
            minPriceLabel.topAnchor.constraint(equalTo: minLabel.bottomAnchor, constant: 10),
            minPriceLabel.trailingAnchor.constraint(equalTo: minLabel.trailingAnchor),
            
            maxPriceLabel.topAnchor.constraint(equalTo: minPriceLabel.topAnchor),
            maxPriceLabel.trailingAnchor.constraint(equalTo: maxLabel.trailingAnchor),
            
            separatorView.topAnchor.constraint(equalTo: maxPriceLabel.bottomAnchor, constant: 5),
            separatorView.trailingAnchor.constraint(equalTo: maxPriceLabel.trailingAnchor),
            separatorView.leadingAnchor.constraint(equalTo: minPriceLabel.leadingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            priceSlider.leadingAnchor.constraint(equalTo: minLabel.leadingAnchor),
            priceSlider.topAnchor.constraint(equalTo: minPriceLabel.bottomAnchor, constant: 50),
            priceSlider.trailingAnchor.constraint(equalTo: maxLabel.trailingAnchor),
            priceSlider.heightAnchor.constraint(equalToConstant: 31),
            
            wholeSaleLabel.leadingAnchor.constraint(equalTo: minLabel.leadingAnchor),
            wholeSaleLabel.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 30),
            
            wholeSaleSwitch.trailingAnchor.constraint(equalTo: maxLabel.trailingAnchor),
            wholeSaleSwitch.topAnchor.constraint(equalTo: wholeSaleLabel.topAnchor),
            wholeSaleSwitch.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -15),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            shopTypeView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            shopTypeView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            shopTypeView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            
            shopTypeLabel.leadingAnchor.constraint(equalTo: shopTypeView.leadingAnchor, constant: 15),
            shopTypeLabel.topAnchor.constraint(equalTo: shopTypeView.topAnchor, constant: 20),
            shopTypeLabel.bottomAnchor.constraint(equalTo: shopTypeView.bottomAnchor, constant: -5),
            
            shopTypeButton.centerYAnchor.constraint(equalTo: shopTypeLabel.centerYAnchor),
            shopTypeButton.trailingAnchor.constraint(equalTo: shopTypeView.trailingAnchor, constant: -15),
            shopTypeButton.heightAnchor.constraint(equalToConstant: 25),
            shopTypeButton.widthAnchor.constraint(equalToConstant: 25),
            
            stackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: shopTypeLabel.bottomAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 35),
            stackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -20),
            
        ])
        
    }
    
    @objc func sliderValueChange(sender: RangeSlider){
        let roundedMinValue = max(100, round(sender.lowerValue * 10000000))
        let roundedMaxValue = round(sender.upperValue * 10000000)
        minPriceLabel.text = "Rp \(Int(roundedMinValue).formattedWithSeparator)"
        maxPriceLabel.text = "Rp \(Int(roundedMaxValue).formattedWithSeparator)"
    }
    
    func setupStackView(_ types: [MerchantType]) {
        types.forEach { (name) in
            let view = UIView()
            view.backgroundColor = .white
            view.layer.borderWidth = 0.5
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.cornerRadius = 17.5
            view.tag = name == .goldMerchant ? 0 : 1
            let typeLabel: UILabel = UILabel()
            typeLabel.font = UIFont.systemFont(ofSize: 10)
            typeLabel.textColor = .grayTextField
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            typeLabel.text = name.rawValue
            let button = UIButton()
            let tint = #imageLiteral(resourceName: "ic_close").withRenderingMode(.alwaysTemplate)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
            button.tintColor = UIColor.lightGray
            button.setImage(tint, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 17.5
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.addTarget(self, action: #selector(didSelectRemoveShopType(_:)), for: .touchUpInside)
            button.tag = name == .goldMerchant ? 0 : 1
            
            view.addSubview(typeLabel)
            view.addSubview(button)
            NSLayoutConstraint.activate([
                typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                typeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                typeLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -20),
                
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                button.widthAnchor.constraint(equalToConstant: 35),
                button.heightAnchor.constraint(equalToConstant: 35),
            ])
            
            stackView.addArrangedSubview(view)
        }
        
    }
    
    @objc func didSelectRemoveShopType(_ sender: UIButton) {
        removeStackViewSubview(sender.tag)
    }
    
    func getSelectedShopType() -> (goldMerchant: Bool, officialMerchant: Bool) {
        return (stackView.arrangedSubviews.contains(where: {$0.tag == 0}), stackView.arrangedSubviews.contains(where: {$0.tag == 1}))
    }
    
    func getsliderPrice() -> (lowerPrice: String, upperPrice: String) {
        let roundedMinValue = max(100, round(priceSlider.lowerValue * 10000000))
        let roundedMaxValue = round(priceSlider.upperValue * 10000000)
        return (roundedMinValue.removeZerosFromEnd(), roundedMaxValue.removeZerosFromEnd())
    }
    
    func removeStackViewSubview(_ tag: Int) {
        guard let removedView = stackView.arrangedSubviews.first(where: {$0.tag == tag}) else { return }
        stackView.removeArrangedSubview(removedView)
        removedView.removeFromSuperview()
    }
    
    func bindModel(_ model: RequestParam) {
        var merchantTypes = [MerchantType]()
        for (index, value) in [model.gold == "2" ? true : false, model.official].enumerated() {
            if value ?? false {
                if index == 0 {
                    merchantTypes.append(.goldMerchant)
                } else {
                    merchantTypes.append(.officialStore)
                }
            }
        }
        setupStackView(merchantTypes)
        priceSlider.lowerValue = model.convertedPrice().lowerPrice / 10000000
        priceSlider.upperValue = model.convertedPrice().upperPrice / 10000000
        minPriceLabel.text = "Rp \(Int(model.convertedPrice().lowerPrice).formattedWithSeparator)"
        maxPriceLabel.text = "Rp \(Int(model.convertedPrice().upperPrice).formattedWithSeparator)"
        if model.wholeSale ?? false {
            wholeSaleSwitch.setOn(true, animated: false)
        } else {
            wholeSaleSwitch.setOn(false, animated: false)
        }
    }
}
