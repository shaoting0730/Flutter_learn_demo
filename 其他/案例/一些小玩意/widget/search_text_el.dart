import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 搜索框内容变化回调
typedef BtnOnSearchTextChange = void Function(String content);

/// 提交搜索框内容时的回调
typedef BtnOnCommit = void Function(String content);

/// 右侧清除按钮 X 被点击的回调
typedef BtnOnTextClear = bool Function();

///
/// 搜索框, 提供输入回调
///
class RLSearchText extends StatefulWidget {
  /// 提示语
  final String? hintText;

  /// 提示语样式
  final TextStyle? hintStyle;

  /// 输入框样式
  final TextStyle? textStyle;

  /// 用于设置搜索框前端的 Icon
  final Widget? prefixIcon;

  /// 包裹搜索框的容器背景色
  final Color? outSideColor;

  /// 搜索框内部的颜色
  final Color? innerColor;

  /// 最大展示行数
  final int maxLines;

  /// 最大输入长度
  final int? maxLength;

  /// 输入框高度，默认 34
  final double? height;

  /// 内部搜索框之外的 Padding。设置该字段会导致输入框显示区域变小。
  final EdgeInsets? outSidePadding;

  /// 内部搜索框之内的 Padding。推荐只设置水平边距。垂直边距会出现对齐问题
  /// 可以设置height来代替垂直边距
  final EdgeInsets? innerPadding;

  /// 普通状态的 border
  final BoxBorder? normalBorder;

  /// 激活状态的 Border， 默认和 border 一致
  final BoxBorder? activeBorder;

  /// 输入框圆角
  final BorderRadius? borderRadius;

  /// 右侧操作 widget
  final Widget? action;

  /// 是否自动获取焦点
  final bool? autoFocus;

  /// 用于控制键盘动作
  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final List<TextInputFormatter>? inputFormatters;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// 文本变化的回调
  final BtnOnSearchTextChange? onTextChange;

  /// 提交文本时的回调
  final BtnOnCommit? onTextCommit;

  /// 右侧 action 区域点击的回调
  final VoidCallback? onActionTap;

  /// 清除按钮的回调 如果用户设置了该属性
  /// 如果返回值为true，表明用户想要拦截，则不会走默认的清除行为
  /// 如果返回值为false，表明用户不想要拦截，在执行了用户的行为之后，还会走默认的行为
  final BtnOnTextClear? onTextClear;

  /// 用于控制清除 Icon 和右侧 Action 的显示与隐藏。等其他复杂的操作。
  final BtnSearchTextController? searchController;

  ///是否展示内部搜索按钮 默认不展示
  final bool innerSearchIsShow;

  const RLSearchText({
    Key? key,
    this.searchController,
    this.controller,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.prefixIcon,
    this.onTextChange,
    this.onTextCommit,
    this.innerSearchIsShow = false,
    this.onTextClear,
    this.onActionTap,
    this.action,
    this.height,
    this.outSidePadding,
    this.innerPadding,
    this.outSideColor,
    this.innerColor,
    this.normalBorder,
    this.activeBorder,
    this.borderRadius,
    this.focusNode,
    this.autoFocus,
    this.textInputAction,
    this.inputFormatters,
    this.textInputType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchTextState();
  }
}

class _SearchTextState extends State<RLSearchText> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;
  BoxBorder? border;
  BtnSearchTextController? searchTextController;

  BtnSearchTextController? tmpController;

  @override
  void initState() {
    super.initState();

    if (widget.searchController == null) {
      tmpController = BtnSearchTextController();
    }
    searchTextController = widget.searchController ?? tmpController;
    searchTextController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    focusNode = widget.focusNode ?? FocusNode();
    textEditingController = widget.controller ?? TextEditingController();
    border = widget.normalBorder ??
        Border.all(
          width: 0,
          color: widget.innerColor ?? Color(0xFFF7F8FA),
        );

    focusNode!.addListener(_handleFocusNodeChangeListenerTick);
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController?.dispose();
    focusNode?.removeListener(_handleFocusNodeChangeListenerTick);
    focusNode?.dispose();
    textEditingController?.dispose();
  }

  /// 焦点状态回到，用于刷新当前 UI
  void _handleFocusNodeChangeListenerTick() {
    if (focusNode!.hasFocus) {
      border = widget.activeBorder ?? border;
    } else {
      border = widget.normalBorder ?? border;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: widget.outSidePadding ?? EdgeInsets.all(14),
        color: widget.outSideColor ?? Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: widget.innerPadding,
                height: widget.height ?? 34,
                decoration: BoxDecoration(
                  color: widget.innerColor ?? Color(0xFFF7F8FA),
                  border: border,
                  borderRadius: widget.borderRadius ??
                      BorderRadius.all(Radius.circular(2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.prefixIcon ??
                        Icon(Icons.lock),
                    Expanded(
                      child: TextField(
                        maxLength: widget.maxLength,
                        autofocus: widget.autoFocus ?? false,
                        textInputAction: widget.textInputAction,
                        focusNode: focusNode,
                        controller: textEditingController,
                        keyboardType: widget.textInputType,
                        inputFormatters: widget.inputFormatters,
                        cursorColor: Colors.transparent,
                        style: widget.textStyle ??
                            TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              EdgeInsets.only(left: 4, right: 6),
                          // 是密集属性，输入子项是否是密集形式的一部分（即使用较少的垂直空间）。
                          isDense: true,
                          hintStyle: widget.hintStyle ??
                              TextStyle(
                                fontSize: 14,
                                textBaseline: TextBaseline.alphabetic,
                                color: Colors.grey,
                              ),
                          hintText: widget.hintText ?? "搜索",
                          counterText: '',
                        ),
                        onChanged: (content) {
                          if (widget.onTextChange != null) {
                            widget.onTextChange!(content);
                          }
                          setState(() {});
                        },
                        onSubmitted: (content) {
                          if (widget.onTextCommit != null) {
                            widget.onTextCommit!(content);
                          }
                        },
                      ),
                    ),
                    Visibility(
                      visible: searchTextController!.isClearShow,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onTextClear != null) {
                            bool isIntercept = widget.onTextClear!();
                            if (isIntercept) return;
                          }
                          textEditingController!.clear();
                          if (widget.onTextChange != null) {
                            widget.onTextChange!(
                                textEditingController!.value.text);
                          }
                          setState(() {});
                        },
                        child: Visibility(
                          visible: textEditingController!.text.isNotEmpty,
                          child: Icon(Icons.clear),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.innerSearchIsShow &&
                          textEditingController!.text.isNotEmpty,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onTextCommit != null) {
                            widget.onTextCommit!(textEditingController!.text);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 14, top: 4, bottom: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          width: 52,
                          height: widget.height,
                          child: Text(
                            '搜索',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: searchTextController!.isActionShow,
              child: widget.action ??
                  GestureDetector(
                    onTap: () {
                      if (widget.onActionTap != null) {
                        widget.onActionTap!();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                      child: Text(
                        '取消',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}

/// 搜索框控制类，用于控制 清除 icon（x）、取消按钮的展示 隐藏
class BtnSearchTextController extends ChangeNotifier {
  bool _isClearShow = true;
  bool _isActionShow = false;

  bool get isClearShow => _isClearShow;

  bool get isActionShow => _isActionShow;

  /// 设置清除 icon 的展示隐藏
  set isClearShow(bool value) {
    _isClearShow = value;
    notifyListeners();
  }

  /// 设置取消按钮的展示隐藏
  set isActionShow(bool value) {
    _isActionShow = value;
    notifyListeners();
  }
}
