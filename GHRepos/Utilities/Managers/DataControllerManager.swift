//
//  DataControllerManager.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 12/02/2021.
//

import UIKit
import CoreData

class DataControllerManager {
    
    static let shared   = DataControllerManager()
    let context         = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}

    
    func fetchSearches(completed: (Result<[RepoSearches], GRError>) -> Void) {
        do {
            let searches: [RepoSearches] = try context.fetch(RepoSearches.fetchRequest())
            completed(.success(searches))
        } catch {
            completed(.failure(.invalidData))
        }
    }
    
    func saveSearches() {
        do {
            try context.save()
        } catch {
            print(GRError.invalidData.rawValue)
        }
    }
    
}
