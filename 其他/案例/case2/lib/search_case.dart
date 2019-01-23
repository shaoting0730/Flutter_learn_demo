import 'package:flutter/material.dart';
import 'asset.dart';

class SearchCase extends StatefulWidget {
  _SearchCaseState createState() => _SearchCaseState();
}

class _SearchCaseState extends State<SearchCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('案例2'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context,delegate: SearchBarDelegate());
            },
          )
        ],
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String> {
  // Search右边的X,点击清空
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  // Search左边的返回按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // 搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.pink,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  // 提示文字
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (context, index) => ListTile(
            title: RichText(
              text: TextSpan(
                  text: suggestionsList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: suggestionsList[index].substring(query.length),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ]),
            ),
          ),
    );
  }
}
