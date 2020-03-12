import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass/widgets/model_bound_widget.dart';

abstract class ModelBoundTabWidget<TViewModel extends TabViewModelBase> extends ModelBoundWidget<TViewModel> {
  ModelBoundTabWidget(TViewModel viewModel, this.tabData) : super(viewModel, key: GlobalKey<ModelBoundTabState>());

  final TabData tabData;
}

abstract class ModelBoundTabState<TWidget extends ModelBoundTabWidget, TViewModel extends TabViewModelBase>
    extends ModelBoundState<TWidget, TViewModel> with AutomaticKeepAliveClientMixin<TWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @mustCallSuper
  void onTabNavigatedTo() {
    viewModel.onTabNavigatedTo();
  }

  @mustCallSuper
  void onTabNavigatedFrom() {
    viewModel.onTabNavigatedFrom();
  }
}

class TabData {
  const TabData(this.tabButtonText, this.tabButtonIcon, this.tabViewName);

  final String tabButtonText;
  final IconData tabButtonIcon;
  final String tabViewName;
}
