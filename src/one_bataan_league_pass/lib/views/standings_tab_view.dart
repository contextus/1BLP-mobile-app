import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class StandingsTabView extends ModelBoundTabWidget<StandingsTabViewModel> {
  StandingsTabView(StandingsTabViewModel viewModel) : super(viewModel, 'Standings', Icons.insert_chart);

  @override
  _StandingsTabViewState createState() => _StandingsTabViewState();
}

class _StandingsTabViewState extends ModelBoundState<StandingsTabView, StandingsTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<StandingsTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<StandingsTabViewModel>(
        builder: (context, child, viewModel) {
          return Container(
            child: Center(child: Text(widget.text)),
          );
        },
      ),
    );
  }
}
