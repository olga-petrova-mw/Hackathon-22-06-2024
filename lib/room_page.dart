import 'package:flutter/material.dart';
import 'models/room.dart';

class RoomPage extends StatelessWidget {
  final Room room;

  const RoomPage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Raumdetails'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Name: ${room.name}'),
            Text('Description: ${room.description}'),
            Text('Roomsize: ${room.numberOfSeats}'),
          ],
        ),
      ),
    );
  }
}
