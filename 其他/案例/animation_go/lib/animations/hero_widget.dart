import 'package:flutter/material.dart';

import 'hero_detail_widget.dart';

class HeroWidget extends StatefulWidget {
  const HeroWidget({Key? key}) : super(key: key);

  @override
  State<HeroWidget> createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          15,
          (index) {
            var path = 'images/$index.png';
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HeroDetailWidget(
                      path: path,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: path,
                child: Center(
                  child: Image.asset(
                    path,
                    width: 50,
                    height: 50,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
