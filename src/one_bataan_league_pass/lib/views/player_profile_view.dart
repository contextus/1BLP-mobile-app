import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';

class PlayerProfileView extends ModelBoundWidget<PlayerProfileViewModel> {
  PlayerProfileView(PlayerProfileViewModel viewModel) : super(viewModel);

  @override
  _PlayerProfileViewState createState() => _PlayerProfileViewState();
}

class _PlayerProfileViewState extends ModelBoundState<PlayerProfileView, PlayerProfileViewModel> {
  ScrollController _controller;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      final shouldShowTitle = _controller.offset >= 200;
      if (shouldShowTitle != _showTitle)
        setState(() {
          _showTitle = shouldShowTitle;
        });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PlayerProfileViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<PlayerProfileViewModel>(
        builder: (context, child, viewModel) {
          return Hero(
            tag: viewModel.player.id,
            child: Scaffold(
              body: NestedScrollView(
                controller: _controller,
                headerSliverBuilder: (context, innerBoxScrolled) => _buildHeaderSliver(),
                body: SingleChildScrollView(
                  child: ExtendedColumn(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8.0,
                    children: <Widget>[
                      _buildPlayerInfo(),
                      _buildPlayerSeasonStatPicker(),
                      _buildPlayerStatTable(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildHeaderSliver() {
    return <Widget>[
      SliverAppBar(
        expandedHeight: 256.0,
        pinned: true,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1.0 : 0.0,
          child: ExtendedRow(
            spacing: 4.0,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(viewModel.player.imageUrl),
                backgroundColor: Colors.transparent,
              ),
              Text(
                '${viewModel.player.firstName} ${viewModel.player.lastName}',
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
          duration: Duration(milliseconds: 150),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.network(
              viewModel.player.playerTeam.team.logoUrl,
              width: 32,
            ),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).scaffoldBackgroundColor, Theme.of(context).canvasColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 80),
            child: Image.network(viewModel.player.imageUrl),
          ),
        ),
      ),
    ];
  }

  Widget _buildPlayerInfo() {
    return Column(
      children: viewModel.playerProfileDetails.map((p) {
        return Card(
          margin: const EdgeInsets.only(bottom: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            title: Text(p.fieldName, style: Theme.of(context).textTheme.caption),
            subtitle: Text(
              p.fieldValue,
              style: TextStyle(color: Theme.of(context).customTheme().primaryTextColor),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPlayerSeasonStatPicker() {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ExtendedColumn(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'STATS',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).customTheme().primaryTextColor),
            ),
            InputDecorator(
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<PlayerSeasonModel>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  isExpanded: true,
                  isDense: true,
                  value: viewModel.selectedPlayerSeason,
                  items: viewModel.playerSeasons.map(
                    (s) {
                      return DropdownMenuItem<PlayerSeasonModel>(
                        key: Key(s.seasonName),
                        child: Text(s.seasonName),
                        value: s,
                      );
                    },
                  ).toList(),
                  onChanged: viewModel.onSelectedSeasonChanged,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerStatTable() {
    return StatTable(
      columns: const [
        StatTableColumnData(title: 'BY YEAR', flex: 2),
        StatTableColumnData(title: 'GP', flex: 1),
        StatTableColumnData(title: 'MIN', flex: 1),
        StatTableColumnData(title: 'PTS', flex: 1),
        StatTableColumnData(title: 'FGM', flex: 1),
        StatTableColumnData(title: 'FG%', flex: 1),
      ],
      rows: [
        StatTableRowData([
          StatTableCellData(Text(
            '${viewModel.selectedPlayerSeason.stats.year}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).customTheme().primaryTextColor),
          )),
          StatTableCellData(Text(
            '${viewModel.selectedPlayerSeason.stats.gp}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).customTheme().primaryTextColor),
          )),
          StatTableCellData(Text(
            '${viewModel.selectedPlayerSeason.stats.min}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).customTheme().primaryTextColor),
          )),
          StatTableCellData(Text(
            '${viewModel.selectedPlayerSeason.stats.pts}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).customTheme().primaryTextColor),
          )),
          StatTableCellData(Text(
            '${viewModel.selectedPlayerSeason.stats.fgm}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).customTheme().primaryTextColor),
          )),
          StatTableCellData(Text(
            '${viewModel.selectedPlayerSeason.stats.fgPercentage}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).customTheme().primaryTextColor),
          )),
        ])
      ],
    );
  }
}
