# Flutter生命周期回调时机

**User:** Anonymous  
**Created:** 8/1/2026 9:43:16  
**Updated:** 8/1/2026 10:30:51  
**Exported:** 8/1/2026 10:35:59  
**Link:** [https://chatgpt.com/c/6a6d4f33-d880-83ea-a04f-6e835145e565](https://chatgpt.com/c/6a6d4f33-d880-83ea-a04f-6e835145e565)  

## Prompt:
2026/8/1 09:43:15

Flutter的生命周期中,didChangeDependencies 和 didUpdateWidget 的调用时机?

## Response:
2026/8/1 09:43:16

在 Flutter `StatefulWidget` 生命周期中，`didChangeDependencies()` 和 `didUpdateWidget()` 都属于 **State 对象更新阶段的回调**，但触发原因完全不同：

一句话记忆：

> **didChangeDependencies：外部依赖（InheritedWidget）变化时调用**  
> **didUpdateWidget：父 Widget 重新 build，并传入新的配置时调用**

---

## 1. 生命周期整体顺序

一个 StatefulWidget 创建时：

```
createState()

 ↓

initState()

 ↓

didChangeDependencies()

 ↓

build()

 ↓

dispose()
```

注意：

`didChangeDependencies()` 是第一次 build 前一定会调用一次。

---

# 一、didChangeDependencies()

## 什么时候调用？

当 **依赖的 InheritedWidget 发生变化** 时调用。

典型来源：

- Theme
- MediaQuery
- Localizations
- Provider
- InheritedWidget
- BlocProvider
- Riverpod Provider 等

例如：

```dart
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("dependencies changed");
  }

@override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Text(
      "hello",
      style: theme.textTheme.bodyLarge,
    );
  }
}
```

---

当主题变化：

```dart
ThemeMode.dark
```

导致：

```
Theme(InheritedWidget)
        |
        |
        ↓
MyPage
```

依赖链变化：

```
didChangeDependencies()
        ↓
build()
```

---

## 为什么不是 build 里处理？

因为 Flutter 需要告诉你：

> "你依赖的数据变了"

所以提供：

```dart
didChangeDependencies()
```

适合做：

- 初始化依赖数据
- 根据 context 获取资源
- 注册监听

例如：

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();

  final locale =
      Localizations.localeOf(context);

  loadData(locale);
}
```

---

# 二、didUpdateWidget()

## 什么时候调用？

当：

> 父 Widget 重新 build，并且新的 Widget 替换旧 Widget，但是 State 被复用

例如：

父：

```dart
class Parent extends StatefulWidget {

  final String name;

  const Parent({
    required this.name,
    super.key,
  });

}
```

子：

```dart
class Child extends StatefulWidget {

  final String name;

  const Child({
    required this.name,
    super.key,
  });

@override
  State<Child> createState()
      => _ChildState();
}
```

---

父更新：

第一次：

```dart
Child(
 name:"Tom"
)
```

后来：

```dart
Child(
 name:"Jack"
)
```

Flutter 判断：

```
旧 Widget:

Child(name:"Tom")

新 Widget:

Child(name:"Jack")
```

类型相同：

```
Child == Child
```

key 相同：

所以：

```
保留 State
```

不会：

```
createState()
```

而是：

```
didUpdateWidget(oldWidget)

        ↓

build()
```

---

例子：

```dart
class _ChildState extends State<Child>{

 @override
 void didUpdateWidget(
     Child oldWidget
 ){
   super.didUpdateWidget(oldWidget);

if(oldWidget.name 
       != widget.name){

     print(
       "name changed"
     );
   }
 }

@override
 Widget build(BuildContext context){

   return Text(widget.name);

 }

}
```

---

# 三、两者区别核心

| | didChangeDependencies | didUpdateWidget |
|-|-|-|
|触发原因|依赖变化|父 Widget 配置变化|
|来源|InheritedWidget|父 Widget|
|第一次创建|会调用|不会|
|State 是否保留|是|是|
|发生位置|依赖树变化|Widget Tree 更新|
|典型场景|Theme/Provider变化|参数变化|

---

# 四、实际调用顺序对比

## 场景1：第一次打开页面

```
createState

↓

initState

↓

didChangeDependencies

↓

build
```

---

## 场景2：父 Widget 改参数

比如：

```dart
Child(
 count:10
)
```

变成：

```dart
Child(
 count:20
)
```

流程：

```
didUpdateWidget(oldWidget)

↓

build
```

---

## 场景3：Theme 改变

例如：

```dart
ThemeMode.light
        ↓
ThemeMode.dark
```

流程：

```
didChangeDependencies()

↓

build()
```

---

## 场景4：Provider 数据变化

例如：

```dart
context.watch<User>()
```

Provider 更新：

```
InheritedElement notifyClients()

↓

didChangeDependencies()

↓

