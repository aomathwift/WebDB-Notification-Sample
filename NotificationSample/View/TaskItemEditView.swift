//
//  TaskItemEditView.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import Combine
import SwiftUI
import UserNotifications

struct TaskItemEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskItem: TaskItem
    private let notificationCenter = UNUserNotificationCenter.current()
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Picker("Task Type", selection: $taskItem.priority) {
                ForEach(Priority.allCases, id: \.rawValue) { priority in
                    Text(priority.rawValue).tag(priority.rawValue)
                }
            }
            TextField("Content", text: $taskItem.content)
                .textFieldStyle(.roundedBorder)
            DatePicker("Scheduled Date", selection: $taskItem.date)
            Button {
                PersistenceController.shared.saveContext()
                updateNotification()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Update")
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Edit Task")
    }

    private func updateNotification() {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [taskItem.id])
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Reminder"
        notificationContent.body = taskItem.content
        notificationContent.interruptionLevel = taskItem.priority == Priority.high.rawValue ? .timeSensitive : .active
        notificationContent.relevanceScore = taskItem.priority == Priority.low.rawValue ? 0.5 : 1.0
        if let imageURL = Bundle.main.url(forResource: "sample-image", withExtension: "png"),
           let imageAttachment = try? UNNotificationAttachment(identifier: "ImageAttachment", url: imageURL, options: nil) {
            notificationContent.attachments.append(imageAttachment)
        }
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.locale = Locale(identifier: "ja_JP")
        let date = DateComponents(
            calendar: calendar,
            year: calendar.component(.year, from: taskItem.date),
            month: calendar.component(.month, from: taskItem.date),
            day: calendar.component(.day, from: taskItem.date),
            hour: calendar.component(.hour, from: taskItem.date),
            minute: calendar.component(.minute, from: taskItem.date)
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(identifier: taskItem.id, content: notificationContent, trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
