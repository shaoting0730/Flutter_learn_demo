import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import '../models/api/goodsGroup.dart';
import '../pages/store_dynamic/edit_image_page.dart';
import '../models/api/customer.dart';

class ProductThumbnail extends StatefulWidget {
  final String picStr;
  final String price;
  final String videoStr;
  final ListObjectsModel model;
  final StoreInfoModel storeInfomodel;
  final int index;
  final double width;
  final List list;
  ProductThumbnail({
    Key key,
    @required this.picStr,
    @required this.videoStr,
    @required this.price,
    @required this.model,
    @required this.storeInfomodel,
    @required this.index,
    @required this.list,
    @required this.width,
  }) : super(key: key);
  @override
  State<ProductThumbnail> createState() {
    return ProductThumbnailState();
  }
}

class ProductThumbnailState extends State<ProductThumbnail> {
  IjkMediaController _videoController = IjkMediaController();
  bool _playingTag = false; //  播放标识 默认未播放

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print('视频url${widget.videoStr}');
    _startVideo();
//    print(jsonEncode(widget.storeInfomodel));
  }

  /*
  * 加载视频
  * */
  _startVideo() async {
    String videoStr = widget.videoStr ?? '';
    if (videoStr.length > 0) {
      await _videoController.setNetworkDataSource(widget.videoStr,
          autoPlay: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String videoStr = widget.videoStr ?? '';
    return videoStr.length > 0
        ? InkWell(
            onTap: () {},
            child: Stack(
              children: <Widget>[
                Container(
                  height: 200, // 这里随意
                  child: IjkPlayer(
                    mediaController: _videoController,
                  ),
                ),
                //  视频遮挡
                _playingTag == false
                    ? Positioned(
                        top: 0,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _playingTag = true;
                            });
                            _videoController.play();
                          },
                          child: Container(
                            child: Image.network(
                              widget.videoStr +
                                  '?vframe/jpg/offset/0|imageView2/1/w/320/h/230',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                    : Text(''),
                _playingTag == false
                    ? Positioned(
                        top: 80,
                        left: MediaQuery.of(context).size.width / 2 - 40,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _playingTag = true;
                            });
                            _videoController.play();
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          )
        : InkWell(
            onTap: () {
              print('0000000000');
              print(widget.list);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditImagePage(
                    storeModel: widget.storeInfomodel,
                    list: widget.list,
                    index: widget.index,
                    model: widget.model,
                    price: widget.price,
                  ),
                ),
              );
            },
            child: Container(
              child: Stack(
                children: <Widget>[
//                  FadeInImage.assetNetwork(
//                    fadeInCurve: Curves.linear,
//                    height: widget.width,
//                    width: widget.width,
//                    placeholder: 'assets/logo_xmmq_1024.png',
//                    image: widget.picStr + '?imageView2/0/w/230/h/230',
//                    fit: BoxFit.cover,
//                  ),
                  Image.network(
                    '${widget.picStr}?imageView2/0/w/230/h/230',
                    height: widget.width,
                    width: widget.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: widget.price != '待议'
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 3),
                            child: Text(
                              widget.price,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 14.0),
                            ),
                            color: Color(0x99000000),
                          )
                        : Text(''),
                  ),
                ],
              ),
            ),
          );
  }
}
