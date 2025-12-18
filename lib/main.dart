import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: TodoApp()));
}

// Todo Model
class Todo {
  String title;
  bool isCompleted;

  Todo({required this.title, this.isCompleted = false});
}

// Main Todo App
class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = []; // Local (no database)

  // Add Todo
  void addTodo() {
    if (todoController.text.isEmpty) return;

    setState(() {
      todos.add(Todo(title: todoController.text));
      todoController.clear();
    });
  }

  // Delete Todo
  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  // Toggle Complete
  void toggleComplete(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List"), centerTitle: true),

      body: Column(
        children: [
          // Input Field + Add Button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                      hintText: "Enter todo...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: addTodo, child: const Text("Add")),
              ],
            ),
          ),

          // Todo List
          Expanded(
            child: todos.isEmpty
                ? const Center(
                    child: Text(
                      "No todos yet. Add one!",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: todos[index].isCompleted,
                            onChanged: (value) => toggleComplete(index),
                          ),

                          title: Text(
                            todos[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              decoration: todos[index].isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),

                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTodo(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
