//
//  NotificationSampleApp.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import SwiftUI

@main
struct NotificationSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TaskItemListView()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
    }
}
