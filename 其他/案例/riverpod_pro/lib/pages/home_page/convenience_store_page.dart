import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:riverpod_pro/pages/home_page/convenience_store_page.dart';
import 'package:riverpod_pro/service/home_provider.dart';
import 'package:riverpod_pro/utils/export_library.dart';

class ConveniencePage extends ConsumerWidget {
  ConveniencePage({Key? key}) : super(key: key);

  final convenienceStoreProvider = FutureProvider((ref) {
    return getHomeData();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: _appBarWidget(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(convenienceStoreProvider);
            return state.when(
              data: (data) {
                return data.success == true && data.result!.isNotEmpty
                    ? EasyRefresh(
                        onRefresh: () async {
                          ref.refresh(convenienceStoreProvider);
                        },
                        onLoad: () async {},
                        child: ListView.builder(
                          itemCount: data.result!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _convenienceStoreItem(context, index);
                          },
                        ),
                      )
                    : const Text('null data');
              },
              error: (o, s) {
                return const Text('net error');
              },
              loading: () {
                return const Text('loading');
              },
            );
          },
        ),
      ),
    );
  }

  /// appbar
  PreferredSizeWidget _appBarWidget(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: _backBtnWidget(context),
      title: const Text(
        'Convenience Store',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  /// 返回按钮
  Widget _backBtnWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// Convenience Item
  Widget _convenienceStoreItem(BuildContext context, int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
      padding: EdgeInsets.all(10.w),
      child: Column(
        children: [
          _topWidget(),
          _middleWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: const Divider(
              color: Colors.grey,
              height: 1,
            ),
          ),
          _bottomWidget(),
        ],
      ),
    );
  }

  // 底部视图
  Widget _bottomWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            top: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('invested assets'),
              Text(
                '1000.00',
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 180.w,
          height: 70.h,
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(35.h),
            ),
            color: Colors.green,
          ),
          child: Center(
            child: Text(
              'View Now',
              style: TextStyle(
                fontSize: 30.sp,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  // 中部视图
  Widget _middleWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 10.w),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.green,
                  size: 35.sp,
                ),
              ),
              Text(
                'Issue No  10.23',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, left: 10.w),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.green,
                  size: 35.sp,
                ),
              ),
              Text(
                'Countdown to purchase   15:09:23',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 上部视图
  Widget _topWidget() {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/雾气.jpg',
            width: 100.w,
            height: 100.w,
            fit: BoxFit.fill,
          ),
        ),
        Text(
          '9.9 Price Zone',
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
