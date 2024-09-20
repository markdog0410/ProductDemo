//
//  ProductsCell.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/19.
//

import UIKit
import SDWebImage

class ProductsCell: UITableViewCell {
    
    static let reuserId = "productscell"
    
    private let productImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 10
        img.backgroundColor = .red
        return img
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(productImg)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: CategoryElement) {
        print(product)
        productImg.sd_setImage(with: URL(string: product.image))
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            productImg.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            productImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            productImg.widthAnchor.constraint(equalToConstant: 100),
//            productImg.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
