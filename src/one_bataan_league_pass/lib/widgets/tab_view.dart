import 'package:arch/arch.dart';
import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_common/common.dart';

abstract class TabView extends StatefulWidget {
  TabView(this.tabData) : super(key: GlobalKey<TabViewStateBase>());

  final TabData tabData;
}

abstract class TabViewStateBase<TWidget extends TabView, TViewModel extends TabViewModelBase>
    extends AutomaticKeepAliveViewStateBase<TWidget, TViewModel> {
  @mustCallSuper
  void onTabNavigatedTo([Map<String, Object> parameters]) => viewModel.onTabNavigatedTo(parameters);

  @mustCallSuper
  void onTabNavigatedFrom() => viewModel.onTabNavigatedFrom();
}

class TabData {
  const TabData(this.tabButtonText, this.tabButtonIcon, this.tabViewName);

  final String tabButtonText;

  final IconData tabButtonIcon;

  final String tabViewName;
}
