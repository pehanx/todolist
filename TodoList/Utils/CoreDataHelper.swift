//
//  CoreDataHelper.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//

import CoreData
import UIKit

final class CoreDataHelper {
    static func context() async -> NSManagedObjectContext {
        guard let appDelegate = await UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = await appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }
}
