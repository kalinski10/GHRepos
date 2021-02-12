//
//  Date+Ext.swift
//  GHRepos
//
//  Created by Kalin Balabanov on 11/02/2021.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
