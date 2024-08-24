//
//  TodoListInteractorProtocol.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

protocol TodoListInteractorProtocol: AnyObject {
    var presenter: TodoListInteractorOutputProtocol? { get set }
    func fetchDummyTodos()
    func fetchTodoItems()
    func saveTodoItem(title: String, subtitle: String)
    func deleteTodoItem(at indexPath: IndexPath)
    func updateTodoItem(at indexPath: IndexPath)
    func saveTodoItemAndReload()
}
