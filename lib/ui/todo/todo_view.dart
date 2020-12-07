import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sqflite_migration_example/ui/todo/todo_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TodoView extends HookWidget {
  const TodoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = useTextEditingController();
    var descriptionController = useTextEditingController();

    return new WillPopScope(
      onWillPop: () async => false,
      child: ViewModelBuilder<TodoViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            leading: Container(),
            title: Text(model.title),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (todoController.text != '') {
                model.addTodo(todoController.text, descriptionController.text);
                todoController.clear();
                descriptionController.clear();
              }
            },
            child: !model.isBusy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(hintText: 'Add a todo'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(hintText: 'Add a description'),
                  ),
                ),
                SizedBox(height: 20),
                if (model.dataReady && model.data.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: model.data.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        height: 80,
                        child: Card(
                          color: Colors.white,
                          child: InkWell(
                            // When the user taps the button, show a snackbar.
                            onTap: () {
                              // Scaffold.of(context).showSnackBar(SnackBar(
                              //   content: Text('Tap'),
                              // ));
                              showSingleTodo(
                                  model, context, model.data[index], index);
                              print(model.data);
                            },
                            child: ListTile(
                              title: Text(model.data[index].title ?? 'title'),
                              subtitle: Text(model.data[index].description ??
                                  'description'),
                              trailing: Listener(
                                key: Key(model.data[index].id.toString()),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.redAccent,
                                ),
                                onPointerDown: (pointerEvent) =>
                                    model.setCompleteForItem(index, true),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (model.dataReady && model.data.isEmpty)
                  Text('No todo\'s yet. Add some'),
              ],
            ),
          ),
        ),
        viewModelBuilder: () => TodoViewModel(),
      ),
    );
  }
}

void showSingleTodo(model, context, data, index) {
  var todoController = TextEditingController();
  var descriptionController = TextEditingController();
  todoController.text = data.title;
  descriptionController.text = data.description;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: todoController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: descriptionController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Save"),
                      onPressed: () {
                        model.updateTodo(index, todoController.text,
                            descriptionController.text);
                        Navigator.of(context).pop();
                        todoController.clear();
                        descriptionController.clear();
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
}
