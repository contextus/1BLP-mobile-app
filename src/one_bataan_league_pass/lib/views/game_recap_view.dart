import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class GameRecapView extends ModelBoundWidget<GameRecapViewModel> {
  GameRecapView(GameRecapViewModel viewModel) : super(viewModel);

  @override
  _GameRecapViewState createState() => _GameRecapViewState();
}

class _GameRecapViewState extends ModelBoundState<GameRecapView, GameRecapViewModel> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/1bl_video.mp4'); // TODO: Change to [viewModel.gameToWatch.gameVideoUrl].
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GameRecapViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<GameRecapViewModel>(
        builder: (context, child, viewModel) {
          return Hero(
            tag: viewModel.game.id,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Game Recap'),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: ExtendedColumn(
                  spacing: 8.0,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Chewie(controller: _chewieController),
                        ),
                        GameCard(viewModel.game),
                        _buildTeamsStat(),
                      ],
                    ),
                    _buildGameSummary(),
                    _buildGameLeaderBoard(),
                    _buildTeamComparison(),
                    _buildGameInfo(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeamsStat() {
    return StatTable(
      columns: const [
        StatTableColumnData(title: 'TEAMS', flex: 2),
        StatTableColumnData(title: 'Q1', flex: 1),
        StatTableColumnData(title: 'Q2', flex: 1),
        StatTableColumnData(title: 'Q3', flex: 1),
        StatTableColumnData(title: 'Q4', flex: 1),
        StatTableColumnData(title: 'TOTAL', flex: 1),
      ],
      rows: viewModel.gameResults.map((r) {
        final teamNameAcronym = r.team.name.split(' ').map((n) => n[0]).join().toUpperCase();
        return StatTableRowData([
          StatTableCellData(
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border(right: BorderSide(color: Theme.of(context).dividerColor))),
              child: Text(teamNameAcronym, textAlign: TextAlign.center),
            ),
          ),
          StatTableCellData(Text('${r.q1}', textAlign: TextAlign.center)),
          StatTableCellData(Text('${r.q2}', textAlign: TextAlign.center)),
          StatTableCellData(Text('${r.q3}', textAlign: TextAlign.center)),
          StatTableCellData(Text('${r.q4}', textAlign: TextAlign.center)),
          StatTableCellData(Text('${r.total}', textAlign: TextAlign.center)),
        ]);
      }).toList(),
    );
  }

  Widget _buildGameSummary() {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExtendedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text('Match Up Summary', style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold)),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.body2,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGameLeaderBoard() {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Game Leaders', style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ExtendedColumn(
                spacing: 16,
                children: List.generate(5, (index) {
                  final currentCategory = GameLeaderCategory.values[index];
                  final currentLeaderTeam1 =
                      viewModel.team1GameLeaders.firstWhere((l) => l.category == currentCategory);
                  final currentLeaderTeam2 =
                      viewModel.team2GameLeaders.firstWhere((l) => l.category == currentCategory);
                  final team1Acronym =
                      currentLeaderTeam1.player.playerTeam.team.name.split(' ').map((n) => n[0]).join().toUpperCase();
                  final team2Acronym =
                      currentLeaderTeam2.player.playerTeam.team.name.split(' ').map((n) => n[0]).join().toUpperCase();
                  final isTeam1ScoreHigher = currentLeaderTeam1.score > currentLeaderTeam2.score;
                  final bothScoresAreEqual = currentLeaderTeam1.score == currentLeaderTeam2.score;

                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        // TEAM 1
                        Expanded(
                          child: ExtendedColumn(
                            spacing: 12.0,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(currentLeaderTeam1.player.imageUrl),
                                backgroundColor: Colors.transparent,
                                radius: 40.0,
                              ),
                              Text(
                                '${currentLeaderTeam1.player.firstName} ${currentLeaderTeam1.player.lastName}',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: team1Acronym),
                                    TextSpan(text: ' | '),
                                    TextSpan(text: '#${currentLeaderTeam1.player.playerTeam.playerNum}'),
                                    TextSpan(text: ' | '),
                                    TextSpan(text: currentLeaderTeam1.player.playerTeam.formattedPositions),
                                  ],
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              )
                            ],
                          ),
                        ),

                        Expanded(
                          child: Text(
                            currentLeaderTeam1.score.toString(),
                            textAlign: TextAlign.center,
                            style: isTeam1ScoreHigher || bothScoresAreEqual
                                ? Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                : Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _getGameLeaderCategoryString(currentCategory),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            currentLeaderTeam2.score.toString(),
                            textAlign: TextAlign.center,
                            style: !isTeam1ScoreHigher || bothScoresAreEqual
                                ? Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)
                                : Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),

                        // TEAM 2
                        Expanded(
                          child: ExtendedColumn(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            spacing: 12.0,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(currentLeaderTeam2.player.imageUrl),
                                backgroundColor: Colors.transparent,
                                radius: 40.0,
                              ),
                              Text(
                                '${currentLeaderTeam2.player.firstName} ${currentLeaderTeam2.player.lastName}',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: team2Acronym),
                                    TextSpan(text: ' | '),
                                    TextSpan(text: '#${currentLeaderTeam2.player.playerTeam.playerNum}'),
                                    TextSpan(text: ' | '),
                                    TextSpan(text: currentLeaderTeam2.player.playerTeam.formattedPositions),
                                  ],
                                  style: Theme.of(context).textTheme.caption.copyWith(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamComparison() {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ExtendedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text('Team Comparison', style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold)),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.network(viewModel.game.team1.logoUrl, width: 40),
                  Image.network(viewModel.game.team2.logoUrl, width: 40),
                ],
              ),
            ),

            // Field Goals
            ExtendedColumn(
              spacing: 8,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${viewModel.team1GameResult.fieldGoals}/${viewModel.team1GameResult.totalFieldGoals} (${viewModel.team1GameResult.fieldGoalPercentage.toStringAsFixed(1)}%)',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'FIELD GOALS',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '(${viewModel.team2GameResult.fieldGoalPercentage.toStringAsFixed(1)}%) ${viewModel.team2GameResult.fieldGoals}/${viewModel.team2GameResult.totalFieldGoals}',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                ExtendedRow(
                  spacing: 8,
                  children: <Widget>[
                    Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue[50],
                        value: viewModel.team1GameResult.fieldGoalPercentage / 100,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                        value: ((viewModel.team2GameResult.fieldGoalPercentage / 100) - 1.0).abs(),
                        valueColor: AlwaysStoppedAnimation(Colors.red[50]),
                      ),
                    )
                  ],
                )
              ],
            ),

            // 3 Pointers
            ExtendedColumn(
              spacing: 8,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${viewModel.team1GameResult.threePointers}/${viewModel.team1GameResult.totalThreePointers} (${viewModel.team1GameResult.threePointerPercentage.toStringAsFixed(1)}%)',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '3 POINTERS',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '(${viewModel.team2GameResult.threePointerPercentage.toStringAsFixed(1)}%) ${viewModel.team2GameResult.threePointers}/${viewModel.team2GameResult.totalThreePointers}',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                ExtendedRow(
                  spacing: 8,
                  children: <Widget>[
                    Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue[50],
                        value: viewModel.team1GameResult.threePointerPercentage / 100,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                        value: ((viewModel.team2GameResult.threePointerPercentage / 100) - 1.0).abs(),
                        valueColor: AlwaysStoppedAnimation(Colors.red[50]),
                      ),
                    )
                  ],
                )
              ],
            ),

            // Free Throws
            ExtendedColumn(
              spacing: 8,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${viewModel.team1GameResult.freeThrows}/${viewModel.team1GameResult.totalFreeThrows} (${viewModel.team1GameResult.freeThrowPercentage.toStringAsFixed(1)}%)',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'FREE THROWS',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '(${viewModel.team2GameResult.freeThrowPercentage.toStringAsFixed(1)}%) ${viewModel.team2GameResult.freeThrows}/${viewModel.team2GameResult.totalFreeThrows}',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                ExtendedRow(
                  spacing: 8,
                  children: <Widget>[
                    Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.blue[50],
                        value: viewModel.team1GameResult.freeThrowPercentage / 100,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                      ),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red,
                        value: ((viewModel.team2GameResult.freeThrowPercentage / 100) - 1.0).abs(),
                        valueColor: AlwaysStoppedAnimation(Colors.red[50]),
                      ),
                    )
                  ],
                )
              ],
            ),
            Divider(),
            Center(
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).accentColor,
                child: ExtendedRow(
                  children: <Widget>[
                    Text('See All'),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(0),
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Game Info',
              style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: viewModel.gameDetails.map((p) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    title: Text(p.fieldName, style: Theme.of(context).textTheme.caption),
                    subtitle: Text(
                      p.fieldValue,
                      style: TextStyle(color: Theme.of(context).customTheme().primaryTextColor),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ],
    );
  }

  static String _getGameLeaderCategoryString(GameLeaderCategory category) {
    switch (category) {
      case GameLeaderCategory.points:
        return 'POINTS';
      case GameLeaderCategory.rebounds:
        return 'REBOUNDS';
      case GameLeaderCategory.assists:
        return 'ASSISTS';
      case GameLeaderCategory.steals:
        return 'STEALS';
      case GameLeaderCategory.blocks:
        return 'BLOCKS';
    }
    throw UnimplementedError('');
  }
}
