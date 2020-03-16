import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';
import 'package:one_bataan_league_pass/widgets/extended_column.dart';

class StatTableColumnData {
  const StatTableColumnData({this.title, this.flex = 1});

  final String title;
  final int flex;
}

class StatTableRowData {
  StatTableRowData(this.children);

  final List<Widget> children;
}

class StatTable extends StatelessWidget {
  StatTable({Key key, @required this.columnData, @required this.rowData}) : super(key: key) {
    if (rowData.isNotEmpty) {
      assert(rowData.every((r) => r.children.length == columnData.length));
    }
  }

  final List<StatTableColumnData> columnData;
  final List<StatTableRowData> rowData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: columnData.map((h) {
              return Expanded(
                flex: h.flex,
                child: Text(
                  h.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).customTheme().primaryTextColor),
                ),
              );
            }).toList(),
          ),
        ),
        Column(
          children: rowData.map((r) {
            return Card(
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: r.children.map((w) {
                    final flex = columnData.elementAt(r.children.indexOf(w)).flex;
                    return Expanded(flex: flex, child: w);
                  }).toList(),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
