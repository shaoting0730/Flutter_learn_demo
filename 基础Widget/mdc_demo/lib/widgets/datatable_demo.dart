import 'package:flutter/material.dart';
import '../post.dart';
class DataTableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DataTableDemo')),
      body: DataTableDemoWidget() ,
    );
  }
}

class DataTableDemoWidget extends StatefulWidget {
  @override
  _DataTableDemoWidgetState createState() => _DataTableDemoWidgetState();
}

class _DataTableDemoWidgetState extends State<DataTableDemoWidget> {
  int _sortColumnIndex ;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              DataColumn(
                label: Container(
                  width: 50.0,
                  child: Text('Title'),  
                ),
                onSort: (int index,bool ascending){
                   setState(() {
                     _sortColumnIndex = index;
                     _sortAscending = ascending; 

                     posts.sort((a,b){
                       if(!ascending){
                         final c = a;
                         a = b;
                         b = c;
                       } 
                       return a.title.length.compareTo(b.title.length);
                     });
                   });
                }
              ),
              DataColumn(
                label: Text('Author')
              ),
              DataColumn(
                label: Text('image')
              ),
            ] ,
            rows:posts.map((post){
               return DataRow(
                 selected: post.selected,
                 onSelectChanged: (bool value){
                   setState(() {
                     if(post.selected != value){
                       post.selected = value;
                     }
                   });
                 },
                 cells: [
                   DataCell(Text(post.title)),
                   DataCell(Text(post.author)),
                   DataCell(Image.network(post.imageUrl)),
                 ]
               ); 
            }).toList(),
          )
        ],
    );
  }
}