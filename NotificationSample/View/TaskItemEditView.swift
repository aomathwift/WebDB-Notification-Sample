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
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskItem: TaskItem
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Picker("Task Type", selection: $taskItem.taskType) {
                Text(TaskType.memo.rawValue).tag(TaskType.memo.rawValue)
                Text(TaskType.scheduled.rawValue).tag(TaskType.scheduled.rawValue)
            }
            TextField("Content", text: $taskItem.content)
                .textFieldStyle(.roundedBorder)
            if taskItem.taskType == TaskType.scheduled.rawValue {
                DatePicker("Scheduled Date", selection: $taskItem.date)
            }
            Button {
                PersistenceController.shared.saveContext()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Update")
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Edit Task")
    }
}
