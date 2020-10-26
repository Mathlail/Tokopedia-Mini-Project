//
//  ShopTypeswift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 25/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

class ShopTypeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavigation()
        setupView()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var navigationBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "ic_close").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    lazy private var titleLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.boldSystemFont(ofSize: 16)
       label.text = "Shop Type"
       label.textAlignment = .left
       return label
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.tokopediaGreen, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    lazy var goldMerchantButton: UIButton = {
        let button = UIButton()
        button.setTitle(MerchantType.goldMerchant.rawValue, for: .normal)
        button.setImage(#imageLiteral(resourceName: "icon-unchecked"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "icon-checked"), for: .selected)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 12)
        return button
    }()
    
    lazy var officialMerchantButton: UIButton = {
        let button = UIButton()
        button.setTitle(MerchantType.officialStore.rawValue, for: .normal)
        button.setImage(#imageLiteral(resourceName: "icon-unchecked"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "icon-checked"), for: .selected)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .left
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 12)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
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
    
    private let heightNavigationView = 44 + UIScreen.getStatusBarHeight()
    
    func setupNavigation() {
        addSubview(navigationBarView)
        addSubview(applyButton)
        navigationBarView.addSubview(closeButton)
        navigationBarView.addSubview(titleLabel)
        navigationBarView.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            applyButton.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            applyButton.heightAnchor.constraint(equalToConstant: 50),
            
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.topAnchor.constraint(equalTo: topAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: heightNavigationView),
            
            closeButton.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: navigationBarView.topAnchor, constant: UIScreen.getStatusBarHeight()),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 25),

            resetButton.trailingAnchor.constraint(equalTo: navigationBarView.trailingAnchor, constant: -10),
            resetButton.topAnchor.constraint(equalTo: closeButton.topAnchor),
            resetButton.heightAnchor.constraint(equalTo: closeButton.heightAnchor),
            resetButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor),
        ])
    }
    
    func setupView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupStackView(_ types: [MerchantType]) {
        let merchantTypesButton: [UIButton] = [goldMerchantButton, officialMerchantButton]
        for (index, button) in merchantTypesButton.enumerated() {
            if index < types.count {
                button.isSelected = types[index].rawValue == button.currentTitle ? true : false
            }
            stackView.addArrangedSubview(button)
            button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        }
    }

}
