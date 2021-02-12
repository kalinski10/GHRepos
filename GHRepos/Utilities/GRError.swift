//
//  GRError.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 10/02/2021.
//

import Foundation

enum GRError: String, Error {
    case invalidUsername        = "This username created an invalid request. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case invalidResponse        = "invalid response from the server. Please try again."
    case invalidData            = "The data recieved from the server was invalid. Please try again."
    case unableToFavourite      = "There was an error favouriting this user. PLease try again."
    case alreadyInFavourites    = "You've already favourited this user."
}
