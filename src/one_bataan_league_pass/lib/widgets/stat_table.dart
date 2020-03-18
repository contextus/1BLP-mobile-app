import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';

class StatTableColumnData {
  const StatTableColumnData({this.title, this.flex = 1});

  final String title;
  final int flex;
}

class StatTableRowData {
  StatTableRowData(this.cells);

  final List<StatTableCellData> cells;
}

class StatTableCellData {
  StatTableCellData(this.cell);

  final Widget cell;
}

class StatTable extends StatelessWidget {
  StatTable({Key key, @required this.columns, @required this.rows, this.groupHeaderBuilder})
      : assert(columns?.isNotEmpty == true),
        assert(rows?.isNotEmpty == true),
        assert(rows.every((r) => r.cells.length == columns.length)),
        super(key: key);

  final List<StatTableColumnData> columns;
  final List<StatTableRowData> rows;
  final Widget Function(BuildContext, int) groupHeaderBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: columns.map((h) {
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
        Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(children: _buildChildren(context)),
        ),
      ],
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final children = rows.map<Widget>((r) {
      return Container(
        color: Theme.of(context).canvasColor,
        child: Row(
          children: r.cells.map((c) {
            final flex = columns.elementAt(r.cells.indexOf(c)).flex;
            return Expanded(flex: flex, child: c.cell);
          }).toList(),
        ),
      );
    }).toList();

    if (groupHeaderBuilder != null) {
      int counter = 0;
      for (var i = 0; i < rows.length; i++) {
        final header = groupHeaderBuilder(context, i);
        if (header != null) {
          children.insert(i + counter, header);
          counter++;
        }
      }
    }

    return children;
  }
}
