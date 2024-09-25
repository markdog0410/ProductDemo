//
//  StarRateView.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/24.
//

import UIKit

class StarRateView: UIView {
    
    var ratingScore: CGFloat? {
        didSet {
            setStarView()
        }
    }
    var starLimit: Int = 5
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        return stack
    }()

    init(frame: CGRect, ratingScore: CGFloat) {
        self.ratingScore = ratingScore
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        self.ratingScore = 0.0
        super.init(frame: frame)
        setStarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStarView() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let fullStars = Int(ratingScore ?? 0) // 整数部分
        let hasHalfStar = (ratingScore ?? 0) - CGFloat(fullStars) >= 0.5 // 判断是否需要半星
        
        for index in 1...starLimit {
            let starImage = UIImageView()
            starImage.translatesAutoresizingMaskIntoConstraints = false
            starImage.contentMode = .scaleAspectFit
            starImage.widthAnchor.constraint(equalToConstant: 30).isActive = true  // 设置星星宽度
            starImage.heightAnchor.constraint(equalToConstant: 30).isActive = true // 设置星星高度
            
            if index <= fullStars {
                // 设置为满星
                starImage.image = UIImage(named: "full-star")
            } else if index == fullStars + 1 && hasHalfStar {
                // 设置为半星
                starImage.image = UIImage(named: "half-star")
            } else {
                // 设置为空星
                starImage.image = UIImage(named: "empty-star")
            }
            stackView.addArrangedSubview(starImage)
        }
        addSubview(stackView)
        configureConstraits()
    }
    
    func setRating(_ rating: CGFloat) {
        self.ratingScore = rating
    }
    
    func configureConstraits() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
