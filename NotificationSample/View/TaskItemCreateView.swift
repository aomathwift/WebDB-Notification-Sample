//
//  TaskItemCreateView.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import SwiftUI

struct TaskItemCreateView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var keyboard = KeyboardObserver()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TaskItemCreateView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemCreateView()
    }
}
