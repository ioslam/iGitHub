//
//  AlertView.swift
//  iGitHub
//
//  Created by Eslam on 7/9/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    let titleLabel      = GHTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = GHBodyLabel(textAlignment: .center)
    let actionButton    = GHButton(backgroundColor: .systemPink, title: "Ok")
    let dismissButton = UIButton(frame: UIScreen.main.bounds)

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(frame: .zero)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
        dismissButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor       = .systemGray5
        layer.cornerRadius    = 16
        layer.borderWidth     = 2
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureActionButton() {
        self.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureMessageLabel() {
        self.addSubview(messageLabel)
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    @objc func dismissVC() {
        self.removeFromSuperview()
        dismissButton.removeFromSuperview()
    }
}
