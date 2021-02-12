//
//  User.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import Foundation

struct User: Codable, Hashable {
    var login:      String
    var avatarUrl:  String
    var htmlUrl:    String
}
