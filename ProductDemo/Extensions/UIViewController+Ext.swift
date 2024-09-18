//
//  UIViewController+Ext.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/18.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // 添加確認按鈕
        let confirmAction = UIAlertAction(title: "確認", style: .default) { _ in
            print("用戶點擊了確認")
        }
        alert.addAction(confirmAction)

        present(alert, animated: true, completion: nil)

    }
}
