import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

/// 全局刷新状态
/// 页面状态刷新，在 [createApp()] visitor 中注册
/// 如果是 `PageView` 中的页面做刷新，在 `Page` 构造函数中注册
/// 参考 [HomeArticlePage]
globalUpdate() => (Object pageState, GlobalState appState) {
      final GlobalBaseState p = pageState;

      if (pageState is Cloneable) {
        final Object copy = pageState.clone();
        final GlobalBaseState newState = copy;

        if (p.themeColor != appState.themeColor) {
          newState.themeColor = appState.themeColor;
        }

        return newState;
      }

      return pageState;
    };
