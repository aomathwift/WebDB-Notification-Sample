//
//  TaskItemCell.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import Combine
import SwiftUI

struct TaskItemCell: View {
    @ObservedObject var taskItem: TaskItem
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if let date = taskItem.date {
                Image(systemName: "clock")
                Text(taskItem.content ?? "")
                Text(date, formatter: formatter)
            } else {
                Image(systemName: "list.bullet.circle")
                Text(taskItem.content ?? "")
            }
        }
    }

    private var formatter: Formatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        return dateFormatter
    }
}
