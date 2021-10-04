//
//  TaskItem+CoreDataProperties.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var content: String
    @NSManaged public var date: Date
    @NSManaged public var id: String
    @NSManaged public var priority: String

}

extension TaskItem : Identifiable {}
