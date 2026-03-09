>  Flutter 是一个自绘 UI 框架，整体分为三层：Framework、Engine、Embedder。

来自 Flutter 的架构：

```
Framework (Dart)
    ↓
Engine (C++)
    ↓
Embedder (Platform)
```

## 1️⃣ Framework（Dart 层）

* Widget
* Element
* RenderObject
* 动画
* 手势系统
* 状态管理

核心特点：

> UI = Widget 描述
> Element = 管理实例
> RenderObject = 负责布局和绘制

## 2️⃣ Engine（C++ 层）

Engine 负责：

* Dart 运行时
* 渲染管线
* 线程管理
* 平台通道

渲染依赖：

👉 [ Skia ]( https://github.com/google/skia ) 图形库  [ impeller ]( https://github.com/flutter/engine/tree/main/impeller ) 图形库

Engine 是 Flutter 性能的核心。

## 3️⃣ Embedder（平台层）

Embedder 是平台适配层：

* Android 使用 Surface
* iOS 使用 UIView
* 管理 OpenGL / Metal

---

# ✅ 第二层：三棵树机制（高频核心）

Flutter 有三棵树：

| 类型           | 作用      |
| ------------ | ------- |
| Widget Tree  | 配置      |
| Element Tree | 实例管理    |
| Render Tree  | 布局 & 绘制 |


### 🔥 高分解释：

Widget 是不可变的配置对象。
Element 负责维护状态和生命周期。
RenderObject 才是真正参与布局和绘制的对象。


# ✅ 第三层：渲染流程（必须会）

面试高频：

> setState 之后发生了什么？

标准回答结构：

1. 调用 setState
2. 标记 Element dirty
3. 下一帧 build
4. 生成新的 Widget
5. diff（Widget.canUpdate）
6. 更新 Element
7. 触发布局
8. 触发绘制
9. 提交给 Engine
10. Skia 渲染


## Flutter 渲染管线

```
build
 → layout
 → paint
 → compositing
 → raster
```

线程模型：

| 线程              | 作用      |
| --------------- | ------- |
| UI Thread       | Dart 执行 |
| Raster Thread   | 光栅化     |
| Platform Thread | 原生交互    |

🔥 高级补充：

> Flutter 是多线程模型，UI 和 Raster 分离，提高渲染效率。


# ✅ 第四层：为什么 Flutter 性能高？

核心原因：

### 1️⃣ 自绘（不依赖原生控件）

不像 React Native 依赖桥接。

Flutter 直接用 Skia 绘制。


### 2️⃣ AOT 编译

* iOS 强制 AOT
* Android Release 也是 AOT

避免解释执行损耗。


### 3️⃣ 无跨语言频繁桥接

Platform Channel 是按需通信，不像 RN 大量桥接。


# ✅ 第五层：高级问题（


## 🎯 问：Flutter 为什么 build 可以频繁执行？

因为：

* Widget 是轻量级对象
* 真正昂贵的是 layout 和 paint
* build 只是描述 UI


## 🎯 问：为什么要三棵树？

因为：

* Widget 负责配置（轻量）
* Element 负责状态（可复用）
* RenderObject 负责性能关键操作

分层可以：

✔ 降低 diff 成本
✔ 提高复用率
✔ 解耦职责


## 🎯 问：Flutter 为什么不用虚拟 DOM？

可以答：

> Flutter 的 Widget 本身就类似虚拟 DOM，但它直接控制 RenderObject，比传统虚拟 DOM 少一层映射。


# ✅ 第六层：真正高级加分（架构理解）

### 🎯 Flutter 的性能瓶颈在哪里？

* layout 过深
* 重复 rebuild
* 过度使用 opacity
* 大量图片解码
* 主线程阻塞

### 🎯 isolate 和线程区别？

* isolate 不是线程
* 内存不共享
* 消息传递
* 避免锁


# Dart: 没有进程概念、也没有线程概念. Dart 只提供一种并发单位：Isolate。

# 1️⃣ Flutter 默认是单进程

## 进程 = 操作系统分配资源的基本单位。简单说：一个正在运行的程序，就是一个进程。
## 线程 = CPU 调度执行的基本单位。可以理解为：线程是进程内部真正干活的执行单位。
### 

Flutter App 启动时，本质上是：

```text
Flutter App
   ↓
Android / iOS 进程
```

例如在 Android 上：

```
com.example.app
```

只有 **一个进程**。

这个进程里运行：

* Flutter Engine
* Dart VM
* UI

---

# 2️⃣ Flutter 内部是多线程

Flutter Engine 里面其实有 **多个核心线程**：

```text
Flutter Engine
 ├─ UI Thread
 ├─ Raster Thread
 ├─ Platform Thread
 └─ IO Thread
```

详细作用：

### ① UI Thread

运行 **Dart代码**。

例如：

* Widget build
* 状态更新
* 业务逻辑

---

### ② Raster Thread

负责 **GPU 渲染**。

流程：

```
Widget
 → RenderObject
 → Layer
 → GPU绘制
```

---

### ③ Platform Thread

负责 **系统交互**：

* Android
* iOS
* 插件通信

例如：

* MethodChannel
* 平台 API

---

### ④ IO Thread

处理：

* 图片加载
* 文件读取
* 网络 IO

---

# 3️⃣ Flutter 线程结构图

完整结构：

```text
App Process
   │
   ├─ Platform Thread
   │
   ├─ UI Thread (Dart)
   │
   ├─ Raster Thread (GPU)
   │
   └─ IO Thread
```

所以 Flutter **天生就是多线程渲染架构**。

---

# 4️⃣ Flutter 还有一个特殊机制：Isolate

Flutter（准确说是 Dart）并发不是线程，而是：

**Isolate**

相关语言是 Dart。

特点：

```
Isolate ≈ 轻量级独立运行单元
```

特点：

* 独立内存
* 不共享数据
* 通过 message 传递数据

结构：

```text
Flutter Process
   │
   ├─ Main Isolate
   │
   └─ Worker Isolate
```

常见用途：

* JSON解析
* 大量计算
* 图片处理

例如：

```dart
compute(parseJson, data);
```

---

# 5️⃣ Flutter 为什么不用多进程

原因：

### ① 内存成本高

手机内存有限。

多个进程：

```
每个进程
= 独立 VM
= 独立资源
```

很浪费。

---

### ② 通信复杂

多进程需要：

* IPC
* Binder
* Socket

而 Flutter 设计目标是：

```
跨平台
简单
统一
```

---

# 6️⃣ Flutter 和 Android 原生区别

Android 原生：

```
1进程
+ 多线程
+ 可选多进程
```

Flutter：

```
1进程
+ Engine多线程
+ Dart Isolate
```

---

# 7️⃣ 大厂 Flutter App 结构

很多 App 实际是：

```text
Android App

主进程
 └─ Flutter Engine
     ├─ UI Thread
     ├─ Raster Thread
     ├─ IO Thread
     └─ Platform Thread
```

例如：

* Alibaba
* Xianyu
* Google Ads

Flutter 都是这种架构。

---

# 8️⃣ 一句话总结

**Flutter 并发模型：**

```
单进程
+ Engine 多线程
+ Dart Isolate
```

---




**多进程（Multi-process）** 是一种程序运行方式：
👉 一个程序同时启动 **多个独立的进程** 来完成任务。

先从最直觉的理解开始。

---

#  多进程 vs 多线程

很多人容易混淆。

|      | 多进程 | 多线程 |
| ---- | --- | --- |
| 内存   | 独立  | 共享  |
| 稳定性  | 高   | 低   |
| 通信   | 困难  | 容易  |
| 创建成本 | 高   | 低   |

结构区别：

### 多进程

```
程序
 ├─ 进程A (独立内存)
 └─ 进程B (独立内存)
```

### 多线程

```
进程
 ├─ 线程A
 ├─ 线程B
 └─ 线程C
```

线程共享同一内存。

---



