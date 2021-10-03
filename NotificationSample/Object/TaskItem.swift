//
//  TaskItem.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import Foundation
import CoreData

extension TaskItem {
    static func create(
        in managedObjectContext: NSManagedObjectContext,
        content: String,
        taskType: String,
        date: Date?
    ) {
        let newObject = self.init(context: managedObjectContext)
        newObject.content = content
        newObject.taskType = taskType
        newObject.date = date
        newObject.id = UUID().uuidString
        do {
            try managedObjectContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    override public func didChangeValue(forKey key: String) {
        super.didChangeValue(forKey: key)
        objectWillChange.send()
    }
}

extension Collection where Element == TaskItem, Index == Int {
    func delete(at indices: IndexSet, from managedObjectContext: NSManagedObjectContext) {
        indices.forEach { managedObjectContext.delete(self[$0]) }
        do {
            try managedObjectContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
