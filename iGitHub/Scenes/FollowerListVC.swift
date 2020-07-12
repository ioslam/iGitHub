//
//  FollowerListVC.swift
//  iGitHub
//
//  Created by Eslam on 7/12/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    let actionButton = GHButton(backgroundColor: .systemBlue, title: "")
    let dismissButton = UIButton()
    
    var followers: [Follower]?
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = username

        DispatchQueue.main.async {
            self.view.backgroundColor = .systemBackground
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        getFollowersList()
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func getFollowersList() {
        NetworkManager.shared.getFollowersList(username: self.username, page: 1) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.setAlertView(error: error)
                }
            case .success(let followers) :
                self.followers = followers
                print("loaded .. \(self.followers?[0].login ?? "login")")
            }
        }
    }
    //MARK: - show alert view layout
    func setAlertView(error: GHError) {
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
    @objc func tabToDismiss() {
        navigationController?.popViewController(animated: true)
    }

}
