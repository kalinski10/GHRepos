//
//  Repo.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import Foundation

struct Search: Codable {
    let totalCount: Int // could use this for an extra feature
    let items: [Repo]
}

struct Repo: Codable, Hashable {
    let name:               String
    let owner:              User
    let htmlUrl:            String
    var description:        String?
    let createdAt:          Date
    let watchersCount:      Int
    var language:           String?
    let forksCount:         Int
    let openIssuesCount:    Int
    let score:              Int
//    let subscribersCount:   Int
}
