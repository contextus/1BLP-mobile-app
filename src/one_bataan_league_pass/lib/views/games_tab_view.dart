import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/models/game_model.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class GamesTabView extends ModelBoundTabWidget<GamesTabViewModel> {
  GamesTabView(GamesTabViewModel viewModel) : super(viewModel, 'Games', Icons.date_range);

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
          return Column(
            children: <Widget>[
              // Calendar strip
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: CalendarStrip(
                  containerHeight: 94.0,
                  onDateSelected: viewModel.onDateSelected,
                  dateTileBuilder: (date, selectedDate, rowIndex, dayName, isDayMarked, isDateOutOfRange) {
                    final defaultDateStyle = TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 81, 81, 84),
                    );
                    final selectedDateStyle = defaultDateStyle.copyWith(color: Colors.green);

                    return ExtendedColumn(
                      spacing: 8.0,
                      children: <Widget>[
                        Text(dayName, style: Theme.of(context).textTheme.caption),
                        Text(
                          date.day.toString(),
                          style: date == selectedDate ? selectedDateStyle : defaultDateStyle,
                        )
                      ],
                    );
                  },
                  addSwipeGesture: true,
                  monthNameWidget: (String month) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                month,
                                style: Theme.of(context).textTheme.body2.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 16.0,
                                height: 16.0,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  iconSize: 16.0,
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  iconColor: Color.fromARGB(255, 81, 81, 84),
                ),
              ),

              // Games list
              viewModel.selectedGames.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.selectedGames.length,
                      itemBuilder: (context, index) => GameCard(game: viewModel.selectedGames[index]),
                    )
                  : Expanded(child: Center(child: Text('No games for this date'))),
            ],
          );
        },
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    Key key,
    @required this.game,
  }) : super(key: key);

  final GameModel game;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
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
                      game.isGameFinished || game.isGameToday ? game.team1Score.toString() : '-',
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
                      game.isGameFinished || game.isGameToday ? game.team2Score.toString() : '-',
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
          ),
          game.isGameFinished ? Text('Final') : SizedBox(),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              game.isGameToday
                  ? Expanded(
                      flex: 1,
                      child: Center(
                        child: FlatButton(
                          child: ExtendedRow(
                            spacing: 4.0,
                            children: [
                              Icon(Icons.play_arrow, size: 12.0),
                              Text(
                                'WATCH LIVE',
                                style: Theme.of(context).textTheme.button.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  : SizedBox(),
              game.isGameFinished
                  ? Expanded(
                      flex: 1,
                      child: Center(
                        child: FlatButton(
                          child: ExtendedRow(
                            spacing: 4.0,
                            children: [
                              Icon(Icons.replay, size: 12.0),
                              Text(
                                'WATCH REPLAY',
                                style: Theme.of(context).textTheme.button.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
