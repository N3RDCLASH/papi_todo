import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:papi_todo/ui/todo/todo_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../done_todos/done_todos_view.dart';
import '../open_todos/open_todos_view.dart';

class TodoView extends HookWidget {
  const TodoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        // The number of tabs / content sections to display.
        length: 2,
        child: ViewModelBuilder<TodoViewModel>.reactive(
          builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[900],
              title: Text('Papi Todo'),
              leading: Container(),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.assignment)),
                  Tab(icon: Icon(Icons.assignment_turned_in)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                OpenTodosView(),
                DoneTodosView(),
              ],
            ),
          ),
          viewModelBuilder: () => TodoViewModel(),
        ), // Complete this code in the next step.
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
                        decoration: InputDecoration(
                          hintText: 'Add a Todo',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent[400], width: 2.0),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Add a description',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent[400], width: 2.0),
                          ),
                        )),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        model.deleteTodo(index);
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

void createTodo(model, context) {
  var todoController = TextEditingController();
  var descriptionController = TextEditingController();
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
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent[400], width: 2.0),
                            ),
                            hintText: 'Add a Todo'),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent[400], width: 2.0),
                          ),
                          hintText: 'Add a Description'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.green[600],
                      child:
                          Text("Create", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (todoController.text != '') {
                          model.addTodo(
                              todoController.text, descriptionController.text);
                          Navigator.of(context).pop();
                          todoController.clear();
                          descriptionController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
