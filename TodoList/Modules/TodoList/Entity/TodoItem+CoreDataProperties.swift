//
//  TodoItem+CoreDataProperties.swift
//  TodoList
//
//  Created by Nikita Spekhin on 24.08.2024.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var isCompleted: Bool

}

extension TodoItem : Identifiable {

}
