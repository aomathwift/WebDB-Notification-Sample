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
        HStack(alignment: .center, spacing: 5) {
            if taskItem.priority == Priority.high.rawValue {
                Image(systemName: "clock")
            } else {
                Image(systemName: "list.bullet.circle")
            }
            Text(taskItem.content)
            Spacer()
            Text(taskItem.date, formatter: formatter)
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
