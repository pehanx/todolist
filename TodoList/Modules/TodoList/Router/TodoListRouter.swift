//
//  TodoListRouter.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import UIKit

final class TodoListRouter: TodoListRouterProtocol {
    static func createTodoListModule() -> UIViewController {
        let viewController = TodoListViewController()
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        let interactor: TodoListInteractorProtocol = TodoListInteractor()
        let router: TodoListRouterProtocol = TodoListRouter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return viewController
    }
}
