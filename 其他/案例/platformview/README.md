`platform view` 就是 `AndroidView` 和 `UIKitView` 的总称.允许在flutter工程中嵌入iOS原生模块和Android原生模块


   [ demo文章 ]( https://zhoushaoting.com/2023/02/08/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~PlatformView%E7%9A%84%E7%AE%80%E5%8D%95%E4%BD%BF%E7%94%A8/ )    <br/>


```
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Platform.isIOS
          ? const UiKitView(
              viewType: "platform_text_view",
              creationParams: <String, dynamic>{"text": "iOS Label"},
              creationParamsCodec: StandardMessageCodec(),
            )
          : const AndroidView(
              viewType: "platform_text_view",
              creationParams: <String, dynamic>{"text": "Android Text View"},
              creationParamsCodec: StandardMessageCodec(),
            ),
    );
  }
}
```
