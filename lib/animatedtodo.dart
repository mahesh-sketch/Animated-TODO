import 'package:animatedtodolist/Provider/todoProvider.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class AnimatedTodo extends StatefulWidget {
  const AnimatedTodo({Key? key}) : super(key: key);

  @override
  State<AnimatedTodo> createState() => _AnimatedTodoState();
}

class _AnimatedTodoState extends State<AnimatedTodo> {


  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<TodoProvider>(context,listen: false);
    void removeItem(int index, BuildContext context) {
      AnimatedList.of(context).removeItem(index, (context, animation) {
        return Consumer<TodoProvider>(builder: (context, value, child) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: Card(
                elevation: 0,
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),
                child: ListTile(
                  title: Text(value.item[index], style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                  subtitle: Text(DateTime.now().toString().substring(0,10), style: const TextStyle(fontSize: 12)),
                  trailing: IconButton(
                    onPressed: () => removeItem(index, context),
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ),
            ),
          );
        },);
      });

    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Center(child: Text('T O D O L I S T')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<TodoProvider>(builder: (context, value, child) {
          return AnimatedList(
            key: value.key,
            initialItemCount: value.item.length,
            itemBuilder: (((context, index, animation) {
              return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    key: UniqueKey(),
                    sizeFactor: animation,
                    child: Card(
                      elevation: 0,
                      color: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        title: Text(todoprovider.item[index],
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        subtitle: Text(DateTime.now().toString().substring(0, 10),
                            style: const TextStyle(fontSize: 12,color: Colors.black)),
                        trailing: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            removeItem(index, context);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ));
            })),
          );
        },)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.clear();
          showDialog(
              context: context,
              builder: ((context) {
                return Consumer<TodoProvider>(builder: (context, value, child) {
                  return AlertDialog(
                    title: const Text('Add ToDo List'),
                    content: TextField(
                      controller:  _controller,
                      decoration: const InputDecoration(
                        hintText: 'E.g Meetings and Events',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          value.addItem(_controller.text);
                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      )
                    ],
                  );
                },);

              })
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
