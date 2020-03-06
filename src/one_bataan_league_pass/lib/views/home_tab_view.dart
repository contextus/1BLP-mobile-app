import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class HomeTabView extends ModelBoundTabWidget<HomeTabViewModel> {
  HomeTabView(HomeTabViewModel viewModel, String tabViewName)
      : super(viewModel, tabButtonText: 'Home', tabButtonIcon: Icons.home, tabViewName: tabViewName);

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends ModelBoundState<HomeTabView, HomeTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<HomeTabViewModel>(
        builder: (context, child, viewModel) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey,
                  child: Center(
                    child: IconButton(
                      iconSize: 56.0,
                      color: Colors.white,
                      icon: Icon(Icons.play_circle_outline),
                      onPressed: () {
                        // Handle play
                      },
                    ),
                  ),
                ),
              ),
              GameCard(
                game: viewModel.game,
                actions: [
                  GameCardAction(
                    'SHARE',
                    icon: Icons.share,
                    action: viewModel.onShareLiveGame,
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
