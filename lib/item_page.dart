import 'package:flutter/material.dart';
import 'package:myapp/models/ToDoItem.dart';

class ItemPage extends StatelessWidget {
  final ToDoItem item;

  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ToDo-Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Title: ${item.title}'),
            Text('Description: ${item.description}'),
            Text('State: ${item.state}'),
          ],
        ),
      ),
    );
  }
}
