import 'package:flutter/material.dart';

/// 果冻按钮 点击回弹
class JellyButton extends StatefulWidget {
  // 动画的时间
  final Duration duration;
  // 动画图标的大小
  final Size size;
  // 点击后的回调
  final VoidCallback onTap;
  // 未选中时的图片
  final String unCheckedImgAsset;
  // 选中时的图片
  final String checkedImgAsset;
  // 是否选中
  final bool checked;
  // 一定要添加这个背景颜色 不知道为什么 container不添加背景颜色 不能撑开
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const JellyButton({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.size = const Size(40.0, 40.0),
    required this.onTap,
    required this.unCheckedImgAsset,
    required this.checkedImgAsset,
    this.checked = false,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.all(0.0),
  });

  @override
  State<JellyButton> createState() => _JellyButtonState();
}

class _JellyButtonState extends State<JellyButton> with TickerProviderStateMixin {
  // 动画控制器 点击触发播放动画
  late AnimationController _controller;
  // 非线性动画 用来实现点击效果
  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    // 初始化 Controller
    _controller = AnimationController(vsync: this, duration: widget.duration);
    // 线性动画 可以让按钮从小到大变化
    Animation<double> linearAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    // 将线性动画转化成非线性动画 让按钮点击效果更加灵动
    _animation = CurvedAnimation(parent: linearAnimation, curve: Curves.elasticOut);
    // 一开始不播放动画 直接显示原始大小
    _controller.forward(from: 1.0);
  }

  @override
  void dispose() {
    // 记得要释放Controller的资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击的同时 播放动画
        _playAnimation();
        widget.onTap();
      },
      child: Container(
        // 添加这个约束 为了让按钮可以撑满屏幕 （主要是为了实现我仿写的项目的效果）
        constraints: BoxConstraints(minWidth: widget.size.width, minHeight: widget.size.height),
        color: widget.backgroundColor,
        padding: widget.padding,
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              // size / 1.55 是为了防止溢出
              return Image.asset(
                widget.checked ? widget.checkedImgAsset : widget.unCheckedImgAsset,
                width: _animation.value * (widget.size.width - widget.padding.horizontal) / 1.55,
                height: _animation.value * (widget.size.height - widget.padding.vertical) / 1.55,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }

  void _playAnimation() {
    _controller.forward(from: 0.0);
  }
}
