// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:stacked/stacked.dart';
// import 'single_todo_viewmodel.dart';

// class SingleTodoView extends HookWidget {
//   const SingleTodoView({Key key}) : super(key: key);
// var todoController = TextFieldController()
//   @override
//   Widget build(BuildContext context) {
//     return new WillPopScope(
//       onWillPop: () async => false,
//       child: DefaultTabController(
//         // The number of tabs / content sections to display.
//         length: 2,
//         child: ViewModelBuilder<SingleTodoViewModel>.reactive(
//           builder: (context, model, child) => Scaffold(
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Column(children: [
//                   TextField(controller: ,),
//                   TextField(),
//                 ],),
//               ),
//             ),
//           ),
//           viewModelBuilder: () => SingleTodoViewModel(),
//         ), // Complete this code in the next step.
//       ),
//     );
//   }
// }
