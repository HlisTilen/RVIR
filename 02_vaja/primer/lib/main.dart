import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/note.dart';

void main() async {
  // Initialize Hive and open the notes box.
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotePage(),
    );
  }
}

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  // Create a method to edit a note.
  Future<void> _editNoteDialog(Note note, int index) async {
    final editController = TextEditingController(text: note.content);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: TextField(
            controller: editController,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final editedNote = Note(editController.text);
                Hive.box<Note>('notes').putAt(index, editedNote);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Example'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Note>('notes').listenable(),
        builder: (context, Box<Note> box, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                    labelText: 'Add Note',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final noteContent = noteController.text;
                  if (noteContent.isNotEmpty) {
                    box.add(Note(noteContent)); // Add the note to the box.
                    noteController.clear();
                  }
                },
                child: Text('Add Note'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final note = box.getAt(index);
                    return ListTile(
                      title: Text(note!.content),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editNoteDialog(note, index); // Edit the note.
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              box.deleteAt(
                                  index); // Delete the note from the box.
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  box.clear(); // Delete all notes from the box.
                },
                child: Text('Delete All Notes'),
              ),
            ],
          );
        },
      ),
    );
  }
}
