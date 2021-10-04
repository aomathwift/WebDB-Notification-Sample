//
//  TaskItemCreateView.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import SwiftUI
import UserNotifications

struct TaskItemCreateView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @State private var content: String = ""
    @State private var priority: Priority = .low
    @State private var date: Date = Date()
    @State private var id: String = ""
    private let notificationCenter = UNUserNotificationCenter.current()
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Picker("Task Type", selection: $priority) {
                    Text(Priority.low.rawValue).tag(Priority.low)
                    Text(Priority.high.rawValue).tag(Priority.high)
                }
                TextField("Content", text: $content)
                    .textFieldStyle(.roundedBorder)
                DatePicker("Scheduled Date", selection: $date)
                Button {
                    id = TaskItem.create(
                        in: viewContext,
                        content: content,
                        priority: priority.rawValue,
                        date: date
                    )
                    registerNotification()
                    presentationMode.wrappedValue.dismiss()
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
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
        }
    }

    private func registerNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Reminder"
        notificationContent.body = content
        notificationContent.interruptionLevel = priority.rawValue == Priority.high.rawValue ? .timeSensitive : .active
        notificationContent.relevanceScore = 1.0
        if let imageURL = Bundle.main.url(forResource: "penguin", withExtension: "png"),
           let imageAttachment = try? UNNotificationAttachment(identifier: "ImageAttachment", url: imageURL, options: nil) {
            notificationContent.attachments.append(imageAttachment)
        }
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.locale = Locale(identifier: "ja_JP")
        let dateComponents = DateComponents(
            calendar: calendar,
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: calendar.component(.day, from: date),
            hour: calendar.component(.hour, from: date),
            minute: calendar.component(.minute, from: date)
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
