import 'dart:convert';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../widgets/topic.dart';
import '../serviceapi/customerapi.dart';
import '../models/api/tag.dart';
import '../models/api/topicModel.dart';
import 'package:flutter/cupertino.dart';
import '../pages/store_dynamic/advanced_search_page.dart';
import '../utils/event_bus.dart';

class SearchFilterPane extends StatefulWidget {
  final Function onClearPressed;
  final Function onSearchPressed;
  bool isPicWall = false;

  SearchFilterPane({
    Key key,
    @required this.isPicWall,
    @required this.onClearPressed,
    @required
        this.onSearchPressed(
            List topicList, List taglist, String txt, bool _otherOnclick),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchFilterPaneState();
  }
}

class SearchFilterPaneState extends State<SearchFilterPane> {
  TagModel _tagModel; // tag 的数据
  TopicModel _toppicModel; // 话题 的数据
  List<String> _selectTagList = []; // 选择的标签
  List<String> _selectToppicList = []; // 选择的话题
  bool _otherOnclick = false; // 是否点击了筛选
  String _selectTimer = '';
  final _editController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomerApi().LoadAllProductTags(context, {}).then((val) {
//      print('请求数据');
      setState(() {
        _tagModel = val;
      });
//      print(jsonEncode(val));
    }).catchError((error) {
      print(error);
    });

    CustomerApi().LoadAllMomentTopics(context, {}).then((val) {
      setState(() {
        _toppicModel = val;
      });
//      print(jsonEncode(val));
    }).catchError((error) {
      print(error);
    });
  }

