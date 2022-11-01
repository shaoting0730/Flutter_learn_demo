import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:riverpod_pro/utils/export_library.dart';
import 'package:riverpod_pro/pages/home_page/state/counter.dart';
import 'package:riverpod_pro/widgets/empty_data_widget.dart';
import 'package:riverpod_pro/widgets/error_widget.dart';
import 'package:riverpod_pro/widgets/loading_widget.dart';
import 'package:riverpod_pro/service/home_provider.dart';

import 'convenience_store_page.dart';
import 'model/home_page_model.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final homeProvider = FutureProvider((ref) {
    return getHomeData();
  });

  push(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConveniencePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homeTitle!),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => push(context),
            child: Text('push push'),
          ),
          _numWidget(ref),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeProvider);
          return state.when(
            data: (data) {
              return data.success == true && data.result!.isNotEmpty
                  ? EasyRefresh(
                      onRefresh: () async {
                        ref.refresh(homeProvider);
                        // getHomeData();
                      },
                      onLoad: () async {},
                      child: ListView.builder(
                        itemCount: data.result?.length,
                        itemBuilder: (context, index) {
                          return _homeListItem(context, index, data);
                        },
                      ),
                    )
                  : const EmptyDataWidget();
            },
            error: (o, s) {
              return const NetErrorWidget();
            },
            loading: () {
              return const LoadingWidget();
            },
          );
        },
      ),
    );
  }

  // 单个item
  _homeListItem(BuildContext context, int index, HomeDataModel data) {
    return Column(
      children: [
        Text(
          '币种缩写：${data.result![index]?.Asset}',
        ),
        Text(
          '币种全称：${data.result![index]?.AssetLong}',
        ),
        Text(
          '系统代理：${data.result![index]?.SystemProtocol}',
        ),
        Text(
          '是否活跃：${data.result![index]?.IsActive}',
        ),
        SizedBox(
          height: 11.h,
        ),
      ],
    );
  }

  _numWidget(WidgetRef ref) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            ref.read(counterProvider.notifier).addCounter();
          },
          child: Text(
            '+',
            style: TextStyle(fontSize: 50.sp),
          ),
        ),
        const SizedBox(width: 10),
        const _ColorfulCounterText(),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            ref.read(counterProvider.notifier).subCounter();
          },
          child: Text(
            '-',
            style: TextStyle(fontSize: 50.sp),
          ),
        ),
      ],
    );
  }
}

class _ColorfulCounterText extends ConsumerWidget {
  const _ColorfulCounterText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Text(
      '$counter',
      style: TextStyle(fontSize: 40.sp),
    );
  }
}
