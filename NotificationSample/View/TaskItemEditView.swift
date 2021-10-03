//
//  TaskItemEditView.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import Combine
import SwiftUI

struct TaskItemEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var taskItem: TaskItem
    var body: some View {
        Text("")
    }
}

struct TaskItemEditView_Previews: PreviewProvider {
    static var previews: some View {
        let taskItem = TaskItem(context: PersistenceController.shared.persistentContainer.viewContext)
        TaskItemEditView(taskItem: taskItem)
    }
}
