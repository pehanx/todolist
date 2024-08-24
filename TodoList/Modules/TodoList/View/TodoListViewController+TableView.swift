//
//  TodoListViewController+TableView.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import UIKit

extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        todoSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoSections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoItemTableViewCell.reuseIdentifier, for: indexPath) as! TodoItemTableViewCell
        cell.configure(model: todoSections[indexPath.section].items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let todoItem = todoSections[indexPath.section].items[indexPath.row]
        let alert = UIAlertController(title: "Edit Todo", message: "Update your task", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
            textField.text = todoItem.title
        }
        alert.addTextField { textField in
            textField.placeholder = "Subtitle"
            textField.text = todoItem.subtitle
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            let title = alert.textFields?[0].text ?? ""
            let subtitle = alert.textFields?[1].text ?? ""
            todoItem.title = title
            todoItem.subtitle = subtitle
            self?.presenter?.updateTodoItem(at: indexPath)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let todoItem = todoSections[indexPath.section].items[indexPath.row]
        var actions = [UIContextualAction]()
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, handler in
            self?.presenter?.deleteTodoItem(at: indexPath)
        }
        actions.append(deleteAction)
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { [weak self] action, view, handler in
            todoItem.isCompleted = true
            self?.presenter?.didCompleteTodoItem()
        }
        let unCompleteAction = UIContextualAction(style: .normal, title: "Uncomplete") { [weak self] action, view, handler in
            todoItem.isCompleted = false
            self?.presenter?.didUnCompleteTodoItem()
        }
        if todoItem.isCompleted {
            actions.append(unCompleteAction)
        } else {
            actions.append(completeAction)
        }
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if todoSections[section].isCompleted {
            return "Completed"
        } else {
            return "Uncompleted"
        }
    }
}
