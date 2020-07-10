//
//  UserDetailsVC.swift
//  iGitHub
//
//  Created by Eslam on 7/9/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import UIKit

class UserDetailsVC: UIViewController {
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = username
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
