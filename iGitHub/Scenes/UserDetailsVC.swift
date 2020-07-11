//
//  UserDetailsVC.swift
//  iGitHub
//
//  Created by Eslam on 7/9/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    var username: String!
    var userDetails: User?
    let actionButton = GHButton(backgroundColor: .systemBlue, title: "")
    let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.view.backgroundColor = .systemBackground
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        getUserDetails()
        title = userDetails?.name ?? "error"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func getUserDetails() {
        NetworkManager.shared.getUserDetails(with: self.username) { (error, userDetails) in
            if let user = userDetails {
                self.userDetails = user
                print("loaded .. \(self.userDetails?.name ?? "null")")
            } else {
                DispatchQueue.main.async {
                    self.setView(error: error!)
                    //self.createAlertView(error: error)
                }
            }
        }
    }
    //MARK: - show alert view layout
    fileprivate func createAlertView(error: ErrorMessage?) {
        let actionButton = GHButton(backgroundColor: .systemBlue, title: "")
        let dismissButton = UIButton()
        self.view.setAlertView(title: "Something went wrong",
        message: error!.rawValue,
        buttonTitle: "Try Again",
        actionButton: actionButton, dismissButton: dismissButton)
    }
   @objc func tabToDismiss() {
    navigationController?.popViewController(animated: true)
    }
    
    func setView(error: ErrorMessage) {
        dismissButton.addTarget(self, action: #selector(tabToDismiss), for: .touchUpInside)
        actionButton.addTarget(self, action: #selector(tabToDismiss), for: .touchUpInside)
        let alertView = AlertView(title: "Invalid Username",
                                  message: error.rawValue,
                                  buttonTitle: "OK",
                                  actionButton: actionButton,
                                  dismissButton: dismissButton)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dismissButton)
        view.addSubview(alertView)
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            alertView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }


}
