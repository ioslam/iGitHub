//
//  FavouriteVC.swift
//  iGitHub
//
//  Created by Eslam on 7/9/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {

   let gh_iv = UIImageView()
        let search_textfield = GHTextField()
        let search_button = GHButton(backgroundColor: .systemGreen, title: "Get User")
        let actionButton = GHButton(backgroundColor: .systemPink, title: "")
        let dismissButton = UIButton()
        
        var isUserTyped: Bool { return !search_textfield.text!.isEmpty }
        
        //MARK: - DidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemTeal
            search_button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
            DispatchQueue.main.async {
                self.createGHImage()
                self.createSearchTextfield()
                self.createSearchButton()
                self.dismissKeyboard()
            }
        }
    
        //MARK: -  WillAppear
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    //MARK: - UI
    extension FavoriteVC {
        
        //MARK: - create `Github` Image layout
        fileprivate func createGHImage() {
            view.addSubview(gh_iv)
            gh_iv.translatesAutoresizingMaskIntoConstraints = false
            gh_iv.image = UIImage(named: "gh-logo")!
            NSLayoutConstraint.activate([
                gh_iv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
                gh_iv.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                gh_iv.heightAnchor.constraint(equalToConstant: 200),
                gh_iv.widthAnchor.constraint(equalToConstant: 200)
            ])
            
        }
        //MARK: - create `search` text field layout
        fileprivate func createSearchTextfield() {
            view.addSubview(search_textfield)
            search_textfield.delegate = self
            NSLayoutConstraint.activate([
                search_textfield.topAnchor.constraint(equalTo: gh_iv.bottomAnchor, constant: 44),
                search_textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                search_textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                search_textfield.heightAnchor.constraint(equalToConstant: 44)
            ])
            
        }
        //MARK: - create `Search` Button layout
        fileprivate func createSearchButton() {
          view.addSubview(search_button)
            NSLayoutConstraint.activate([
                search_button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
                search_button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                search_button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                search_button.heightAnchor.constraint(equalToConstant: 48)
            ])
        }
        //MARK: - show alert view layout
        fileprivate func createAlertView() {
            view.setAlertView(title: "Empty Username",
                              message: "Please enter a username. We need to know who to look for 😀.",
                              buttonTitle: "OK",
                              actionButton: actionButton,
                              dismissButton: dismissButton)
        }
        //MARK: - IBActions & UIGesture Recognizer
        
        //MARK: - click anywhere in the view to dismiss the keyboard
        func dismissKeyboard() {
            let tab = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(tab)
        }
        //MARK: - Dismiss `Alert` View Action
        @objc func dismissAlert() {
            
           }
        //MARK: - Search Button Action
        @objc func searchButtonPressed() {
            validateTextfield()
        }
    }

    //MARK: - UITextfield Delegates
    extension FavoriteVC: UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            validateTextfield()
            return true
        }
        //MARK: - validate if the username is not empty
       fileprivate func validateTextfield() {
            guard isUserTyped else {
                createAlertView()
                return
            }
            displayFollowersList()
        }
        //MARK: - go to user details vc to display
        func displayFollowersList() {
            let followers = FollowerListVC()
            followers.username = search_textfield.text
            navigationController?.pushViewController(followers, animated: true)
            search_textfield.text = ""
        }

}
