//
//  Constants.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 12/02/2021.
//

import UIKit


enum Constants {
    
    enum Strings {
        enum Title {
            static let viewOwnerProfile         = "View Owner Profile"
            static let ok                       = "Ok"
            static let somethingsWrong          = "something went wrong"
            static let unableToCompleteRequest  = "unable to comlete request"
            static let searchRepos              = "Search Repositories"
            static let oops                     = "Oops"
            static let search                   = "Search"
            static let emptySearch              = "Empty Search"
            static let alreadyFaved             = "Already Favourited"
            static let faved                    = "Saved to Favourited"
            static let delete                   = "Delete"
            static let clickReadMe              = "Click here to view README"
            static let faveSearches             = "Favourite Searches"
        }
        
        enum Messages {
            static let inputRepo                = "Please input a repository name to start your search."
            static let alreadyFaved             = "It appears that you have already favourited this search."
            static let faved                    = "Congratulations you have succesfully favourited this search."
            static let emptyRepo                = "Could not find any repositories with your current search. Go back and try again"
            static let noFaves                  = "Could not find any Favourite Searches. Go and favourite some"
            static let noDescription            = "No description to show"
        }
        
        enum ElementTitles {
            static let language                 = "Language:"
            static let score                    = "Score:"
            static let forks                    = "Forks:"
            static let issues                   = "Issues:"
            static let watchers                 = "Watchers:"
        }
    }
    
    enum Images {
        static let emptyStateImage              = UIImage(named: "empty-state")
        static let avatarPlaceHolderImage       = UIImage(named: "avatar-placeholder")
        static let ghLogo                       = UIImage(named: "gh-logo")
        
        enum ElementImages {
            static let language                 = UIImage(systemName: "captions.bubble.fill")
            static let score                    = UIImage(systemName: "star.fill")
            static let forks                    = UIImage(systemName: "tuningfork")
            static let issues                   = UIImage(systemName: "staroflife.fill")
            static let watchers                 = UIImage(systemName: "eye.fill")
        }
    }
}
