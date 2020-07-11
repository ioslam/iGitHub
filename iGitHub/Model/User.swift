//
//  User.swift
//  iGitHub
//
//  Created by Eslam on 7/10/20.
//  Copyright © 2020 ioslam.co. All rights reserved.
//

import Foundation
struct User: Codable {
let login: String
    let id: Int
let nodeID: String?
let avatarUrl: String
let gravatarID: String?
let url, htmlURL, followersURL: String?
let followingURL, gistsURL, starredURL: String?
let subscriptionsURL, organizationsURL, reposURL: String?
let eventsURL: String?
let receivedEventsURL: String?
let type: String?
let siteAdmin: Bool?
let name, company, blog, location: String?
let hireable: Bool?
let bio, twitterUsername: String?
let publicRepos, publicGists, followers, following: Int?
//let createdAt, updatedAt: Date?
}
