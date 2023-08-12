import 'package:flutter/material.dart';
import 'package:state_example/change_notifier_example.dart';
import 'package:state_example/custom_provider/ui/Logo.dart';
import 'package:state_example/custom_provider/model/logo_model.dart';
import 'package:state_example/custom_provider/model/change_notifier_provider.dart';
import 'package:state_example/custom_provider/ui/control_panel.dart';
import 'package:state_example/inherited_widget_example.dart';
import 'package:state_example/value_notifier_example.dart';

void main() {
  runApp(const MyApp());
}
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const InheritedWidgetExample(),
//     );
//   }
// }

/*----------------------------------------------------------------------------------------*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ()=> LogoModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Custom Provider'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(),
                ControlPanel(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
