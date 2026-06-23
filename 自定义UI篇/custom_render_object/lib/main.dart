import 'package:custom_render_object/MyStack_hitTest.dart';
import 'package:custom_render_object/exmaple/particle_controller.dart';
import 'package:custom_render_object/exmaple/particle_field.dart';
import 'package:custom_render_object/exmaple/render_particle_field.dart';
import 'package:custom_render_object/my_box.dart';
import 'package:custom_render_object/my_container.dart';
import 'package:custom_render_object/my_row.dart';
import 'package:custom_render_object/my_stack.dart';
import 'package:custom_render_object/MyStack_hitTest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ParticleController controller;

  @override
  void initState() {
    super.initState();

    controller = ParticleController(
      count: 1500,
      onUpdate: () {
        final render = key.currentContext?.findRenderObject() as RenderParticleField?;

        render?.markNeedsPaint();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final GlobalKey key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        // child: MyBox(),
        // child: MyContainer(
        //   padding: EdgeInsets.all(200),
        //   color: Colors.blue,
        //   child: Text("Hello RenderObject", style: TextStyle(color: Colors.white)),
        // ),
        // child: MyRow(
        //   spacing: 20,

        //   children: const [
        //     Text("A", style: TextStyle(fontSize: 40)),

        //     Text("B", style: TextStyle(fontSize: 40)),

        //     Text("C", style: TextStyle(fontSize: 40)),
        //   ],
        // ),
        // child: MyStack(
        //   children: [
        //     MyPositioned(left: 0, top: 0, child: Container(width: 150, height: 150, color: Colors.red)),

        //     MyPositioned(left: 80, top: 80, child: Container(width: 150, height: 150, color: Colors.blue)),

        //     MyPositioned(left: 160, top: 160, child: Container(width: 100, height: 100, color: Colors.green)),
        //   ],
        // ),
        // child: MyHitTestStack(
        //   children: [
        //     Listener(
        //       onPointerDown: (_) {
        //         debugPrint("RED CLICKED");
        //       },
        //       child: Container(width: 220, height: 220, color: Colors.red),
        //     ),
        //     Listener(
        //       behavior: HitTestBehavior.translucent,
        //       onPointerDown: (_) {
        //         debugPrint("BLUE CLICKED");
        //       },
        //       child: Container(width: 160, height: 160, color: Colors.blue),
        //     ),
        //     Listener(
        //       onPointerDown: (_) {
        //         debugPrint("GREEN CLICKED");
        //       },
        //       child: Container(width: 100, height: 100, color: Colors.green),
        //     ),
        //   ],
        // ),
        // child: SizedBox(
        //   width: 400,
        //   height: 120,
        //   child: TimelineTrack(
        //     pixelsPerHour: 50,

        //     children: const [
        //       TimelineItem(start: 1, end: 3, label: "Meeting A", child: Text("Meeting A")),

        //       TimelineItem(start: 4, end: 6, label: "Design", child: Text("Design")),

        //       TimelineItem(start: 7, end: 9, label: "Review", child: Text("Review")),
        //     ],
        //   ),
        // ),
        child: Container(
          width: 800,
          height: 800,
          color: Colors.pink,
          child: Listener(
            onPointerMove: (e) {
              final render = key.currentContext?.findRenderObject() as RenderParticleField?;

              if (render == null) return;

              controller.updatePointer(e.localPosition, render.size);
            },
            child: ParticleField(key: key, controller: controller),
          ),
        ),
      ),
    );
  }
}
