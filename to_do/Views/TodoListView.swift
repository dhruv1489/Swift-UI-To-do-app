import SwiftUI

struct TodoListView: View {
    @State private var todos: [Todo] = []
    @State private var newTodoTitle = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("New Todo", text: $newTodoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }
                
                Section {
                    ForEach($todos) { $todo in
                        HStack {
                            Button(action: {
                                todo.isCompleted.toggle()
                            }) {
                                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.isCompleted ? .green : .gray)
                            }
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                            Spacer()
                        }
                    }
                    .onDelete { indices in
                        todos.remove(atOffsets: indices)
                    }
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addTodo) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    private func addTodo() {
        guard !newTodoTitle.isEmpty else { return }
        let newTodo = Todo(title: newTodoTitle, isCompleted: false)
        todos.append(newTodo)
        newTodoTitle = ""
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
