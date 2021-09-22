import 'package:flutter/material.dart';
import './base_page.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class PhotoViewPage extends BasePage {

  final List<String> imageUrls;
  final String title;
  PhotoViewPage({this.imageUrls, this.title = "House pictures"});
  @override
  State<StatefulWidget> createState() {
    return PhotoViewPageState();
  }

}

class PhotoViewPageState extends BasePageState<PhotoViewPage> {
  @override
  void initState() {
    super.initState();

    title = widget.title;
  }

  @override
  Widget pageContent(BuildContext context) {

    var imageViews = List<Widget>();
    for(int index = 0 ; index < widget.imageUrls.length; index ++ ) {
      var element = widget.imageUrls[index];
      imageViews.add(
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryPhotoViewWrapper(galleryItems: widget.imageUrls,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                initialIndex: index,
                ),
              )
            );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Image.network(element)
          )
        )
      );
    };

    return Container(
      padding: const EdgeInsets.all(15),
      child: GridView.count(
          shrinkWrap: true,
          childAspectRatio:1.0,
          crossAxisCount: 3,
          children: imageViews
      ),
    );
  }

}


class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper(
      {this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialIndex,
      @required this.galleryItems})
      : pageController = PageController(initialPage: initialIndex);

  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String> galleryItems;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget getLeftAction(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: Colors.white,
      ),
      onPressed: (){
        Navigator.pop(context);
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.galleryItems.length,
                loadingChild: widget.loadingChild,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Image ${currentIndex + 1}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 17.0, decoration: null),
                ),
              ),
              Positioned(
                top: 20,
                left: 0,
                child: getLeftAction(context),
              )
            ],
          )),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    String item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(item),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 1.1
          );
  }
}
