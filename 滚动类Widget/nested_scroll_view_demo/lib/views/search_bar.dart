/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-12-04 15:19:56
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-12-04 15:27:57
 * @FilePath: /nested_scroll_view_demo/lib/views/search_bar.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {

  const SearchBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(35 + 8 * 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(Icons.ac_unit),
          Expanded(
            child: Container(
                height: 35,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const TextField(
                  autofocus: false,
                  cursorColor: Colors.blue,
                  maxLines: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF3F6F9),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.only(right: 0),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(35 / 2)),
                      ),
                      hintText: "搜索文章",
                      hintStyle: TextStyle(fontSize: 14)
                      ),
                )),
          ),
          Wrap(
            spacing: 3,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Icon(Icons.assignment_turned_in_outlined),
              Text('已签',style: TextStyle(color: Colors.grey),)
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
