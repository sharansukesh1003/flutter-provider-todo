import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tut/providers/importanttodoprovider.dart';
import 'package:provider_tut/providers/todoprovider.dart';
import 'package:provider_tut/views/addtodoscreen.dart';
import 'package:provider_tut/views/importanttodoscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Consumer<ImportantTodoProvider>(
              builder: (builder, impTodoProvider, _) {
            return Icon(
              Icons.star,
              color: impTodoProvider.list.isEmpty ? Colors.white : Colors.amber,
            );
          }), onPressed: (() {
            Navigator.of(context).push(_importantTodoRoute());
          })),
          elevation: 0,
          centerTitle: true,
          title: const Text("Todo's"),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: (() {
                  Navigator.of(context).push(_addTodoRoute());
                }))
          ],
        ),
        body: Consumer<TodoProvider>(builder: (builder, todoProvider, _) {
          if (todoProvider.list.isEmpty) {
            return const Center(child: Text("All todo's done."));
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: todoProvider.list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Consumer<ImportantTodoProvider>(
                                builder: (builder, impTodoProvider, _) {
                              return IconButton(
                                  icon: Icon(Icons.star,
                                      color: impTodoProvider.list.contains(
                                              todoProvider.list[index])
                                          ? Colors.amber
                                          : Colors.grey),
                                  onPressed: (() {
                                    if (!impTodoProvider.list
                                        .contains(todoProvider.list[index])) {
                                      impTodoProvider.addListItem(
                                          todoProvider.list[index]);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.blue,
                                        duration: Duration(milliseconds: 1000),
                                        content:
                                            Text("Todo marked as important."),
                                      ));
                                    } else {
                                      impTodoProvider.removeListItem(
                                          todoProvider.list[index]);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.blue,
                                        duration: Duration(milliseconds: 1000),
                                        content: Text(
                                            "Todo removed from important."),
                                      ));
                                    }
                                  }));
                            }),
                            title: Text(todoProvider.list[index]),
                            trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: (() {
                                  Provider.of<ImportantTodoProvider>(context,
                                          listen: false)
                                      .removeListItem(todoProvider.list[index]);
                                  todoProvider.deleteListItem(index);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.blue,
                                    duration: Duration(milliseconds: 1000),
                                    content: Text("Todo Deleted."),
                                  ));
                                })),
                          ),
                        );
                      }),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Route _importantTodoRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ImportantTodoScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _addTodoRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddTodoScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
