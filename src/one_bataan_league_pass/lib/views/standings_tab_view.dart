import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class StandingsTabView extends ModelBoundTabWidget<StandingsTabViewModel> {
  StandingsTabView(StandingsTabViewModel viewModel) : super(viewModel, 'Standings', Icons.insert_chart);

  @override
  _StandingsTabViewState createState() => _StandingsTabViewState();
}

class _StandingsTabViewState extends ModelBoundState<StandingsTabView, StandingsTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<StandingsTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<StandingsTabViewModel>(
        builder: (context, child, viewModel) {
          return DataTable(
            columnSpacing: 12.0,
            columns: [
              DataColumn(label: Text('TEAMS')),
              DataColumn(label: Text('WIN'), numeric: true),
              DataColumn(label: Text('LOSE'), numeric: true),
              DataColumn(label: Text('WIN %'), numeric: true),
              DataColumn(label: Text('GB'), numeric: true),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('NORTH')),
                DataCell(SizedBox()),
                DataCell(SizedBox()),
                DataCell(SizedBox()),
                DataCell(SizedBox()),
              ]),
              DataRow(cells: [
                DataCell(ExtendedRow(
                  spacing: 8.0,
                  children: <Widget>[
                    Text('1'),
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
                      width: 24,
                    ),
                    Text('ABC')
                  ],
                )),
                DataCell(Text('41')),
                DataCell(Text('18')),
                DataCell(Text('69')),
                DataCell(Text('10.0')),
              ]),
              DataRow(cells: [
                DataCell(ExtendedRow(
                  spacing: 8.0,
                  children: <Widget>[
                    Text('2'),
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
                      width: 24,
                    ),
                    Text('1BR')
                  ],
                )),
                DataCell(Text('42')),
                DataCell(Text('17')),
                DataCell(Text('68')),
                DataCell(Text('9.0')),
              ]),
              DataRow(cells: [
                DataCell(ExtendedRow(
                  spacing: 8.0,
                  children: <Widget>[
                    Text('3'),
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
                      width: 24,
                    ),
                    Text('DEF')
                  ],
                )),
                DataCell(Text('32')),
                DataCell(Text('12')),
                DataCell(Text('45')),
                DataCell(Text('12')),
              ]),
            ],
          );
        },
      ),
    );
  }

  static String _percentageString(double divisor, double dividend) => (divisor / dividend).toString();
}
