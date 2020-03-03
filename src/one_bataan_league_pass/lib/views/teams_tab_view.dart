import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class TeamsTabView extends ModelBoundTabWidget<TeamsTabViewModel> {
  TeamsTabView(TeamsTabViewModel viewModel) : super(viewModel, 'Teams', Icons.group);

  @override
  _TeamsTabViewState createState() => _TeamsTabViewState();
}

class _TeamsTabViewState extends ModelBoundState<TeamsTabView, TeamsTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TeamsTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<TeamsTabViewModel>(
        builder: (context, child, viewModel) {
          return Container(
            child: Center(child: Text(widget.text)),
          );
        },
      ),
    );
  }
}
