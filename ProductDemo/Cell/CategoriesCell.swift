//
//  CategoriesCell.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/16.
//

import UIKit
import SDWebImage

class CategoriesCell: UICollectionViewCell {
    
    static let reuseId = "categoriesCell"
    
    private let categoryImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        return img
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryImg)
        contentView.addSubview(categoryName)

        

        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with categories: String) {
        
        categoryName.text = categories
        setImg(category: categories)
    }
    
    func setImg(category: String) {
        switch category {
        case "electronics":
            categoryImg.image = UIImage(named: "electric")
            break
        case "jewelery":
            categoryImg.image = UIImage(named: "jewelery")
            break
        case "men's clothing":
            categoryImg.image = UIImage(named: "men")
            break
        case "women's clothing":
            categoryImg.image = UIImage(named: "women")
            break
        default:
            break
        }
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            categoryImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            categoryImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            categoryImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            categoryImg.heightAnchor.constraint(equalTo: categoryImg.widthAnchor),
            
            categoryName.topAnchor.constraint(equalTo: categoryImg.bottomAnchor, constant: 0),
            categoryName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            categoryName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            categoryName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            
        ])
    }
}
