import 'package:flutter/material.dart';
import './login_page.dart';

void main() => runApp(
      MaterialApp(
          title: 'FishDemo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage() //把他作为默认页面
          ),
    );
