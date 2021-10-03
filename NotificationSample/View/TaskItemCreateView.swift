//
//  TaskItemCreateView.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import SwiftUI

struct TaskItemCreateView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var content: String = ""
    @State private var taskType: TaskType = .memo
    @State private var date: Date = Date()
    @Binding var showTaskItemCreateView: Bool
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Picker("Task Type", selection: $taskType) {
                    Text(TaskType.memo.rawValue).tag(TaskType.memo)
                    Text(TaskType.scheduled.rawValue).tag(TaskType.scheduled)
                }
                TextField("Content", text: $content)
                    .textFieldStyle(.roundedBorder)
                if case taskType = TaskType.scheduled {
                    DatePicker("Scheduled Date", selection: $date)
                }
                Button {
                    TaskItem.create(
                        in: viewContext,
                        content: content,
                        taskType: taskType.rawValue,
                        date: date
                    )
                    showTaskItemCreateView.toggle()
                } label: {
                    Text("Register")
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Create Task", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {
                    showTaskItemCreateView.toggle()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
        }
    }
}
