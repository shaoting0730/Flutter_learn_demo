import 'package:flutter/material.dart';
import 'package:verification_code_page/page/other_page.dart';
import 'package:verification_code_page/vertify_button.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VerificationPage'),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return const OtherPage();
              }));
            },
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: Text('push'),
            ),
          ),
          VerificationCodeButton(
            'login_vertify_button',
                () async {
              return false;
            },
            disableStyle: const TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
