//
//  ContentView.swift
//  NotificationSample
//
//  Created by aoi-okawa on 2021/10/04.
//

import SwiftUI
import CoreData

struct TaskItemListView: View {
    @State private var showingTaskItemCrateView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TaskItem.id, ascending: false)], animation: .default)
    private var taskItems: FetchedResults<TaskItem>

    var body: some View {
        NavigationView {
            List {
                ForEach(taskItems, id: \.self) { item in
                    ZStack {
                        TaskItemCell(taskItem: item)
                        NavigationLink(
                            destination: TaskItemEditView(taskItem: item)
                                        .environment(\.managedObjectContext, self.viewContext)
                        ) {
                            EmptyView()
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        showingTaskItemCrateView.toggle()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { taskItems[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
}
