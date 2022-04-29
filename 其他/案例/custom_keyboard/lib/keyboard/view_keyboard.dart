import 'package:flutter/material.dart';
import './view_pwdfield.dart';
import 'key_event.dart';
import 'keyboard_item.dart';

class CustomKeyboard extends StatefulWidget {
  final Function onKeyDown;
  final Function onResult;
  final bool autoBack;
  final int pwdLength;
  final double keyHeight;

  const CustomKeyboard({required this.onKeyDown, required this.onResult, required this.autoBack, required this.pwdLength, required this.keyHeight});

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  String data = "";

  List<String> keyList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "del", "0", "commit"];

  @override
  void initState() {
    super.initState();
    if (widget.autoBack) {
      keyList[9] = "";
      keyList[11] = "del";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: keyList.length / 3 * widget.keyHeight + 180,
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          pwdWidget(),
          keyboardWidget(),
        ],
      ),
    );
  }

  Widget pwdWidget() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Align(
            child: IconButton(
              icon: const Icon(Icons.close, size: 28),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            alignment: Alignment.topRight,
          ),
          Container(
            width: double.infinity,
            height: 140,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "请输入支付密码",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 250,
                  height: 40,
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomPwdField(data: data, pwdLength: widget.pwdLength),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget keyboardWidget() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      height: keyList.length / 3 * widget.keyHeight,
      child: Wrap(
        children: keyList.map((item) {
          return KeyboardItem(
            keyHeight: widget.keyHeight,
            text: item,
            callback: () => onKeyDown(context, item),
          );
        }).toList(),
      ),
    );
  }

  void onKeyDown(BuildContext context, String text) {
    if ("commit" == text) {
      widget.onResult(data);
      return;
    }
    if ("del" == text && data.isNotEmpty) {
      setState(() {
        data = data.substring(0, data.length - 1);
      });
    }
    if (data.length >= widget.pwdLength) {
      return;
    }
    setState(() {
      if ("del" != text && text != "commit") {
        data += text;
        widget.onKeyDown(KeyDownEvent(text));
      }
    });
    if (data.length == widget.pwdLength && widget.autoBack) {
      widget.onResult(data);
    }
  }
}
