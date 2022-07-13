Future代表一次异步 <br/>
Steam代表多次异步   <br/>

Future可以划分三种状态： <br/>
1、未完成  <br/>
2、完成，数据正常  <br/>
3、完成，数据不正常  <br/>

Steam可以划分四种状态，其实也就是ConnectionState的四个枚举值： <br/>
1、none 没有数据流  <br/>
2、waiting 等待数据流  <br/>
3、active 数据流活跃  <br/>
3、done 数据流关闭  <br/>


ConnectionState是一个enum 类型的值  <br/>
none ：当前未连接到任何异步交互，尚未开始 <br/>
waiting ： 连接成功等待交互  <br/>
active ：正在交互中，可以理解为正在返回数据中  <br/>
done ：交互已经完成，可以理解为数据返回完成，此时如果是正确的返回则data就有数据了，如果是错误的error有错误信息返回  <br/>


### FutureBuilder  和  StreamBuilder
```
       FutureBuilder(
          future: loadData(), // 读取网络数据，异步函数，返回一个future
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //  检查connectionState是否为done，以此判断future是否结束
            if (snapshot.connectionState == ConnectionState.done) {
              // 当future结束时，data和error必有一个不为空
              if (snapshot.hasError) {
                // 判断是否有错误
                return Text('有错误${snapshot.error}'); // 有错误，显示错误widget
              } else {
                return Text('数据${snapshot.data}'); // 没有错误，显示数据widget
              }
            } else {
              return const CircularProgressIndicator(); // future没有结束，显示菊花
            }
          },
        )
        
        FutureBuilder(
          future: loadData(), // 读取网络数据，异步函数，返回一个future
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Text('数据${snapshot.data}'); // 有数据，显示数据widget
            } else if (snapshot.hasError) {
              return Text('有错误${snapshot.error}'); // 有错误，显示错误widget
            } else {
              return const CircularProgressIndicator(); // 没有数据，没有错误，显示菊花
            }
          },
        )
        
        
        
        StreamBuilder(
          stream: counter(), // 传入一个Stream
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 观察 connectionState 的状态
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('没有数据流');
              case ConnectionState.waiting:
                return const Text('等待数据流');
              case ConnectionState.active:
                if (snapshot.hasError) {
                  return Text('数据流活跃，异常是 ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('数据流活跃，数据是 ${snapshot.data}');
                }
                throw "当数据流活跃时，不会发生两者为空的情况";
              case ConnectionState.done:
                return const Text('数据流关闭');
              default:
                throw "ConnectionState没有其他状态";
            }
          },
        )
```
 



### Future.forEach 和  Future.wait 和   await for  

```
  test() async {
    Stream streamm = Stream.periodic(const Duration(microseconds: 3));
    Future e = Future.delayed(const Duration(microseconds: 1), () {
      print(1);
    });
    Future j = Future.delayed(const Duration(microseconds: 2), () {
      print(2);
    });
    Future d = Future.delayed(const Duration(microseconds: 3), () {
      print(3);
    });
    //----------------------------forEach 后均可以，只需要可以遍历即可,如List-----------------------------------------------//
    // Future  forEach (Iterable  elements, FutureOr  Function(T) action)
    Future.forEach([e, j, d], (element) {
      print(Future);
    });
    Future.forEach([1, 2, 3], (element) {
      print(Future);
    });
    Future.forEach([streamm], (element) {
      print(Future);
    });

    //----------------------------Future.wait 后可以跟Future的List-----------------------------------------------//
    // Type: Future<List<Null>> Function(Iterable<Future<Null>>, {void Function(Null)? cleanUp, bool eagerError})
    Future.wait([e, j, d]);
    // Future.wait([1, 2, 3]); // 报错 The argument type 'List<int>' can't be assigned to the parameter type 'Iterable<Future<dynamic>>'..
    // Future.wait(streamm); // 报错 The argument type 'Stream<dynamic>' can't be assigned to the parameter type 'Iterable<Future<dynamic>>'.

    //----------------------------await for 后可以跟Stream-----------------------------------------------//
    // await for (var e in [e, j, d]) {} // 报错   The type 'List<Future<dynamic>>' used in the 'for' loop must implement Stream.
    // await for (var e in [1, 2, 3]) {} // 报错  The type 'List<int>' used in the 'for' loop must implement Stream. (Documentation)
    await for (var e in streamm) {}

```
大致可以得出： <br/>
 // Future  forEach (Iterable  elements, FutureOr  Function(T) action) <br/>
Future.forEach后面可以跟普通list，Future的list,Stream的list，只需要后面可以遍历的即可。 <br/>
 // Type: Future<List<Null>> Function(Iterable<Future<Null>>, {void Function(Null)? cleanUp, bool eagerError}) <br/>
Future.wait后只能跟Future的List。 <br/>
 //   <br/>
 await for 只能跟Steam <br/>








