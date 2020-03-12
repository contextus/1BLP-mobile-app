import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';

class PlayerProfileView extends ModelBoundWidget<PlayerProfileViewModel> {
  PlayerProfileView(PlayerProfileViewModel viewModel) : super(viewModel);

  @override
  _PlayerProfileViewState createState() => _PlayerProfileViewState();
}

class _PlayerProfileViewState extends ModelBoundState<PlayerProfileView, PlayerProfileViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<PlayerProfileViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<PlayerProfileViewModel>(
        builder: (context, child, viewModel) {
          return Hero(
            tag: viewModel.player.id,
            child: Scaffold(
              backgroundColor: Theme.of(context).canvasColor,
              appBar: AppBar(
                elevation: 0,
                leading: BackButton(),
              ),
              body: SizedBox.expand(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ExtendedColumn(
                      spacing: 32,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildPlayerInfo(),
                        Center(child: Image.network(viewModel.player.playerImageUrl, width: 224)),
                        _buildPlayerStats()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlayerInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ExtendedRow(
        spacing: 8,
        children: <Widget>[
          Text(
            viewModel.player.playerNumber,
            style: Theme.of(context).textTheme.display1.copyWith(
                  color: Theme.of(context).customTheme().primaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(viewModel.player.playerName,
                        style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold)),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: viewModel.player.playerTeam.teamNameAcronym),
                          TextSpan(text: '    |    '),
                          TextSpan(text: viewModel.player.formattedPositions),
                        ],
                        style: Theme.of(context).textTheme.body2,
                      ),
                    )
                  ],
                ),
                Image.network(viewModel.player.playerTeam.teamImageUrl, width: 56),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerStats() {
    return ExtendedRow(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ExtendedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: <Widget>[
                  Text(
                    'PPG',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).customTheme().secondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    viewModel.player.ppg.toString(),
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ExtendedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: <Widget>[
                  Text(
                    'RPG',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).customTheme().secondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    viewModel.player.rpg.toString(),
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ExtendedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: <Widget>[
                  Text(
                    'APG',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).customTheme().secondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    viewModel.player.apg.toString(),
                    style: Theme.of(context).textTheme.headline.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
