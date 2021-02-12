//
//  UIViewController+Ext.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GREmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC                     = GRAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .coverVertical
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(url: URL) {
        let safariVC                       = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemYellow
        present(safariVC, animated: true)
    }
    
    
}
