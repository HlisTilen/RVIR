import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Example App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();
  List<String> data = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        setState(() {
          data = (response.data as List)
              .map((item) => item['title'] as String)
              .toList();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  createPost(String title) async {
    try {
      final response =
          await dio.post('https://jsonplaceholder.typicode.com/posts', data: {
        'title': title,
        'body': 'This is a body of the post',
        'userId': 1,
      });
      if (response.statusCode == 201) {
        print('Post Created: ${response.data}');
        fetchData(); // Refresh the list after creating a post
      }
    } catch (e) {
      print(e);
    }
  }

  updatePost(int id, String newTitle) async {
    try {
      final response = await dio
          .put('https://jsonplaceholder.typicode.com/posts/$id', data: {
        'title': newTitle,
      });
      if (response.statusCode == 200) {
        print('Post Updated: ${response.data}');
        fetchData(); // Refresh the list after updating a post
      }
    } catch (e) {
      print(e);
    }
  }

  deletePost(int id) async {
    try {
      final response =
          await dio.delete('https://jsonplaceholder.typicode.com/posts/$id');
      if (response.statusCode == 200) {
        print('Post Deleted');
        fetchData(); // Refresh the list after deleting a post
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio CRUD Example App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter post title',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    createPost(_controller.text);
                    _controller.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // For simplicity, we're using the same text field to update. In a real app, you'd want a separate UI for this.
                          updatePost(index + 1, _controller.text);
                          _controller.clear();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deletePost(index + 1);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
