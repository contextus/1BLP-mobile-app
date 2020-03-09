import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';

class GameCard extends StatelessWidget {
  GameCard({Key key, @required this.game, this.actions = const []}) : super(key: key);

  final GameEntity game;
  final List<GameCardAction> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  game.gameSeries.toUpperCase(),
                  style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: DateFormat('MMMM dd, y').format(game.gameDate)),
                      TextSpan(text: ' | '),
                      TextSpan(text: game.gameLocation),
                    ],
                    style: Theme.of(context).textTheme.caption,
                  ),
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
                        Image.network(game.team1.teamImageUrl, width: 40.0),
                        Text(
                          game.team1.teamName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 40,
                    child: Text(
                      game.isGameUpcoming ? '-' : game.team1Score.toString(),
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
                      game.isGameUpcoming ? '-' : game.team2Score.toString(),
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
                        Image.network(game.team2.teamImageUrl, width: 40.0),
                        Text(
                          game.team2.teamName,
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
            actions.isNotEmpty ? Divider() : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: actions.map((a) {
                return Expanded(
                  flex: 1,
                  child: Center(
                    child: FlatButton(
                      child: ExtendedRow(
                        spacing: 4.0,
                        children: [
                          Icon(a.icon, size: 12.0),
                          Text(
                            a.text,
                            style: Theme.of(context).textTheme.button.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      onPressed: a.action,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class GameCardSkeleton extends StatelessWidget {
  const GameCardSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ExtendedColumn(
              spacing: 8.0,
              children: const <Widget>[
                LoadingContainer(height: 28, width: 156),
                LoadingContainer(height: 16, width: 156),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ExtendedRow(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 24,
                children: const <Widget>[
                  LoadingContainer(width: 80, height: 80),
                  LoadingContainer(width: 40, height: 40),
                  LoadingContainer(width: 32, height: 32),
                  LoadingContainer(width: 40, height: 40),
                  LoadingContainer(width: 80, height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameCardAction {
  GameCardAction(this.text, {this.icon, this.action});

  final String text;
  final IconData icon;
  final void Function() action;
}