build()
```

---

# 五、和 initState 的关系（重点）

很多人会混淆：

## initState

不能：

```dart
Theme.of(context)
```

因为依赖还没有建立。

错误：

```dart
@override
void initState(){

  super.initState();

  var theme =
      Theme.of(context); // 不推荐
}
```

---

应该：

```dart
@override
void didChangeDependencies(){

 super.didChangeDependencies();

 var theme =
     Theme.of(context);
}
```

原因：

此时 Flutter 已经建立：

```
State
 |
Element
 |
InheritedWidget
```

依赖关系。

---

# 六、一个非常实用的记忆方法

把 Flutter Widget 分成两类：

## 1. 自己的参数变化

例如：

```dart
UserCard(
 name:"Tom"
)
```

父传进来的：

```
Widget configuration
```

触发：

```
didUpdateWidget()
```

---

## 2. 环境变化

例如：

```dart
Theme
MediaQuery
Locale
Provider
```

外部环境：

```
Inherited dependency
```

触发：

```
didChangeDependencies()
```

---

最终口诀：

> **参数变 → didUpdateWidget**  
> **环境变 → didChangeDependencies**  
> **第一次加载 → initState → didChangeDependencies → build**

在实际 Flutter 开发中，`didUpdateWidget` 更像 React 的 `componentDidUpdate`，而 `didChangeDependencies` 更接近“订阅的上下文(Context)发生变化”的通知。

## Prompt:
2026/8/1 10:30:45

didUpdateWidget的触发时机是:
当父组件的state发生变化,子组件的didUpdateWidget会被触发

## Response:
2026/8/1 10:30:45

你的理解**基本正确，但需要补充一个关键条件**：

> **不是所有父组件 State 变化都会触发子组件 `didUpdateWidget()`。**
>
> 只有当父组件 `build()` 后，**重新创建了一个与原来类型相同、Key 相同的子 Widget，并且该 Widget 的配置发生变化**时，子组件的 `didUpdateWidget()` 才会触发。

---

## 看一个例子

父组件：

```dart
class Parent extends StatefulWidget {
  const Parent({super.key});

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {

  int count = 0;

  void update(){
    setState(() {
      count++;
    });
  }

@override
  Widget build(BuildContext context){

    return Child(
      value: count,
    );
  }
}
```

子组件：

```dart
class Child extends StatefulWidget {

  final int value;

  const Child({
    required this.value,
    super.key,
  });

@override
  State<Child> createState()
      => _ChildState();
}

class _ChildState extends State<Child>{

  @override
  void didUpdateWidget(
      Child oldWidget
  ){

    super.didUpdateWidget(oldWidget);

    print(
      "old:${oldWidget.value}, new:${widget.value}"
    );
  }

@override
  Widget build(BuildContext context){

    return Text(
      "${widget.value}"
    );
  }
}
```

流程：

第一次：

```
Parent build

 ↓

Child(value:0)

 ↓

createState

 ↓

initState

 ↓

build
```

---

点击：

```dart
setState(() {
  count++;
});
```

父重新 build：

```
Parent build

 ↓

Child(value:1)
```

Flutter 比较：

旧：

```
Child(value:0)
```

新：

```
Child(value:1)
```

发现：

```
Widget 类型一样
Key 一样
```

所以：

```
保留原来的 State
```

然后：

```
didUpdateWidget(oldWidget)

 ↓

build()
```

---

## 但是下面这种不会触发

### 情况1：父 setState，但是子 Widget 没变化

例如：

```dart
@override
Widget build(BuildContext context){

 return Child(
   value: 100,
 );

}
```

父：

```dart
setState((){});
```

重新 build：

```
Child(value:100)

Child(value:100)
```

虽然父变化了：

但是子配置没有变化。

通常：

```
didUpdateWidget ❌
```

---

### 情况2：子组件被移除

例如：

之前：

```dart
Child()
```

后来：

```dart
Container()
```

结果：

```
dispose()
```

不会：

```
didUpdateWidget()
```

---

### 情况3：Key 改变

例如：

之前：

```dart
Child(
 key: ValueKey(1)
)
```

变成：

```dart
Child(
 key: ValueKey(2)
)
```

Flutter认为：

```
这是新的 Widget
```

流程：

```
dispose(old State)

↓

createState()

↓

initState()
```

不会：

```
didUpdateWidget()
```

---

## 更准确的一句话：

你的描述：

> 当父组件的 state 发生变化，子组件的 didUpdateWidget 会被触发

应该改成：

> **当父组件 State 变化导致父组件重新 build，并生成了一个新的子 Widget 配置（类型和 Key 相同），Flutter 复用子组件 State，并调用子组件的 didUpdateWidget。**

---

可以用这个图记：

```
父 setState()
       |
       ↓
父 build()
       |
       ↓
生成新的 Child Widget
       |
       ↓
Flutter diff
       |
       ├── 类型/key相同
       │
       ↓
  更新旧 State
       |
       ↓
 didUpdateWidget()
       |
       ↓
 build()
```

这也是 Flutter `Widget` 和 `Element` 分离设计的核心：**Widget 是配置，State 才是持续存在的对象。**



---
Powered by [ChatGPT Exporter](https://www.chatgptexporter.com)