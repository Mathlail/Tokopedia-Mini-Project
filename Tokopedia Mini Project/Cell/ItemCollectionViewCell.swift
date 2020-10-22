//
//  ItemCollectionViewCell.swift
//  Tokopedia Mini Project
//
//  Created by FDN-Fajri Ramadhan on 22/10/20.
//  Copyright © 2020 FDN-Fajri Ramadhan. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var contentLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImage.image = nil
        contentLabel.text = nil
        priceLabel.text = nil
    }
    
    func setupViews(){
        contentView.addSubview(contentImage)
        contentView.addSubview(contentLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            contentImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentImage.heightAnchor.constraint(equalToConstant: 175),
            
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentLabel.topAnchor.constraint(equalTo: contentImage.bottomAnchor, constant: 15),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func bindModel(_ model: ProductModel?) {
        guard let itemName = model?.name else { return }
        guard let itemPrice = model?.price else { return }
        setupContentImage(model)
        contentLabel.text = itemName
        priceLabel.text = itemPrice
    }
    
    func setupContentImage(_ model: ProductModel?){
        guard let urlImage = model?.imageUrl else { return }
        let url = URL(string: urlImage)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                self.contentImage.image = UIImage(data: data!)
            }
        }.resume()
    }
}
