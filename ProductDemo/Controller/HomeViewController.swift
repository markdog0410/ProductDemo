//
//  HomeViewController.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/16.
//

import UIKit

class HomeViewController: UIViewController {
    
    var products: [CategoryElement] = []
    var categories: [String] = []
    
    
    private let categoriesCollections: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        // 设置每一行显示 2 个单元格的宽度
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 15  // 每个单元格之间的间距
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing  // 总的间距
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - totalSpacing) / numberOfItemsPerRow
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)  // 正方形单元格
        
        layout.minimumLineSpacing = spacing  // 每行之间的间距
        layout.minimumInteritemSpacing = spacing  // 每列之间的间距
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        
        collection.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.reuseId)
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(categoriesCollections)
        categoriesCollections.delegate = self
        categoriesCollections.dataSource = self
        
        configureConstraints()
        view.backgroundColor = .systemBackground
        
        
        fetchGetCategories()
        
    }    
    
    func fetchGetCategories() {
        Task{
            do{
                self.categories = try await NetworkManager.share.getCategories()
                DispatchQueue.main.async {
                    self.categoriesCollections.reloadData()
                }
            }catch{
                if let gfError = error as? ErrorCase {
                    presentErrorAlert(title: "注意！", message: gfError.rawValue)
                }else {
                    presentErrorAlert(title: "錯誤", message: "請聯繫客服人員")
                }
            }
        }
    }
    
    
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            categoriesCollections.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            categoriesCollections.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            categoriesCollections.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 2),
            categoriesCollections.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseId, for: indexPath) as? CategoriesCell else {
            return CategoriesCell()
        }

        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ProductsViewController(category: self.categories[indexPath.row]), animated: true)
//        self.fetchCategoryProducts(categoryType: self.categories[indexPath.row]){
//            DispatchQueue.main.async {
//                self.navigationController?.pushViewController(ProductsViewController(products: self.products), animated: true)
//            }
//        }
    }
}
