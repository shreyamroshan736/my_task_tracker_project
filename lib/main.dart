import 'package:flutter/material.dart';

void main() {
  runApp(TaskTrackerApp());
}

class Task {
  String title;
  String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class TaskTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskTrackerScreen(),
    );
  }
}

class TaskTrackerScreen extends StatefulWidget {
  @override
  _TaskTrackerScreenState createState() => _TaskTrackerScreenState();
}

class _TaskTrackerScreenState extends State<TaskTrackerScreen> {
  List<Task> tasks = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].description),
                  leading: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (newValue) {
                      setState(() {
                        tasks[index].isCompleted = newValue!;
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      String title = titleController.text.trim();
                      String description = descriptionController.text.trim();

                      if (title.isNotEmpty && description.isNotEmpty) {
                        tasks.add(Task(
                          title: title,
                          description: description,
                        ));
                        titleController.clear();
                        descriptionController.clear();
                      } else {
                        // Handle empty fields error
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text('Please fill out all fields.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
