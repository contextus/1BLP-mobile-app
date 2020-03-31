import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass/widgets/views.dart';
import 'package:one_bataan_league_pass_common/common.dart';
import 'package:provider/provider.dart';

abstract class TabView extends StatefulWidget {
  TabView(this.tabData) : super(key: GlobalKey<TabViewStateBase>());

  final TabData tabData;
}

abstract class TabViewStateBase<TWidget extends TabView, TViewModel extends TabViewModelBase>
    extends ViewStateBase<TWidget, TViewModel> with AutomaticKeepAliveClientMixin<TWidget> {
  @override
  bool get wantKeepAlive => true;

  @mustCallSuper
  void onTabNavigatedTo([Map<String, Object> parameters]) => viewModel.onTabNavigatedTo(parameters);

  @mustCallSuper
  void onTabNavigatedFrom() => viewModel.onTabNavigatedFrom();

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListenableProvider<TViewModel>(
      create: (_) {
        viewModel?.init();
        didInitViewModel();
        return viewModel;
      },
      child: Consumer<TViewModel>(builder: (context, _, __) => buildView(context)),
    );
  }
}

class TabData {
  const TabData(this.tabButtonText, this.tabButtonIcon, this.tabViewName);

  final String tabButtonText;

  final IconData tabButtonIcon;

  final String tabViewName;
}
