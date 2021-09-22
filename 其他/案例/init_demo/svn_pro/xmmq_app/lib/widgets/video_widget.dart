/*
*  单个视频
* */

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class VideoWidget extends StatefulWidget {
  final String videoStr;
  VideoWidget({
    Key key,
    @required this.videoStr,
  }) : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  IjkMediaController _videoController = IjkMediaController();
  bool _playingTag = false; //  播放标识 默认未播放

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startVideo();
  }

  /*
  * 加载视频
  * */
  _startVideo() async {
    await _videoController.setNetworkDataSource(widget.videoStr,
        autoPlay: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