  //监听Bus events
  void _listen() {
    eventBus.on<CancelSelect>().listen((event) {
//      print(event.tag);

      if (event.tag == false) {
        if (mounted) {
          setState(() {
            _otherOnclick = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _selectTagList = [];
            _selectToppicList = [];
            _editController.text = '';
          });
        }
      }
    });

    eventBus.on<InputValue3>().listen((event) {
      _editController.text = event.str;
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return Container(
      width: double.infinity,
      child: Material(
        type: MaterialType.transparency,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    child: ListView(
                      children: <Widget>[
                        _buildSearchTextArea(), // 搜索栏
                        _buildMyPublishTopicsArea(), // 话题
                        _buidlMyTagsArea(), //标签
//                        _buildOtherArea(), //其他
                      ],
                    ),
                  ),
                  _buildBottomButtonArea(),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 800,
              color: Color.fromRGBO(123, 123, 123, 0.5),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextArea() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF0F0F0),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: CupertinoTextField(
        onChanged: (e) {
          eventBus.fire(new InputValue3(e)); // 先发
        },
        controller: _editController,
        style: TextStyle(fontSize: 14, textBaseline: TextBaseline.alphabetic),
        clearButtonMode: OverlayVisibilityMode.editing,
        placeholder: '请输入搜索关键字',
        cursorColor: Color.fromRGBO(187, 187, 187, 1),
        prefix: Image.asset('assets/icon_home_search.png'),
//        decoration: InputDecoration(
//          hintText: '请输入搜索关键字',
//          hintStyle: TextStyle(fontSize: 14),
//          icon: Image.asset('assets/icon_home_search.png'),
//          fillColor: Colors.blue.shade100,
//          border: InputBorder.none,
//          contentPadding: const EdgeInsets.symmetric(vertical: 8),
//        ),
      ),
    );
  }

  Widget _buildBottomButtonArea() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 50,
//      color: Colors.red,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _selectTimer = '__';
              });
              eventBus.fire(new InputValue3('')); // 先发
              this.widget.onClearPressed();
            },
            child: Container(
              decoration: BoxDecoration(
//                  color: Colors.yellow,
                  border: Border(
                top: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(223, 223, 223, 1),
                ),
              )),
              width: MediaQuery.of(context).size.width / 2,
              height: 49,
              child: Center(
                child: Text(
                  '清空',
                  style: TextStyle(
                    color: Color.fromRGBO(138, 138, 138, 1),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              this.widget.onSearchPressed(
                    _selectToppicList,
                    _selectTagList,
                    _editController.text,
                    _otherOnclick,
                  );
            },
            child: Container(
              color: Color.fromRGBO(253, 174, 48, 1),
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              child: Center(
                child: Text(
                  '确认',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherArea() {
    return InkWell(
      onTap: () {
        print(_otherOnclick);
        if (_otherOnclick == false) {
          eventBus.fire(new CancelSelect(true)); // 先发
          setState(() {
            _otherOnclick = true;
          });
        } else {
          setState(() {
            _otherOnclick = false;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildGroupHeaderArea("其他(非话题，非标签)"),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            color: _otherOnclick == true
                ? Color.fromRGBO(255, 175, 76, 1)
                : Color(0xFFF3F3F3),
            child: Text(
              '其他',
              style: TextStyle(
                color: _otherOnclick == true ? Colors.red : Color(0xFF666666),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 我创建的标签
  Widget _buidlMyTagsArea() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildGroupHeaderArea("我创建的标签"),
            _tagWrapWdiget(),
          ]),
    );
  }

  Widget _tagWrapWdiget() {
    if (_tagModel != null && _tagModel.data.length > 0) {
      if (_tagModel.data.length > 0) {}
      List<Widget> listWidget = _tagModel.data.map((e) {
        var str = e.productTag;
        return TagWidget(
          str: str,
          selectBack: (String tagStr, bool tag) {
            if (mounted) {
              if (tag == true) {
                setState(() {
                  _selectTagList.add(tagStr);
                });
              } else {
                setState(() {
                  _selectTagList.remove(tagStr);
                });
              }
            }
          },
        );
      }).toList();
      return Wrap(spacing: 2, runSpacing: 2, children: listWidget);
    } else {
      return Text('');
    }
  }

  // 我发布的话题
  Widget _buildMyPublishTopicsArea() {
    if (widget.isPicWall == true) {
      return Text('');
//      return Container(
//        padding: EdgeInsets.only(top: 10),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text('按时间选择'),
//            Row(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                InkWell(
//                  onTap: () {
//                    if (_selectTimer == '本周') {
//                      setState(() {
//                        _selectTimer = '';
//                      });
//                    } else {
//                      setState(() {
//                        _selectTimer = '本周';
//                      });
//                    }
//                  },
//                  child: Container(
//                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
//                    color: _selectTimer == '本周'
//                        ? Colors.yellow[200]
//                        : Color(0xFFF3F3F3),
//                    child: Text(
//                      '本周',
//                      style: TextStyle(
//                        color: _selectTimer == '本周'
//                            ? Colors.red
//                            : Color(0xFF666666),
//                      ),
//                    ),
//                  ),
//                ),
//                InkWell(
//                  onTap: () {
//                    if (_selectTimer == '一个月内') {
//                      setState(() {
//                        _selectTimer = '';
//                      });
//                    } else {
//                      setState(() {
//                        _selectTimer = '一个月内';
//                      });
//                    }
//                  },
//                  child: Container(
//                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
//                    color: _selectTimer == '一个月内'
//                        ? Colors.yellow[200]
//                        : Color(0xFFF3F3F3),
//                    child: Text(
//                      '一个月内',
//                      style: TextStyle(
//                        color: _selectTimer == '一个月内'
//                            ? Colors.red
//                            : Color(0xFF666666),
//                      ),
//                    ),
//                  ),
//                ),
//                InkWell(
//                  onTap: () {
//                    if (_selectTimer == '三个月内') {
//                      setState(() {
//                        _selectTimer = '';
//                      });
//                    } else {
//                      setState(() {
//                        _selectTimer = '三个月内';
//                      });
//                    }
//                  },
//                  child: Container(
//                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
//                    color: _selectTimer == '三个月内'
//                        ? Colors.yellow[200]
//                        : Color(0xFFF3F3F3),
//                    child: Text(
//                      '三个月内',
//                      style: TextStyle(
//                          color: _selectTimer == '三个月内'
//                              ? Colors.red
//                              : Color(0xFF666666)),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      );
    } else {
      // 店主动态
      return Container(
        padding: EdgeInsets.only(top: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "我发布的话题",
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
//                  Navigator.of(context).push(
//                    CupertinoPageRoute(
//                      builder: (BuildContext context) {
//                        return AdvancedSearchPage(model: _tagModel);
//                      },
//                    ),
//                  );
                  },
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Color(0xFF999999), fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            _toppicWrapWdiget(),
          ],
        ),
      );
    }
  }

  Widget _toppicWrapWdiget() {
    if (_toppicModel != null && _toppicModel.data.length > 0) {
      List<Widget> listWidget = _toppicModel.data.map((e) {
        var str = e.topicName;
        return TopicWidget(
          str: str,
          selectBack: (String tagStr, bool tag) {
            if (mounted) {
              if (tag == true) {
                eventBus.fire(new CancelSelect(false)); // 先发
                setState(() {
                  _selectToppicList.add(tagStr);
                });
              } else {
                setState(() {
                  _selectToppicList.remove(tagStr);
                });
              }
            }
          },
        );
      }).toList();
      return Wrap(spacing: 2, runSpacing: 2, children: listWidget);
    } else {
      return Text('');
    }
  }

  Widget _buildGroupHeaderArea(var topic) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(children: <Widget>[
        Text(
          topic,
          style: TextStyle(
            color: Color(0xFF999999),
            fontWeight: FontWeight.bold,
          ),
        )
      ]),
    );
  }
}

//话题
class TopicWidget extends StatefulWidget {
  final String str;
  final Function selectBack;
  TopicWidget(
      {Key key,
      @required this.str,
      @required this.selectBack(String str, bool tag)})
      : super(key: key);
  @override
  _TopicWidgettState createState() => _TopicWidgettState();
}

class _TopicWidgettState extends State<TopicWidget> {
  bool _selectTag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //监听Bus events
  void _listen() {
    eventBus.on<CancelSelect>().listen((event) {
      if (event.tag == true) {
        setState(() {
          _selectTag = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return Container(
      child: InkWell(
        onTap: () {
          if (_selectTag == false) {
            widget.selectBack(widget.str, true);
          } else {
            widget.selectBack(widget.str, false);
          }
          setState(() {
            _selectTag = !_selectTag;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _selectTag
                ? Color.fromRGBO(255, 237, 213, 1)
                : Color.fromRGBO(233, 233, 233, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Text(
            '#${widget.str}#',
            style: TextStyle(
              fontSize: 13,
              color: _selectTag
                  ? Color.fromRGBO(232, 96, 25, 1)
                  : Color(0xFF666666),
            ),
          ),
        ),
      ),
    );
  }
}

// 标签
class TagWidget extends StatefulWidget {
  final String str;
  final Function selectBack;
  TagWidget(
      {Key key,
      @required this.str,
      @required this.selectBack(String str, bool tag)})
      : super(key: key);
  @override
  _TagWidgetState createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  bool _selectTag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //监听Bus events
  void _listen() {
    eventBus.on<CancelSelect>().listen((event) {
      if (event.tag == true) {
        if (mounted) {
          setState(() {
            _selectTag = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return Container(
      child: InkWell(
        onTap: () {
          if (_selectTag == false) {
            eventBus.fire(new CancelSelect(false)); // 先发
            widget.selectBack(widget.str, true);
          } else {
            widget.selectBack(widget.str, false);
          }
          setState(() {
            _selectTag = !_selectTag;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
            color: _selectTag
                ? Color.fromRGBO(255, 237, 213, 1)
                : Color.fromRGBO(233, 233, 233, 1),
          ),
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Text(
            widget.str,
            style: TextStyle(
              fontSize: 13,
              color: _selectTag
                  ? Color.fromRGBO(232, 96, 25, 1)
                  : Color(0xFF666666),
            ),
          ),
        ),
      ),
    );
  }
}
