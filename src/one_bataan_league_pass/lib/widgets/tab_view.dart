import 'package:arch/arch.dart';
import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_common/common.dart';

abstract class TabView extends StatefulWidget {
  TabView(this.tabData) : super(key: GlobalKey<TabViewStateBase>());

  final TabData tabData;
}

abstract class TabViewStateBase<TWidget extends TabView, TTabViewModel extends TabViewModelBase>
    extends ViewModelBoundState<TWidget, TTabViewModel>
    with AutomaticKeepAliveClientMixin, ViewModelAutoResolver, ViewModelInitializer {
  @override
  @nonVirtual
  bool get wantKeepAlive => true;

  @mustCallSuper
  void onTabNavigatedTo([Map<String, Object> parameters]) => viewModel.onTabNavigatedTo(parameters);

  @mustCallSuper
  void onTabNavigatedFrom() => viewModel.onTabNavigatedFrom();

  /// Called whenever [viewModel] calls [ChangeNotifier.notifyListeners].
  ///
  /// Build the tab view's UI here.
  Widget buildTabView(BuildContext context);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    super.build(context);

    return ChangeNotifierBuilder<TTabViewModel>(
      create: () => viewModel,
      builder: (context, _, __) => buildTabView(context),
    );
  }
}

class TabData {
  const TabData(this.tabButtonText, this.tabButtonIcon, this.tabViewName);

  final String tabButtonText;

  final IconData tabButtonIcon;

  final String tabViewName;
}
