import 'package:flutter/material.dart';

class BottomBarItem {
  BottomBarItem({this.imageIcon, this.imageSelectedIcon, this.text});

  Image imageIcon;
  Image imageSelectedIcon;
  String text;
}

class BottomBar extends StatefulWidget {
  BottomBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }

  final List<BottomBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                widget.centerItemText ?? '',
                style: TextStyle(color: widget.color, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    BottomBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Image icon =
        _selectedIndex == index ? item.imageSelectedIcon : item.imageIcon;

    Color resultColor =
        _selectedIndex == index ? widget.selectedColor : widget.color;

    return Expanded(
      child: SizedBox(
        height: widget.height - 3,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
//              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                icon,
                Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Text(
                    item.text,
                    style: TextStyle(color: resultColor, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
