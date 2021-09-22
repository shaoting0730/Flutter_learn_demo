import 'package:flutter/material.dart';

typedef OnClearButtonTapCallback = void Function();
typedef OnFilterButtonTapCallback = void Function();
typedef OnSearchCallback = void Function();


class SearchBox extends StatefulWidget {
  
  final OnFilterButtonTapCallback onFilterButtonTap;
  final OnSearchCallback onSearch;
  String placeHolder;
  SearchBox({ this.onFilterButtonTap, Key key, this.placeHolder="Search", this.onSearch = null}): super(key:key);

  @override
  State<StatefulWidget> createState() {
    return SearchBoxState();
  }

}

class SearchBoxState extends State<SearchBox> {

  bool _displayFilterIcon;
  String _text;
  String text() => _text;
  
  bool _enableTextField = true;
  void enableEditing(bool editing) {
    setState(() {
      _enableTextField = editing;
    });
  }

  TextEditingController _editingController = TextEditingController();

  void clear() {
    _editingController.clear();
    setState(() {
      _text = "";
    });
  }

  @override
  void initState() {
    super.initState();
    _displayFilterIcon = false;
    _text = "";
  }

  @override
  Widget build(BuildContext context) {
    var icon = _displayFilterIcon ? 'assets/icon_filter.png' : 'assets/icon_cross.png';
    return Container(
      height: 44,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFF6E7B96))
      ),
      child: Row (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded (
            child:TextField(
              enabled: _enableTextField,
              controller: _editingController,
              onChanged: (text) {
                _text = text;
              },
              onEditingComplete: () {
                if(widget.onSearch!=null)
                  widget.onSearch();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              onSubmitted: (value) {
                if(widget.onSearch!=null)
                  widget.onSearch();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              decoration: InputDecoration(
                border: InputBorder.none, hintText: widget.placeHolder, hintStyle: TextStyle(color: Colors.grey)
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if(_displayFilterIcon) {
                  if(widget.onFilterButtonTap != null) {
                    widget.onFilterButtonTap();
                  }
                  _displayFilterIcon = !_displayFilterIcon;
                } else {
                  _editingController.clear();
                }
                _text = "";
              });
            },
            child: Container(
              width: 40,
              height: 40,
              child: Image.asset(icon)
            )
          )
        ],
      ),
    );
  }

  void showFilterIcon() {
    setState(() {
      _displayFilterIcon = true;
    });
  }

  void showClearIcon() {
    setState(() {
      _displayFilterIcon = false;
    });
  }
}