import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoApp());
}


class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Página principal 
class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

  // Adiciona uma nova tarefa à lista
  void _addTask() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _tasks.add({'title': text, 'done': false});
        _controller.clear();
      });
    }
  }

  
  void _toggleDone(int index) {
    setState(() {
      _tasks[index]['done'] = !_tasks[index]['done'];
    });
  }

  // Remove uma tarefa da lista
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    children: const [
      Icon(Icons.check_circle_outline, color: Colors.white), //estilizando o icone
      SizedBox(width: 8),
      Text(
        'Lista de Tarefas',
        style: TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  ),
  backgroundColor: const Color.fromARGB(255, 180, 74, 74),//style do appBar (cor)
),
      backgroundColor: const Color.fromARGB(255, 202, 146, 146), //style do layout
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo de entrada e botão de adicionar tarefa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white, // Cor da barrinha de digitação
                    style: const TextStyle(color: Colors.black),
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite a tarefa',
                      hintStyle: TextStyle(color: Colors.black54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Borda 
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Borda 
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Lista de tarefas com checkbox e botão de deletar
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task['done'],
                      onChanged: (_) => _toggleDone(index),
                      activeColor: Colors.white, // Fundo do checkbox 
                      checkColor: Colors.black,  // Cor do check 
                    ),
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        color: Colors.black,
                        decoration: task['done']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () => _deleteTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
