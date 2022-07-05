Future代表一次异步
Steam代表多次异步

```
  test() async {
    Stream streamm = Stream.periodic(const Duration(microseconds: 3));
    var e = Future.delayed(const Duration(microseconds: 1), () {
      print(1);
    });
    var j = Future.delayed(const Duration(microseconds: 2), () {
      print(2);
    });
    var d = Future.delayed(const Duration(microseconds: 3), () {
      print(3);
    });

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

    // Type: Future<List<Null>> Function(Iterable<Future<Null>>, {void Function(Null)? cleanUp, bool eagerError})
    Future.wait([e, j, d]);
    // Future.wait([1, 2, 3]); // 报错 The argument type 'List<int>' can't be assigned to the parameter type 'Iterable<Future<dynamic>>'.
    // Future.wait(a);  // 报错 The argument type 'Stream<dynamic>' can't be assigned to the parameter type 'Iterable<Future<dynamic>>'.

    await for (var e in streamm) {}
    // await for (var e in [1, 2, 3]) {} // 报错  The type 'List<int>' used in the 'for' loop must implement Stream. (Documentation)
    // await for (var e in [e, j, d]) {} // 报错   The type 'List<Future<Null>>' used in the 'for' loop must implement Stream. (Documentation)
  }

```
大致可以得出：
 // Future  forEach (Iterable  elements, FutureOr  Function(T) action)
Future.forEach后面可以跟普通list，Future的list,Stream的list，只需要后面可以遍历的即可。
 // Type: Future<List<Null>> Function(Iterable<Future<Null>>, {void Function(Null)? cleanUp, bool eagerError})
Future.wait后只能跟Future的List。
//  
 await for 只能跟Steam








