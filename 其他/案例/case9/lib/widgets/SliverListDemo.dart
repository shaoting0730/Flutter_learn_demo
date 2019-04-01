import 'package:flutter/material.dart';
import '../post.dart';

class SliverListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(  
        slivers: <Widget>[
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverListYanshi(),
            ),
          )
        ],
      ),
      )
    );
  }
}

class SliverListYanshi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        posts[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 32.0,
                    left: 32.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          posts[index].title,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        Text(
                          posts[index].author,
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          );
        },
        childCount: posts.length,
      ),
    );
  }
}
