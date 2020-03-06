import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class GamesTabView extends ModelBoundTabWidget<GamesTabViewModel> {
  GamesTabView(GamesTabViewModel viewModel, String tabViewName)
      : super(viewModel, tabButtonText: 'Games', tabButtonIcon: Icons.date_range, tabViewName: tabViewName);

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
          return ExtendedColumn(
            spacing: 8,
            children: <Widget>[
              // Calendar strip
              Container(
                color: Theme.of(context).canvasColor,
                padding: const EdgeInsets.all(8.0),
                child: CalendarStrip(
                  containerHeight: 96.0,
                  onDateSelected: viewModel.onDateSelected,
                  dateTileBuilder: (date, selectedDate, rowIndex, dayName, isDayMarked, isDateOutOfRange) {
                    final defaultDateStyle = TextStyle(
                        fontWeight: FontWeight.bold, color: Theme.of(context).customTheme().tertiaryTextColor);
                    final selectedDateStyle = defaultDateStyle.copyWith(color: Theme.of(context).accentColor);
                    final dateTimeNow = DateTime.now();
                    final isSelectedDateToday =
                        date.month == dateTimeNow.month && date.day == dateTimeNow.day && date.year == dateTimeNow.year;

                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: isSelectedDateToday
                          ? BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: Theme.of(context).accentColor, style: BorderStyle.solid, width: 1),
                            )
                          : null,
                      child: ExtendedColumn(
                        spacing: 8.0,
                        children: <Widget>[
                          Text(dayName, style: Theme.of(context).textTheme.caption),
                          Text(
                            date.day.toString(),
                            style: date == selectedDate ? selectedDateStyle : defaultDateStyle,
                          )
                        ],
                      ),
                    );
                  },
                  addSwipeGesture: true,
                  monthNameWidget: (month) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(flex: 1, child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                month.toUpperCase(),
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
                  iconColor: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              // Games list
              viewModel.selectedGames.isNotEmpty
                  ? _buildGamesListView()
                  : Expanded(child: Center(child: Text('No games for this date'))),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGamesListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModel.selectedGames.length,
      itemBuilder: (context, index) {
        final game = viewModel.selectedGames[index];
        List<GameCardAction> actions = [];

        if (game.isGameToday) {
          actions = [
            GameCardAction(
              'WATCH LIVE',
              icon: Icons.play_arrow,
              action: viewModel.onWatchLive,
            ),
          ];
        }

        if (game.isGameFinished) {
          actions = [
            GameCardAction(
              'WATCH REPLAY',
              icon: Icons.replay,
              action: () {},
            )
          ];
        }

        return GameCard(game: game, actions: actions);
      },
    );
  }
}
