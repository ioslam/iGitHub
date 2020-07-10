//
//  SearchVC.swift
//  iGitHub
//
//  Created by Eslam on 7/9/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let gh_iv = UIImageView()
    let search_textfield = GHTextField()
    let search_button = GHButton(backgroundColor: .systemGreen, title: "Get User")
    let alertView = AlertView(title: "Empty Username",
                              message: "Please enter a username. We need to know who to look for 😀.",
                              buttonTitle: "Ok")
    var isUserTyped: Bool { return !search_textfield.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createGHImage()
        createSearchTextfield()
        createSearchButton()
        dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        navigationController?.isNavigationBarHidden = true
    }
    
}
//MARK: - UI
extension SearchVC {
    
    //MARK: - create `Github` Image layout
    fileprivate func createGHImage() {
        view.addSubview(gh_iv)
        gh_iv.translatesAutoresizingMaskIntoConstraints = false
        gh_iv.image = UIImage(named: "gh-logo")!
        NSLayoutConstraint.activate([
            gh_iv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
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
    func createAlertView() {
        alertView.dismissButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        view.addSubview(alertView.dismissButton)
        view.addSubview(alertView)
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            alertView.widthAnchor.constraint(equalToConstant: 280),
            alertView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
    }

    func dismissKeyboard() {
        let tab = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tab)
    }
    @objc func dismissAlert() {
        alertView.dismissButton.removeFromSuperview()
        alertView.removeFromSuperview()
       }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        validateTextfield()
        return true
    }
    func validateTextfield() {
        guard isUserTyped else {
            createAlertView()
            return
        }
        let userDetails = UserDetailsVC()
        userDetails.username = search_textfield.text
        navigationController?.pushViewController(userDetails, animated: true)
    }
    

}
