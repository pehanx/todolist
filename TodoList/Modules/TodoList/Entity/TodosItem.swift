//
//  TodosItem.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

struct TodosItems: Decodable {
    let todos: [TodosItem]
}

struct TodosItem: Decodable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
