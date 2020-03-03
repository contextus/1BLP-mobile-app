import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class PlayersTabView extends ModelBoundTabWidget<PlayersTabViewModel> {
  PlayersTabView(PlayersTabViewModel viewModel) : super(viewModel, 'Players', Icons.person);

  @override
  _PlayersTabViewState createState() => _PlayersTabViewState();
}

class _PlayersTabViewState extends ModelBoundState<PlayersTabView, PlayersTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<PlayersTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<PlayersTabViewModel>(
        builder: (context, child, viewModel) {
          return Container(
            child: Center(child: Text(widget.text)),
          );
        },
      ),
    );
  }
}
