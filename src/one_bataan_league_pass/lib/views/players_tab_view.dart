import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class PlayersTabView extends ModelBoundTabWidget<PlayersTabViewModel> {
  PlayersTabView(PlayersTabViewModel viewModel) : super(viewModel, 'Players', Icons.person);

  @override
  _PlayersTabViewState createState() => _PlayersTabViewState();
}

class _PlayersTabViewState extends ModelBoundState<PlayersTabView, PlayersTabViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<PlayersTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<PlayersTabViewModel>(
        builder: (context, child, viewModel) {
          return ExtendedColumn(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search player',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                  ),
                ),
              ),
              CupertinoSegmentedControl(
                children: Map.fromIterable(
                  viewModel.choices,
                  key: (c) => viewModel.choices.indexOf(c),
                  value: (c) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(c, style: TextStyle(fontSize: 14.0)),
                  ),
                ),
                onValueChanged: viewModel.onSelectedChoiceIndexChanged,
                groupValue: viewModel.selectedChoiceIndex,
                borderColor: Colors.green,
                selectedColor: Colors.green,
              ),
              Expanded(child: PlayersListView(players: viewModel.players))
            ],
          );
        },
      ),
    );
  }
}

class PlayersListView extends StatelessWidget {
  const PlayersListView({
    Key key,
    @required this.players,
  }) : super(key: key);

  final List<PlayerModel> players;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final player = players[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            title: Text(player.playerName, style: TextStyle(fontSize: 14.0)),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: player.playerTeam.teamName),
                  TextSpan(text: '    |    '),
                  TextSpan(text: '#${player.playerNumber}'),
                  TextSpan(text: '    |    '),
                  TextSpan(text: player.formattedPositions),
                ],
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            leading: CircleAvatar(backgroundImage: NetworkImage(player.playerImageUrl)),
            trailing: Image.network(
              player.playerTeam.teamImageUrl,
              width: 40,
            ),
          ),
        );
      },
      itemCount: players.length,
    );
  }
}
