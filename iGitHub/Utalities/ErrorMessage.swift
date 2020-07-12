//
//  ErrorMessage.swift
//  iGitHub
//
//  Created by Eslam on 7/11/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import Foundation

enum GHError: String, Error {
    case invalidURL       = "error, check url"
    case invalidUsername  = "error, check your username"
    case unableToComplete = "error, check your internet"
    case invalidResponse  = "error, invalid response, please try again!"
    case invalidData      = "error, invalid data received from the server server"
}
