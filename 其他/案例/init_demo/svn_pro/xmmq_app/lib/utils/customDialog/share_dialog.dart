/*
* 分享Dialog
* */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ShareDialog extends Dialog {
  String loadingText;
  bool outsideDismiss;
  Function dismissCallback;
  Function okCallback;
  Function otherCallback;

  ShareDialog({
    Key key,
    this.loadingText = "我是自定义标题",
    this.outsideDismiss = true,
    this.dismissCallback,
    this.okCallback,
    this.otherCallback,
  }) : super(key: key);

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

    _otherCallback() {
      if (otherCallback != null) {
        otherCallback();
      }
      Navigator.of(context).pop();
    }

    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 300.0,
          height: 300.0,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: Image.asset(
                        'assets/img_wechat_share.png',
                        width: 65.0,
                        height: 65.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        '去分享',
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(36),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/icon_share_friend_tick.png',
                                width: 20,
                                height: 20,
                              ),
                              Text(
                                '  文字已自动复制',
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 5),
//                        child: Row(
//                          children: <Widget>[
//                            Image.asset(
//                              'assets/icon_share_friend_tick.png',
//                              width: 20,
//                              height: 20,
//                            ),
//                            Text(
//                              '  图片已下载至手机',
//                              style: TextStyle(fontSize: 14),
//                            )
//                          ],
//                        ),
//                      )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1, color: Color(0xFFDDDDDD)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: outsideDismiss ? _otherCallback : null,
                            child: Container(
                              height: 50,
                              width: 150,
                              child: Center(
                                child: Text(
                                  '分享给好友',
                                  style: TextStyle(
                                    color: Color(0xFFFFAD4C),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: Color(0xFFDDDDDD), width: 1),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: outsideDismiss ? _okCallback : null,
                            child: Container(
                              height: 50,
                              width: 150,
                              child: Center(
                                child: Text(
                                  '打开朋友圈',
                                  style: TextStyle(
                                    color: Color(0xFFFFAD4C),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: Color(0xFFDDDDDD), width: 1),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: outsideDismiss ? _dismissDialog : null,
                  child: Icon(
                    Icons.cancel,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
