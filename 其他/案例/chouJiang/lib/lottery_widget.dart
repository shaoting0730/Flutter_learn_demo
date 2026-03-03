/// createTime: 2022/10/19 on 10:39
/// desc:
///
/// @author azhon
import 'package:flutter/material.dart';

class LotteryWidget extends StatefulWidget {
  final List<LotteryEntity> list;

  const LotteryWidget({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LotteryWidgetState();
}

class _LotteryWidgetState extends State<LotteryWidget>
    with TickerProviderStateMixin {
  ///资源图片
  final String startPng = 'assets/images/ic_lottery_start.png';
  final String unSelectPng = 'assets/images/ic_lottery_un_select.png';
  final String selectPng = 'assets/images/ic_lottery_select.png';

  ///奖品个数
  final int _giftCount = 8;

  ///抽奖动画
  late Animation<int> _animation;
  late AnimationController _controller;

  ///按钮动画
  late Animation<double> _btnAnimation;
  late AnimationController _btnController;

  @override
  void initState() {
    super.initState();
    widget.list.insert(4, LotteryEntity('', start: true));

    ///中奖ipad
    _initAnimation(3);
    _initBtnAnimation();
  }

  void _initAnimation(int target, {int cycle = 8}) {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5500),
    );
    _animation = StepTween(begin: 0, end: _giftCount * cycle + target).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
  }

  void _initBtnAnimation() {
    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _btnAnimation = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(parent: _btnController, curve: Curves.ease),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.list.length,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 1,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return _buildItem(widget.list[index], index);
      },
    );
  }

  Widget _buildItem(LotteryEntity item, int index) {
    if (item.start) {
      return AnimatedBuilder(
        animation: _btnAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _btnController.status == AnimationStatus.forward
                ? _btnAnimation.value
                : 1,
            child: GestureDetector(
              onTap: _start,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(startPng),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '立即抽奖',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        String image = unSelectPng;
        Color color = const Color(0xFFFF9A3D);
        if (_controller.status != AnimationStatus.dismissed) {
          image = _animationIndex == index ? selectPng : unSelectPng;
          color = _animationIndex == index
              ? const Color(0xFFFF443d)
              : const Color(0xFFFF9A3D);
        }
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
            ),
          ),
          child: Center(
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }

  void _start() {
    if (AnimationStatus.forward == _controller.status) {
      return;
    }
    _controller.reset();
    _controller.forward();
    _btnController.reset();
    _btnController.forward();
  }

  ///下标的转换
  int get _animationIndex {
    return [0, 1, 2, 5, 8, 7, 6, 3][_animation.value % _giftCount];
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class LotteryEntity {
  final String name;
  final bool start;

  LotteryEntity(
    this.name, {
    this.start = false,
  });
}
