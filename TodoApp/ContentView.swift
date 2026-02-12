import SwiftUI

struct ContentView: View {
    @State private var store = TodoStore()
    @State private var showingAddSheet = false

    private var pendingItems: [TodoItem] {
        store.items.filter { !$0.isCompleted }
    }

    private var completedItems: [TodoItem] {
        store.items.filter { $0.isCompleted }
    }

    var body: some View {
        NavigationStack {
            Group {
                if store.items.isEmpty {
                    ContentUnavailableView(
                        "No Tasks Yet",
                        systemImage: "checklist",
                        description: Text("Tap the + button to add your first task.")
                    )
                } else {
                    List {
                        if !pendingItems.isEmpty {
                            Section("To Do (\(pendingItems.count))") {
                                ForEach(pendingItems) { item in
                                    TodoRowView(item: item) {
                                        withAnimation { store.toggle(item) }
                                    }
                                }
                                .onDelete { offsets in
                                    let idsToDelete = offsets.map { pendingItems[$0].id }
                                    let storeOffsets = IndexSet(
                                        store.items.indices.filter { idsToDelete.contains(store.items[$0].id) }
                                    )
                                    withAnimation { store.delete(at: storeOffsets) }
                                }
                            }
                        }

                        if !completedItems.isEmpty {
                            Section("Completed (\(completedItems.count))") {
                                ForEach(completedItems) { item in
                                    TodoRowView(item: item) {
                                        withAnimation { store.toggle(item) }
                                    }
                                }
                                .onDelete { offsets in
                                    let idsToDelete = offsets.map { completedItems[$0].id }
                                    let storeOffsets = IndexSet(
                                        store.items.indices.filter { idsToDelete.contains(store.items[$0].id) }
                                    )
                                    withAnimation { store.delete(at: storeOffsets) }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddTodoView { title in
                    withAnimation { store.add(title) }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
