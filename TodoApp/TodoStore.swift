import Foundation

@Observable
class TodoStore {
    var items: [TodoItem] = [] {
        didSet { save() }
    }

    private static let storageKey = "todoItems"

    init() {
        load()
    }

    func add(_ title: String) {
        let item = TodoItem(title: title)
        items.insert(item, at: 0)
    }

    func toggle(_ item: TodoItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isCompleted.toggle()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: Self.storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: Self.storageKey),
              let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) else { return }
        items = decoded
    }
}
