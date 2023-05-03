import 'package:flutter/material.dart';

void main() => runApp(TodoListApp());

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = [];
  List<bool> completed = [];

  void handleNavigate () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodoScreen()),
    ).then((value) {
      if (value != null) {
        setState(() {
          todos.add(value);
          completed.add(false);
        });
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: todos.isEmpty
          ? const Center(
              child: Text(
                'There is nothing to do for now!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditTodoScreen(todo: todos[index]),
                      ),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          todos[index] = value;
                        });
                      }
                    });
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Checkbox(
                        value: completed[index],
                        onChanged: (newValue) {
                          setState(() {
                            completed[index] = newValue!;
                          });
                        },
                      ),
                      title: Text(todos[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            todos.removeAt(index);
                            completed.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: handleNavigate,
        child: const Icon(Icons.note_alt_rounded),
      ),
    );
  }
}

class AddTodoScreen extends StatelessWidget {
  final _textController = TextEditingController();

  AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a task'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter task title',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
            ),
            child: const Text('Save'),
            onPressed: () {
              Navigator.pop(context, _textController.text);
            },
          ),
        ],
      ),
    );
  }
}

class EditTodoScreen extends StatelessWidget {
  final String todo;
  final _textController = TextEditingController();

  EditTodoScreen({super.key, required this.todo}) {
    _textController.text = todo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter task title',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
            ),
            child: const Text('Save'),
            onPressed: () {
              Navigator.pop(context, _textController.text);
            },
          ),
        ]
      )
    );
  }
}
