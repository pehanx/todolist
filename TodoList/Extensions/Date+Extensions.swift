//
//  Date+Extensions.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.string(from: self)
    }
    
}
