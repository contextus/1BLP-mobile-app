import 'dart:math';

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
              _buildFutureBuilder(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFutureBuilder() {
    switch (viewModel.selectedCriteriaIndex) {
      case 0:
        return FutureBuilder<List<PlayerEntity>>(
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

            return ErrorWidget('Unhandled $snapshot state');
          },
        );

      case 1:
        return FutureBuilder<List<TeamEntity>>(
          future: viewModel.getTeams,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildTeamLoadingCard();
            } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
              return Expanded(
                child: Center(
                  child: Text('Could not retrieve teams'),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
              return Expanded(
                child: _buildTeamsListView(snapshot.data),
              );
            }

            return ErrorWidget('Unhandled $snapshot state');
          },
        );

      case 2:
        return ExtendedColumn(
          spacing: 1,
          children: ['Guard', 'Forward', 'Center'].map((p) {
            return Card(
              child: ListTile(
                title: Text(p),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            );
          }).toList(),
        );
    }
  }

  Widget _buildTeamsListView(List<TeamEntity> teams) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refetchPlayers(),
      child: ListView.separated(
        itemCount: teams.length,
        itemBuilder: (context, index) => _buildTeamCard(teams[index]),
        separatorBuilder: (context, _snapshot) => SizedBox(height: 1),
      ),
    );
  }

  Widget _buildTeamCard(TeamEntity team) {
    final random = Random();
    final wins = random.nextInt(23);
    final loses = random.nextInt(23);

    return Hero(
      tag: team.id,
      child: Card(
        child: ListTile(
          title: Text(team.name),
          subtitle: Text('$wins-$loses', style: Theme.of(context).textTheme.caption),
          leading: Image.network(team.logoUrl, width: 40),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => viewModel.onViewTeamProfile(team),
        ),
      ),
    );
  }

  Widget _buildTeamLoadingCard() {
    return Card(
      child: const ListTile(
        title: LoadingContainer(height: 12),
        subtitle: LoadingContainer(height: 12),
        leading: LoadingContainer(child: CircleAvatar()),
      ),
    );
  }

  Widget _buildPlayersListView(List<PlayerEntity> players) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refetchPlayers(),
      child: ListView.separated(
        itemCount: players.length,
        itemBuilder: (context, index) => _buildPlayerCard(players[index]),
        separatorBuilder: (context, snapshot) => SizedBox(height: 1),
      ),
    );
  }

  Widget _buildPlayerCard(PlayerEntity player) {
    final teamNameAcronym = player.playerTeam.team.name.split(' ').map((n) => n[0]).join().toUpperCase();

    return Hero(
      tag: player.id,
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: ListTile(
          title: Text('${player.firstName} ${player.lastName}'),
          subtitle: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: teamNameAcronym),
                TextSpan(text: '    |    '),
                TextSpan(text: '#${player.playerTeam.playerNum}'),
                TextSpan(text: '    |    '),
                TextSpan(text: player.playerTeam.formattedPositions),
              ],
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          leading: CircleAvatar(backgroundImage: NetworkImage(player.imageUrl), backgroundColor: Colors.transparent),
          trailing: Image.network(player.playerTeam.team.logoUrl, width: 40),
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
