import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class StandingsTabView extends TabView {
  StandingsTabView() : super(const TabData('Standings', Icons.insert_chart, ViewNames.standingsTabView));

  @override
  _StandingsTabViewState createState() => _StandingsTabViewState();
}

class _StandingsTabViewState extends TabViewStateBase<StandingsTabView, StandingsTabViewModel> {
  @override
  Widget buildTabView(BuildContext context) {
    return StatTable(
      columns: [
        StatTableColumnData(title: 'Teams', flex: 2),
        StatTableColumnData(title: 'WIN', flex: 1),
        StatTableColumnData(title: 'LOSE', flex: 1),
        StatTableColumnData(title: 'WIN%', flex: 1),
        StatTableColumnData(title: 'GB', flex: 1),
      ],
      rows: viewModel.teams.map((t) {
        return StatTableRowData([
          StatTableCellData(
            Container(
              padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
              decoration: BoxDecoration(border: Border(right: BorderSide(color: Theme.of(context).dividerColor))),
              child: ExtendedRow(
                spacing: 8.0,
                children: <Widget>[
                  Text((viewModel.teams.indexOf(t) + 1).toString()),
                  Image.network(t.logoUrl, width: 24),
                  Text(t.teamNameAcronym)
                ],
              ),
            ),
          ),
          StatTableCellData(Container(child: Text(t.totalWins.toString(), textAlign: TextAlign.center))),
          StatTableCellData(Text(t.totalLose.toString(), textAlign: TextAlign.center)),
          StatTableCellData(Text(t.winPercentage.toString(), textAlign: TextAlign.center)),
          StatTableCellData(Text(t.gamesBehind.toString(), textAlign: TextAlign.center))
        ]);
      }).toList(),
      groupHeaderBuilder: (context, index) {
        if (index == 0) {
          return Container(
            padding: const EdgeInsets.only(left: 32, top: 8, bottom: 8),
            child: Text('NORTH', style: Theme.of(context).textTheme.caption),
            alignment: Alignment.centerLeft,
          );
        }
        return null;
      },
    );
  }
}
