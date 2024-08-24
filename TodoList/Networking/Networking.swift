//
//  Networking.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import Foundation

final class Networking {
    
    static func fetchDummyTodos(completion: @escaping (Result<TodosItems, Error>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: Constants.API.todosURL)!)
        let task = URLSession(configuration: .default).dataTask(with: urlRequest) { data, url, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let objects = try JSONDecoder().decode(TodosItems.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(objects))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
