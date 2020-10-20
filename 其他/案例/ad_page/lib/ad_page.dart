import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './content.dart';

class ADPage extends StatefulWidget {
  @override
  _ADPageState createState() => _ADPageState();
}

class _ADPageState extends State<ADPage> {
  Timer timer;
  int count = 5;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (count > 1) {
          count--;
        } else {
          timer.cancel();
          protocol();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          children: <Widget>[
            // 可以改为network
            Image.asset(
              'images/bg_image.jpg',
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 45,
              right: 15,
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x52000000),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: 75,
                  height: 25,
                  child: Center(
                    child: Text(
                      '跳过(${count}s)',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                onTap: () {
                  timer.cancel();
                  protocol();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  protocol() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => new Content(),
      ),
    );
  }
}
