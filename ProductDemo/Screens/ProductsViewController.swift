//
//  ProductsViewController.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/18.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var category: String
    var products: [CategoryElement] = []
    
    private let productsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProductsCell.self, forCellReuseIdentifier: ProductsCell.reuserId)
        return table
    }()
    
    init(category: String) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(productsTable)
        productsTable.delegate = self
        productsTable.dataSource = self

        navigationItem.title = self.category
        
        fetchCategoryProducts(categoryType: category) { [weak self] in
            DispatchQueue.main.async {
                self?.productsTable.reloadData()
            }
        }
        
        configureConstraints()
    }
    
    func fetchCategoryProducts(categoryType: String, completion: @escaping () -> Void) {
        LoadingIndicatorManager.shared.showLoading(on: view)
        Task{
            do{
                let products = try await NetworkManager.share.getInCategory(category: categoryType)
                self.productsTable.reloadData()
                self.products = products
                completion()
                LoadingIndicatorManager.shared.stopLoading()
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
            productsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductsCell.reuserId, for: indexPath) as? ProductsCell else {
            return ProductsCell()
        }
        cell.configure(with: self.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select => \(indexPath.row)")
    }
 
    
}
