import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papi_todo/ui/done_todos/done_todos_view.dart';
import 'package:stacked/stacked.dart';
import '../todo/todo_view.dart';
import '../done_todos/done_todos_viewmodel.dart';

class DoneTodosView extends StatelessWidget {
  const DoneTodosView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ViewModelBuilder<DoneTodosViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/undraw_Done_checking_re_6vyx.svg',
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      if (model.dataReady && model.data.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemCount: model.data.length,
                            itemBuilder: (context, index) => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              height: 80,
                              child: Card(
                                color: Colors.white,
                                child: InkWell(
                                  // When the user taps the button, show a snackbar.
                                  onTap: () {
                                    // Scaffold.of(context).showSnackBar(SnackBar(
                                    //   content: Text('Tap'),
                                    // ));
                                    showSingleTodo(model, context,
                                        model.data[index], index);
                                    print(model.data);
                                  },
                                  child: ListTile(
                                      title: Text(
                                          model.data[index].title ?? 'title'),
                                      subtitle: Text(
                                          model.data[index].description ??
                                              'description'),
                                      trailing: Listener(
                                        key: Key(
                                            model.data[index].id.toString()),
                                        child: Checkbox(
                                          value: model.data[index].isComplete,
                                          onChanged: (value) => model
                                              .setCompleteForItem(index, value),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (model.dataReady && model.data.isEmpty)
                        Center(child: Text('No todo\'s yet. Finish some')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModelBuilder: () => DoneTodosViewModel(),
      ),
    );
  }
}
