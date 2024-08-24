//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import UIKit

typealias TodoSections = [TodoSection]

final class TodoListViewController: UIViewController, TodoListViewProtocol {
    // MARK: - Properties
    var presenter: TodoListPresenterProtocol?
    var todoSections: TodoSections = []
    
    // MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoItemTableViewCell.self, forCellReuseIdentifier: TodoItemTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
        return tableView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Helpers
    private func setupView() {
        navigationItem.title = "Todo list"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didAddTodoItem))
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func didAddTodoItem() {
        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Title"
        }
        alert.addTextField { textField in
            textField.placeholder = "Subtitle"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            let title = alert.textFields?[0].text ?? ""
            let subtitle = alert.textFields?[1].text ?? ""
            self?.presenter?.saveTodoItem(title: title, subtitle: subtitle)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

extension TodoListViewController {
    func displayTodoItems(_ todoDictionary: TodoSections) {
        self.todoSections = todoDictionary
        self.tableView.reloadData()
    }

    func displayError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    
    func didRemoveRow(at indexPath: IndexPath) {
        todoSections[indexPath.section].items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func didUpdateRow(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
