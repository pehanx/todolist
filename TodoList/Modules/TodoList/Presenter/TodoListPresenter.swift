//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

final class TodoListPresenter: TodoListPresenterProtocol {
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorProtocol?
    var router: TodoListRouterProtocol?

    func viewDidLoad() {
        let isFetchedDummyJson = UserDefaults.standard.bool(forKey: Constants.UserDefaults.isFetchedDummyJsonKey)
        if !isFetchedDummyJson {
            interactor?.fetchDummyTodos()
            UserDefaults.standard.setValue(true, forKey: Constants.UserDefaults.isFetchedDummyJsonKey)
        }
        interactor?.fetchTodoItems()
    }

    func saveTodoItem(title: String, subtitle: String) {
        interactor?.saveTodoItem(title: title, subtitle: subtitle)
    }
    
    func deleteTodoItem(at indexPath: IndexPath) {
        interactor?.deleteTodoItem(at: indexPath)
    }
    
    func updateTodoItem(at indexPath: IndexPath) {
        interactor?.updateTodoItem(at: indexPath)
    }
    
    func didCompleteTodoItem() {
        interactor?.saveTodoItemAndReload()
    }
    
    func didUnCompleteTodoItem() {
        interactor?.saveTodoItemAndReload()
    }
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    func didFetchTodoItems(_ todoSections: TodoSections) {
        view?.displayTodoItems(todoSections)
    }

    func didFailToFetchTodoItems(with error: Error) {
        view?.displayError("Failed to fetch items: \(error.localizedDescription)")
    }
    
    func didDeleteTodoItem(at indexPath: IndexPath) {
        view?.didRemoveRow(at: indexPath)
    }
    
    func didFailToDeleteTodoItem(with error: Error) {
        view?.displayError("Failed to delete item: \(error.localizedDescription)")
    }
    
    func didUpdateTodoItem(at indexPath: IndexPath) {
        view?.didUpdateRow(at: indexPath)
    }
    
    func didFailToUpdateTodoItem(with error: any Error) {
        view?.displayError("Failed to update item: \(error.localizedDescription)")
    }
}
