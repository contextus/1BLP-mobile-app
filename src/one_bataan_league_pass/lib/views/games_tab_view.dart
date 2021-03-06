import 'package:calendar_strip/calendar_strip.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/utils.dart';

class GamesTabView extends TabView {
  GamesTabView() : super(const TabData('Games', Icons.date_range, ViewNames.gamesTabView));

  @override
  _GamesTabViewState createState() => _GamesTabViewState();
}

class _GamesTabViewState extends TabViewStateBase<GamesTabView, GamesTabViewModel> {
  @override
  Widget buildTabView(BuildContext context) {
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
            dateTileBuilder: (
              DateTime date,
              DateTime selectedDate,
              int rowIndex,
              String dayName,
              bool isDayMarked,
              bool isDateOutOfRange,
            ) {
              final defaultDateStyle =
                  TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).customTheme().tertiaryTextColor);
              final selectedDateStyle = defaultDateStyle.copyWith(color: Theme.of(context).accentColor);

              return Container(
                padding: const EdgeInsets.all(2),
                decoration: date.isOnTheSameDay(DateTime.now())
                    ? BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Theme.of(context).accentColor, style: BorderStyle.solid, width: 1),
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
        FutureBuilder<List<GameEntity>>(
          future: viewModel.getGamesForDate,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GameCardSkeleton();
            } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
              return Expanded(
                child: snapshot.data.isNotEmpty
                    ? _buildGamesListView(snapshot.data)
                    : Center(child: Text('No games for this date')),
              );
            } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Text('Could not retrieve games.'),
                ),
              );
            }

            return ErrorWidget('Unhandled $snapshot state');
          },
        ),
      ],
    );
  }

  Widget _buildGamesListView(List<GameEntity> games) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refetchGamesForCurrentDate(),
      child: ListView.separated(
        itemCount: games.length,
        separatorBuilder: (context, index) => SizedBox(height: 1),
        itemBuilder: (context, index) => _buildGameCard(games[index]),
      ),
    );
  }

  Widget _buildGameCard(GameEntity game) {
    List<GameCardButtonData> actions = [];

    if (game.isGameToday && game.isLive) {
      actions = [
        GameCardButtonData(
          'WATCH LIVE',
          Icons.play_arrow,
          viewModel.onWatchLive,
        )
      ];
    }

    if (game.isGameFinished) {
      actions = [
        GameCardButtonData(
          'WATCH REPLAY',
          Icons.play_arrow,
          viewModel.onWatchReplay,
        ),
        GameCardButtonData(
          'GAME RECAP',
          Icons.replay,
          viewModel.onViewGameRecap,
        ),
      ];
    }

    return GameCard(game, buttons: actions, heroTag: game.id);
  }
}
