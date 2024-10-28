import 'package:flutter/material.dart';
import 'second_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _controller = TextEditingController();

  void _navigateToSecondScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SecondScreen(inputText: _controller.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _navigateToSecondScreen,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
