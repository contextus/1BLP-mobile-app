import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:flutter/widgets.dart';

abstract class ModelBoundWidget<TViewModel extends ViewModelBase> extends StatefulWidget {
  ModelBoundWidget(this.viewModel, {Key key}) : super(key: key);

  final TViewModel viewModel;
}

abstract class ModelBoundState<TWidget extends ModelBoundWidget, TViewModel extends ViewModelBase>
    extends State<TWidget> {
  TViewModel _viewModel;

  TViewModel get viewModel => _viewModel;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
  }

  @override
  @mustCallSuper
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
