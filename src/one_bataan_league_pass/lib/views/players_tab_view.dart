import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class PlayersTabView extends ModelBoundTabWidget<PlayersTabViewModel> {
  PlayersTabView(PlayersTabViewModel viewModel)
      : super(viewModel, const TabData('Players', Icons.person, ViewNames.playersTabView));

  @override
  _PlayersTabViewState createState() => _PlayersTabViewState();
}

class _PlayersTabViewState extends ModelBoundTabState<PlayersTabView, PlayersTabViewModel> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                  onChanged: viewModel.onSearchKeywordChanged,
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
                    children: viewModel.searchCriterias.map((c) {
                      return SizedBox(
                        width: (MediaQuery.of(context).size.width - 36) / 3, // Hack to fill width
                        child: Text(c, textAlign: TextAlign.center),
                      );
                    }).toList(),
                    isSelected: viewModel.searchCriterias
                        .map((c) => viewModel.selectedCriteriaIndex == viewModel.searchCriterias.indexOf(c))
                        .toList(),
                    onPressed: viewModel.onSelectedSearchCriteriaChanged,
                  ),
                ),
              ),
              FutureBuilder<List<PlayerEntity>>(
                future: viewModel.getPlayers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingPlayerCard();
                  } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text('Could not retrieve players'),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                    return Expanded(
                      child: snapshot.data.isNotEmpty
                          ? _buildPlayersListView(snapshot.data)
                          : Center(child: Text('No players found')),
                    );
                  }

                  throw UnimplementedError('Unhandled $snapshot state');
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayersListView(List<PlayerEntity> players) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refetchPlayers(),
      child: ListView.separated(
        itemCount: players.length,
        itemBuilder: (context, index) => _buildPlayerCard(players[index]),
        separatorBuilder: (context, _snapshot) => SizedBox(height: 1),
      ),
    );
  }

  Widget _buildPlayerCard(PlayerEntity player) {
    return Hero(
      tag: player.id,
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: ListTile(
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
          leading: CircleAvatar(
              backgroundImage: NetworkImage(player.playerAvatarImageUrl), backgroundColor: Colors.transparent),
          trailing: Image.network(player.playerTeam.teamImageUrl, width: 40),
          onTap: () => viewModel.onViewPlayerProfile(player),
        ),
      ),
    );
  }

  Widget _buildLoadingPlayerCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: const ListTile(
        title: LoadingContainer(height: 12),
        subtitle: LoadingContainer(height: 12),
        leading: LoadingContainer(child: CircleAvatar()),
        trailing: LoadingContainer(child: CircleAvatar()),
      ),
    );
  }
}
