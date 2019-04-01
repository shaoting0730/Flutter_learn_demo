import 'package:flutter/material.dart';
import '../post.dart';

class SliverGridDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SliverGridDemo')),
      body: CustomScrollView(
        slivers: <Widget>[
         SliverSafeArea(
           sliver: SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverGridYanshi(),
            ),
         )
        ],
      ),
    );
  }
}

class SliverGridYanshi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            child: Image.network(posts[index].imageUrl, fit: BoxFit.cover),
          );
        },
        childCount: posts.length,
      ),
    );
  }
}
