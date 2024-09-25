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
        return img
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let dollarSign: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "dollarsign")
        img.tintColor = .systemGreen
        return img
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let starView: StarRateView = {
        let view = StarRateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingCounts: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let cartAdd: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
        let largerImage = UIImage(systemName: "cart.badge.plus", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        button.setImage(largerImage, for: .normal)
                
        button.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        let action = UIAction { _ in
            print("button tapped.")
            UIView.animate(withDuration: 0.1, animations: {
                button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    button.transform = CGAffineTransform.identity
                })
            }
        }

        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(productImg)
        contentView.addSubview(name)
        contentView.addSubview(dollarSign)
        contentView.addSubview(price)

        contentView.addSubview(cartAdd)
        contentView.addSubview(starView)
        contentView.addSubview(ratingCounts)
        
        configureConstraints()

//        cartAdd.addTarget(self, action: #selector(cartAddButton), for: .touchUpInside)
    }
    
//    @objc
//    func cartAddButton() {
//        print("cart button tapped")
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: CategoryElement) {
        productImg.sd_setImage(with: URL(string: product.image))
        name.text = product.title
        price.text = String(product.price)
        ratingCounts.text = String(product.rating.count)
        
        starView.setRating(CGFloat(product.rating.rate))
    }
    
    func configureConstraints() {
        let topConstant: CGFloat = 5
        let bottomConstant: CGFloat = -5
        
        NSLayoutConstraint.activate([
            productImg.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            productImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant),
            productImg.widthAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            name.leadingAnchor.constraint(equalTo: productImg.trailingAnchor, constant: 5),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            dollarSign.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            dollarSign.leadingAnchor.constraint(equalTo: productImg.trailingAnchor, constant: 5),
            dollarSign.widthAnchor.constraint(equalToConstant: 20),
            dollarSign.heightAnchor.constraint(equalToConstant: 30),
            
            price.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            price.leadingAnchor.constraint(equalTo: dollarSign.trailingAnchor, constant: 5),
            
            cartAdd.leadingAnchor.constraint(equalTo: price.trailingAnchor, constant: 5),
            cartAdd.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            cartAdd.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cartAdd.heightAnchor.constraint(equalToConstant: 40),
            cartAdd.widthAnchor.constraint(equalToConstant: 44),
            
            starView.leadingAnchor.constraint(equalTo: productImg.trailingAnchor, constant: 5),
            starView.bottomAnchor.constraint(equalTo: dollarSign.topAnchor, constant: -20),
            starView.widthAnchor.constraint(equalToConstant: 150),
            
            ratingCounts.leadingAnchor.constraint(equalTo: starView.trailingAnchor, constant: 5),
            ratingCounts.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            ratingCounts.centerYAnchor.constraint(equalTo: starView.centerYAnchor)
            
        ])
    }
}
