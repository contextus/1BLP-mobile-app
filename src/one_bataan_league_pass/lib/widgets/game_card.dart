import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';

class GameCard extends StatelessWidget {
  GameCard(this.game, {Key key, this.buttons = const []}) : super(key: key);

  final GameEntity game;
  final List<GameCardButtonData> buttons;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: game.id,
      child: Card(
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
                          Image.network(game.team1.logoUrl, width: 40.0),
                          Text(
                            game.team1.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 40,
                      child: Text(
                        game.isGameUpcoming || (game.isGameToday && !game.isLive) ? '-' : game.team1Score.toString(),
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
                        game.isGameUpcoming || (game.isGameToday && !game.isLive) ? '-' : game.team2Score.toString(),
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
                          Image.network(game.team2.logoUrl, width: 40.0),
                          Text(
                            game.team2.name,
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
              buttons.isNotEmpty ? Divider() : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttons.map((a) {
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
                              style: Theme.of(context).textTheme.button,
                            ),
                          ],
                        ),
                        onPressed: () => a.action(game),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
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
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32),
              child: Row(
                children: const <Widget>[
                  Expanded(child: LoadingContainer(height: 56)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameCardButtonData {
  GameCardButtonData(this.text, this.icon, this.action);

  final String text;
  final IconData icon;
  final void Function(GameEntity) action;
}
