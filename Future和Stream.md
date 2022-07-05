Future代表一次异步 <br/>
Steam代表多次异步   <br/>

Future.forEach 和  Future.wait 和   await for  <br/>

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








