//
//  LoadingViewController.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/19.
//

import UIKit

class LoadingIndicatorManager {
    
    static let shared = LoadingIndicatorManager()
    private var activityIndicator: UIActivityIndicatorView?
    private var dimmedView: UIView?
    
    private init() { }
    
    func showLoading(on view: UIView) {
            // 如果尚未創建背景遮罩視圖，則創建
            if dimmedView == nil {
                let dimmed = UIView()
                dimmed.backgroundColor = UIColor.black.withAlphaComponent(0.5)  // 設置背景為半透明黑色
                dimmed.translatesAutoresizingMaskIntoConstraints = false
                dimmedView = dimmed
            }
            
            // 如果尚未創建 UIActivityIndicatorView，則創建
            if activityIndicator == nil {
                let indicator = UIActivityIndicatorView(style: .large)
                indicator.translatesAutoresizingMaskIntoConstraints = false
                indicator.hidesWhenStopped = true
                indicator.color = .systemGreen  // 修改 UIActivityIndicatorView 的顏色
                activityIndicator = indicator
            }
            
            guard let dimmedView = dimmedView, let activityIndicator = activityIndicator else { return }
            
            // 如果視圖中不包含背景遮罩和指示器，則添加
            if !view.subviews.contains(dimmedView) {
                view.addSubview(dimmedView)
                NSLayoutConstraint.activate([
                    dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
                    dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            }
            
            if !view.subviews.contains(activityIndicator) {
                view.addSubview(activityIndicator)
                NSLayoutConstraint.activate([
                    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
            }
            
            dimmedView.isHidden = false
            activityIndicator.startAnimating()
        }
    
    // 隱藏 Loading Indicator
    func stopLoading() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        
        dimmedView?.removeFromSuperview()
        dimmedView = nil
    }
}
