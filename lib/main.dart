import 'package:flutter/material.dart';

import 'models/room.dart';
import 'room_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kraftwerk App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kraftwerk Räume'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  List<Room> rooms = [Room(name: 'Wendelstein', description: 'Ist es ein Raum? Ist es ein Berg?', numberOfSeats: 6)];

  void _incrementCounter() {
    setState(() {
      // rooms.add('value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: rooms.map((room) {
            return ListTile(
              title: Text(room.name),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoomPage(key: ValueKey(room.hashCode), room: room)),
              ),
            );
          }).toList(),	
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add room',
        child: const Icon(Icons.add),
      ),
    );
  }
}
