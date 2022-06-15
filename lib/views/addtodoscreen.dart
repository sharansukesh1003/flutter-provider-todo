// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tut/providers/todoprovider.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            centerTitle: true,
            title: const Text("Add Todo"),
          ),
          body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        hintText:
                            "Example - Complete the assignment's by midnight",
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    child: const Text(
                      'ADD TODO',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_textController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.blue,
                          duration: Duration(milliseconds: 1000),
                          content: Text("Please enter a todo."),
                        ));
                        return;
                      }
                      Provider.of<TodoProvider>(context, listen: false)
                          .addListItem(_textController.text);
                      Navigator.pop(context);
                    },
                  ),
                ]),
          )),
    );
  }
}
