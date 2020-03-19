import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/models/singe_detail_list_item_model.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';
import 'package:one_bataan_league_pass/widgets/extended_column.dart';

class SingleDetailList extends StatelessWidget {
  SingleDetailList({Key key, @required this.items})
      : assert(items != null),
        super(key: key);

  final List<SingleDetailListItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ExtendedColumn(
      spacing: 1,
      children: items.map((i) {
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            title: Text(i.fieldName, style: Theme.of(context).textTheme.caption),
            subtitle: Text(
              i.fieldValue ?? '-',
              style: TextStyle(color: Theme.of(context).customTheme().primaryTextColor),
            ),
          ),
        );
      }).toList(),
    );
  }
}
