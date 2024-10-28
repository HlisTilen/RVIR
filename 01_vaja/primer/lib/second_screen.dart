import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String inputText;

  const SecondScreen({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    List<String> items = ["Dummy 1", "Dummy 2", inputText];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}
