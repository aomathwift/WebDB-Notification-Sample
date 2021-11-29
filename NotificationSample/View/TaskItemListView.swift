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
                    NavigationLink {
                        TaskItemEditView(taskItem: item)
                    } label: {
                        TaskItemCell(taskItem: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .fullScreenCover(isPresented: $showingTaskItemCrateView, content: {
                TaskItemCreateView()
            })
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
            taskItems.delete(at: offsets, from: viewContext)
        }
    }
}
