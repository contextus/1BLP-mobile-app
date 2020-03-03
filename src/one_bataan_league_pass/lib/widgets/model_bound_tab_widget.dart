import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass/widgets/model_bound_widget.dart';

abstract class ModelBoundTabWidget<TViewModel extends ViewModelBase> extends ModelBoundWidget<TViewModel> {
  ModelBoundTabWidget(
    TViewModel viewModel,
    this.text,
    this.icon, {
    Key key,
  }) : super(viewModel, key: key);

  final String text;
  final IconData icon;
}
