import 'package:flutter/material.dart';

class Utils {
  static Future<bool> Function() genOnWillPop(context) {
    Future<bool> gen() {
      return showDialog(
          context: context,
          builder: (builderContext) {
            return AlertDialog(
              title: Text('退出应用吗？'),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(builderContext).pop(false),
                  child: Text('返回'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(builderContext).pop(true),
                  child: Text('退出'),
                ),
              ],
            ) ??
                false;
          });
    }

    return gen;
  }

  static List<T> noNull<T>(List<T> arr)
  {
    return arr.where((o) => o != null).toList();
  }

  static DateTime fromAspDateTimeTicks(int ticks) {
    var epochTicks = 621355968000000000;    // the number of .net ticks at the unix epoch
    var ticksPerMillisecond = 10000;        // there are 10000 .net ticks per millisecond

    //new date is ticks, converted to microtime, minus difference from epoch microtime
    return DateTime.fromMillisecondsSinceEpoch((ticks - epochTicks) ~/ ticksPerMillisecond, isUtc: true);
  }


  static void alert(BuildContext context, {String title, String content, VoidCallback onPressed}) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
              child: Text('确定'),
              onPressed: onPressed ?? () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void confirm(BuildContext context, {String title = '', String content, String cancelText = '取消', String confirmText = '确定', VoidCallback onCancelPressed, VoidCallback onConfirmPressed}) async {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
              child: Text(cancelText),
              onPressed: onCancelPressed ?? () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(confirmText),
              onPressed: onConfirmPressed ?? () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class AimTheme {
  static const textAppbar = TextStyle(color: Colors.black, fontSize: 24);
  static const text12 = TextStyle(fontSize: 12);
  static const text12White = TextStyle(color: Colors.white, fontSize: 12);
  static const text12Red = TextStyle(color: Colors.redAccent, fontSize: 12);
  static const text12Grey = TextStyle(color: Colors.grey, fontSize: 12);
  static const text12BgGrey = TextStyle(backgroundColor: Color(0xFFE0E0E0), fontSize: 12);
  static const text12LineThrough = TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 12);
  static const text16 = TextStyle(fontSize: 16);
  static const text16Red = TextStyle(color: Colors.redAccent, fontSize: 16);
  static const text16Grey = TextStyle(color: Colors.grey, fontSize: 16);
  static const text16White = TextStyle(color: Colors.white, fontSize: 16);
  static const text20White = TextStyle(color: Colors.white, fontSize: 20);
  static const text28White = TextStyle(color: Colors.white, fontSize: 28);
}
