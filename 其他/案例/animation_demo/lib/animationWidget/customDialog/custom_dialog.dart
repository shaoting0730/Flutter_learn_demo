import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDialog extends Dialog {
  String loadingText;
  bool outsideDismiss;
  Function dismissCallback;
  Function okCallback;

  CustomDialog(
      {Key key,
      this.loadingText = "我是自定义标题",
      this.outsideDismiss = true,
      this.dismissCallback,
      this.okCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _dismissDialog() {
      if (dismissCallback != null) {
        dismissCallback();
      }
      Navigator.of(context).pop();
    }

    _okCallback() {
      if (okCallback != null) {
        okCallback();
      }
      Navigator.of(context).pop();
    }

    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 300.0,
          height: 300.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    loadingText,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
                Icon(Icons.add_shopping_cart, size: 200),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: outsideDismiss ? _okCallback : null,
                      child: Text(
                        '确定',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    InkWell(
                      onTap: outsideDismiss ? _dismissDialog : null,
                      child: Text('删除'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
