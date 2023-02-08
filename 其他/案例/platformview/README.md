`platform view` 就是 `AndroidView` 和 `UIKitView` 的总称.允许在flutter工程中嵌入iOS原生模块和Android原生模块


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
