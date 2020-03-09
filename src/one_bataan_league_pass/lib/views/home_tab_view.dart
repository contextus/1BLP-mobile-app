import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';

class HomeTabView extends ModelBoundTabWidget<HomeTabViewModel> {
  HomeTabView(HomeTabViewModel viewModel, String tabViewName)
      : super(viewModel, tabButtonText: 'Home', tabButtonIcon: Icons.home, tabViewName: tabViewName);

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends ModelBoundState<HomeTabView, HomeTabViewModel>
    with AutomaticKeepAliveClientMixin<HomeTabView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

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
              FutureBuilder<GameEntity>(
                future: viewModel.getLiveGameTask,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return GameCardSkeleton();
                  } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                    return GameCard(
                      game: snapshot.data,
                      actions: [
                        GameCardAction(
                          'SHARE',
                          icon: Icons.share,
                          action: viewModel.shareLiveGame,
                        )
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text('Could not retrieve the current live game.'),
                      ),
                    );
                  }

                  throw UnimplementedError('Unhandled $snapshot state');
                },
              )

              // GameCard(
              //   game: viewModel.game,
              //   actions: [
              //     GameCardAction(
              //       'SHARE',
              //       icon: Icons.share,
              //       action: viewModel.onShareLiveGame,
              //     )
              //   ],
              // ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
