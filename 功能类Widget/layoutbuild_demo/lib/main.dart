import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OrientationBuilder'),
//       ),
//       body: OrientationBuilder(
//         builder: (BuildContext context, Orientation orientation) {
//           if (orientation == Orientation.portrait) {
//             return const Text('竖屏');
//           } else {
//             return const Text('横屏');
//           }
//         },
//       ),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LayoutBuild'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 400) {
            return const SmallScreen();
          } else {
            return const BigScreen();
          }
        },
      ),
    );
  }
}

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('屏幕宽度小于400'),
        Text('屏幕宽度小于400'),
      ],
    );
  }
}

class BigScreen extends StatelessWidget {
  const BigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('屏幕宽度大于400'),
        Text('屏幕宽度大于400'),
        Text('屏幕宽度大于400'),
      ],
    );
  }
}
