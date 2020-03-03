import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class HomeTabView extends ModelBoundTabWidget<HomeTabViewModel> {
  HomeTabView(HomeTabViewModel viewModel) : super(viewModel, 'Home', Icons.home);

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
              Card(
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: <Widget>[
                      // Header
                      ExtendedColumn(
                        spacing: 8.0,
                        children: <Widget>[
                          Text(
                            'PLAYOFFS QUARTER FINALS',
                            style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '2020 March 27 | Mariveles, Bataan',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),

                      // Game Score
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ExtendedRow(
                          spacing: 24,
                          children: <Widget>[
                            // TEAM 1
                            SizedBox(
                              width: 80,
                              child: ExtendedColumn(
                                spacing: 12.0,
                                children: <Widget>[
                                  Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
                                    width: 40.0,
                                  ),
                                  Text(
                                    '1Bataan Risers',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: 40,
                              child: Text(
                                '35',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 32,
                              child: Text(
                                'vs',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Text(
                                '22',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),

                            // TEAM 2
                            SizedBox(
                              width: 80,
                              child: ExtendedColumn(
                                spacing: 12.0,
                                children: <Widget>[
                                  Image.network(
                                      'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
                                      width: 40.0),
                                  Text(
                                    'A Team',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Footer
                      Divider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: ExtendedRow(
                            spacing: 4.0,
                            children: [
                              Icon(Icons.share, size: 12.0),
                              Text('SHARE', style: Theme.of(context).textTheme.button.copyWith(fontSize: 12)),
                            ],
                          ),
                          onPressed: viewModel.onShareLiveGame,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
