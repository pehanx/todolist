//
//  TodoListPresenterProtocol.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

protocol TodoListPresenterProtocol: AnyObject {
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    func viewDidLoad()
    func saveTodoItem(title: String, subtitle: String)
    func deleteTodoItem(at indexPath: IndexPath)
    func updateTodoItem(at indexPath: IndexPath)
    func didCompleteTodoItem()
    func didUnCompleteTodoItem()
}
