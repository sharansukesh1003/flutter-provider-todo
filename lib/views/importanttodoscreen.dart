import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tut/providers/importanttodoprovider.dart';

class ImportantTodoScreen extends StatelessWidget {
  const ImportantTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text("Imortant Todo's"),
        ),
        body: Consumer<ImportantTodoProvider>(
            builder: (builder, todoProvider, _) {
          if (todoProvider.list.isEmpty) {
            return const Center(child: Text("No todo marked as important."));
          } else {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: todoProvider.list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.label_important,
                        color: Colors.amber,
                      ),
                      title: Text(todoProvider.list[index]),
                    ),
                  );
                });
          }
        }),
      ),
    );
  }
}
