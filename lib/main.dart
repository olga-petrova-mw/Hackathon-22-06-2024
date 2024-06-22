

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/ModelProvider.dart';

import 'amplifyconfiguration.dart';
import 'item_page.dart';

void main() {
  _configureAmplify();
  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugins(
      [
        AmplifyAPI(
          options: APIPluginOptions(
            modelProvider: ModelProvider.instance,
          ),
        ),
      ],
    );
    await Amplify.configure(amplifyConfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e ');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Our Kraftwerk ToDos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kanban Tasks'),
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
  


  List<ToDoItem> _toDoItems = [];

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

Future<void> _refreshTodos() async {
  try {
    final request = ModelQueries.list(ToDoItem.classType);
    final response = await Amplify.API.query(request: request).response;

    final todos = response.data?.items;
    if (response.hasErrors) {
      safePrint('errors: ${response.errors}');
      return;
    }
    setState(() {
      _toDoItems = todos!.whereType<ToDoItem>().toList();
    });
  } on ApiException catch (e) {
    safePrint('Query failed: $e');
  }
}

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
      body: _toDoItems.isEmpty == true
        ? const Center(
            child: Text(
              "The list is empty.\nAdd some items by clicking the floating action button.",
              textAlign: TextAlign.center,
            ),
          )
        : Center(
        child: ListView(
          children: _toDoItems.map((ToDoItem item) {
            return ListTile(
              title: Text(item.title!),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemPage(key: ValueKey(item.hashCode), item: item)),
              ),
            );
          }).toList(),	
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add item',
        child: const Icon(Icons.add),
      ),
    );
  }

}
