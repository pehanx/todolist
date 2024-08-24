//
//  TodoListInteractor.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import CoreData

final class TodoListInteractor: TodoListInteractorProtocol {
    weak var presenter: TodoListInteractorOutputProtocol?
    
    func fetchDummyTodos() {
        DispatchQueue.global(qos: .background).async {
            Networking.fetchDummyTodos { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    Task {
                        for item in response.todos {
                            let newItem = await TodoItem(context: CoreDataHelper.context())
                            newItem.title = item.todo
                            newItem.subtitle = ""
                            newItem.creationDate = Date()
                            newItem.isCompleted = item.completed
                        }
                        do {
                            try await CoreDataHelper.context().save()
                            self.fetchTodoItems()
                        } catch {
                            DispatchQueue.main.async {
                                self.presenter?.didFailToFetchTodoItems(with: error)
                            }
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.presenter?.didFailToFetchTodoItems(with: error)
                    }
                }
            }
        }
    }
    
    func fetchTodoItems() {
        DispatchQueue.global(qos: .background).async {
            let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
            Task {
                do {
                    let items = try await CoreDataHelper.context().fetch(fetchRequest)
                    let todoSections = self.groupTodoItems(items)
                    DispatchQueue.main.async {
                        self.presenter?.didFetchTodoItems(todoSections)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter?.didFailToFetchTodoItems(with: error)
                    }
                }
            }
            
        }
    }
    
    func saveTodoItem(title: String, subtitle: String) {
        DispatchQueue.global(qos: .background).async {
            Task {
                let newItem = await TodoItem(context: CoreDataHelper.context())
                newItem.title = title
                newItem.subtitle = subtitle
                newItem.creationDate = Date()
                newItem.isCompleted = false
                do {
                    try await CoreDataHelper.context().save()
                    self.fetchTodoItems()
                } catch {
                    DispatchQueue.main.async {
                        self.presenter?.didFailToFetchTodoItems(with: error)
                    }
                }
            }
        }
    }
    
    func deleteTodoItem(at indexPath: IndexPath) {
        DispatchQueue.global(qos: .background).async {
            let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
            Task {
                do {
                    let items = try await CoreDataHelper.context().fetch(fetchRequest)
                    await CoreDataHelper.context().delete(items[indexPath.row])
                    try await CoreDataHelper.context().save()
                    DispatchQueue.main.async {
                        self.presenter?.didDeleteTodoItem(at: indexPath)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter?.didFailToDeleteTodoItem(with: error)
                    }
                }
            }
        }
    }
    
    func updateTodoItem(at indexPath: IndexPath) {
        DispatchQueue.global(qos: .background).async {
            Task {
                do {
                    try await CoreDataHelper.context().save()
                    DispatchQueue.main.async {
                        self.presenter?.didUpdateTodoItem(at: indexPath)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter?.didFailToUpdateTodoItem(with: error)
                    }
                }
            }
        }
    }
    
    func saveTodoItemAndReload() {
        DispatchQueue.global(qos: .background).async {
            Task {
                do {
                    try await CoreDataHelper.context().save()
                    let fetchRequest: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
                    let items = try await CoreDataHelper.context().fetch(fetchRequest)
                    let todoSections = self.groupTodoItems(items)
                    DispatchQueue.main.async {
                        self.presenter?.didFetchTodoItems(todoSections)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.presenter?.didFailToFetchTodoItems(with: error)
                    }
                }
            }
        }
    }
}

extension TodoListInteractor {
    private func groupTodoItems(_ items: [TodoItem]) -> TodoSections {
        let todoDictionary = Dictionary(grouping: items) { $0.isCompleted }
        let todoSections: TodoSections = todoDictionary.map { key, value in
                .init(isCompleted: key, items: value.sorted(by: { $0.creationDate ?? Date() > $1.creationDate ?? Date() }))
        }.sorted(by: { !$0.isCompleted && $1.isCompleted })
        return todoSections
    }
}
