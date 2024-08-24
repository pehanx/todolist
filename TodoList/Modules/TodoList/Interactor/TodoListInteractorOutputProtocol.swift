//
//  TodoListInteractorOutputProtocol.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

protocol TodoListInteractorOutputProtocol: AnyObject {
    func didFetchTodoItems(_ todoSections: TodoSections)
    func didFailToFetchTodoItems(with error: Error)
    func didDeleteTodoItem(at indexPath: IndexPath)
    func didFailToDeleteTodoItem(with error: Error)
    func didUpdateTodoItem(at indexPath: IndexPath)
    func didFailToUpdateTodoItem(with error: Error)
}
