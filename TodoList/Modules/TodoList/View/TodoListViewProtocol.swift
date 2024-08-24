//
//  TodoListViewProtocol.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

protocol TodoListViewProtocol: AnyObject {
    var presenter: TodoListPresenterProtocol? { get set }
    func displayTodoItems(_ todoSections: TodoSections)
    func displayError(_ error: String)
    func didRemoveRow(at indexPath: IndexPath)
    func didUpdateRow(at indexPath: IndexPath)
}
