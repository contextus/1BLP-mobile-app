import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class GamesTabView extends ModelBoundTabWidget<GamesTabViewModel> {
  GamesTabView(GamesTabViewModel viewModel) : super(viewModel, 'Games', Icons.play_circle_filled);

  @override
  _GamesTabViewState createState() => _GamesTabViewState();
}

class _GamesTabViewState extends ModelBoundState<GamesTabView, GamesTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<GamesTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<GamesTabViewModel>(
        builder: (context, child, viewModel) {
          return Container(
            child: Center(child: Text(widget.text)),
          );
        },
      ),
    );
  }
}
