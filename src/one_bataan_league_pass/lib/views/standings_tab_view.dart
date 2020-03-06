import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class StandingsTabView extends ModelBoundTabWidget<StandingsTabViewModel> {
  StandingsTabView(StandingsTabViewModel viewModel, String tabViewName)
      : super(viewModel, tabButtonText: 'Standings', tabButtonIcon: Icons.insert_chart, tabViewName: tabViewName);

  @override
  _StandingsTabViewState createState() => _StandingsTabViewState();
}

class _StandingsTabViewState extends ModelBoundState<StandingsTabView, StandingsTabViewModel>
    with AutomaticKeepAliveClientMixin<StandingsTabView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScopedModel<StandingsTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<StandingsTabViewModel>(
        builder: (context, child, viewModel) {
          return Container(
            child: DataTable(
              columnSpacing: 12.0,
              columns: [
                DataColumn(label: Text('TEAMS')),
                DataColumn(label: Text('WIN'), numeric: true),
                DataColumn(label: Text('LOSE'), numeric: true),
                DataColumn(label: Text('WIN %'), numeric: true),
                DataColumn(label: Text('GB'), numeric: true),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('NORTH')),
                    DataCell(SizedBox()),
                    DataCell(SizedBox()),
                    DataCell(SizedBox()),
                    DataCell(SizedBox()),
                  ],
                ),
              ]..addAll(viewModel.teams.map((t) {
                  return DataRow(
                    cells: [
                      DataCell(
                        ExtendedRow(
                          spacing: 8.0,
                          children: <Widget>[
                            Text((viewModel.teams.indexOf(t) + 1).toString()),
                            Image.network(t.teamImageUrl, width: 24),
                            Text(t.teamNameAcronym)
                          ],
                        ),
                      ),
                      DataCell(Text(t.totalWins.toString())),
                      DataCell(Text(t.totalLose.toString())),
                      DataCell(Text(t.winPercentage.toString())),
                      DataCell(Text(t.gamesBehind.toString())),
                    ],
                  );
                })),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
