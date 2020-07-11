//
//  UIView + Ex.swift
//  iGitHub
//
//  Created by Eslam on 7/11/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import UIKit

extension UIView {
    
    func setAlertView(title: String, message: String, buttonTitle: String, actionButton: GHButton, dismissButton: UIButton) {
        
        guard let superview = superview else { return }
        let alertView = AlertView(title: title, message: message, buttonTitle: buttonTitle,actionButton: actionButton, dismissButton: dismissButton)
        actionButton.addTarget(dismissButton, action: #selector(UIView.removeFromSuperview), for: .touchUpInside)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(dismissButton, action: #selector(UIView.removeFromSuperview) , for: .touchUpInside)
        dismissButton.addTarget(alertView, action: #selector(UIView.removeFromSuperview) , for: .touchUpInside)
        superview.addSubview(dismissButton)
        superview.addSubview(alertView)
                
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 200),
            alertView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 24),
            alertView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -24),
            alertView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
