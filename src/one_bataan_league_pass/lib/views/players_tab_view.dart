import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class PlayersTabView extends ModelBoundTabWidget<PlayersTabViewModel> {
  PlayersTabView(PlayersTabViewModel viewModel, String tabViewName)
      : super(viewModel, tabButtonText: 'Players', tabButtonIcon: Icons.person, tabViewName: tabViewName);

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
                    fillColor: Theme.of(context).canvasColor,
                    hintText: 'Search player',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: ToggleButtons(
                    children: viewModel.choices.map((c) {
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width - 36) / 3, // Hack to fill width
                        child: Text(c, textAlign: TextAlign.center),
                      );
                    }).toList(),
                    isSelected: viewModel.choices
                        .map((c) => viewModel.selectedChoiceIndex == viewModel.choices.indexOf(c))
                        .toList(),
                    onPressed: viewModel.onSelectedChoiceIndexChanged,
                  ),
                ),
              ),
              Expanded(child: _buildPlayersListView()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayersListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final player = viewModel.players[index];

        return AnimationConfiguration.staggeredList(
          position: index,
          child: SlideAnimation(
            child: Card(
              margin: const EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                title: Text(player.playerName, style: TextStyle(fontSize: 14.0)),
                subtitle: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: player.playerTeam.teamNameAcronym),
                      TextSpan(text: '    |    '),
                      TextSpan(text: '#${player.playerNumber}'),
                      TextSpan(text: '    |    '),
                      TextSpan(text: player.formattedPositions),
                    ],
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                leading: CircleAvatar(backgroundImage: NetworkImage(player.playerImageUrl)),
                trailing: Image.network(player.playerTeam.teamImageUrl, width: 40),
              ),
            ),
          ),
        );
      },
      itemCount: viewModel.players.length,
    );
  }
}
