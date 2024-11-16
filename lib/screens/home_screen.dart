import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _tasks = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Эмуляция загрузки задач
  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });

    // Эмуляция длительной загрузки данных
    await Future.delayed(const Duration(seconds: 2), () {
      _tasks = ["Задача 1: Изучить Flutter", "Задача 2: Добавить асинхронную логику"];
    });

    setState(() {
      _isLoading = false;
    });
  }

  // Эмуляция сохранения данных
  Future<void> _saveTasks() async {
    setState(() {
      _isLoading = true;
    });

    // Эмуляция длительного сохранения данных
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Данные сохранены!')),
    );
  }
  // Удаляем задачу по индексу
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Добавление новой задачи в список
  void _addTask() {
    setState(() {
      _tasks.add("Новая задача ${_tasks.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade700,
        title: const Text('Goals and Tasks Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTasks,
            tooltip: 'Сохранить задачи',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Показ индикатора загрузки
          : Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.lightBlue.shade100,
              child: _tasks.isEmpty
                  ? const Center(
                child: Text(
                  'Нет задач. Добавьте новую!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              )
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_tasks[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteTask(index); // Удаление задачи
                      },
                      tooltip: 'Удалить задачу',
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.lightBlue.shade700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      context.go('/profile');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Profile'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/tasks');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Tasks'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addTask();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Add Task'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/settings');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Settings'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
