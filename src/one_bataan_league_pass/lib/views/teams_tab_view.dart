import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class TeamsTabView extends ModelBoundTabWidget<TeamsTabViewModel> {
  TeamsTabView(TeamsTabViewModel viewModel) : super(viewModel, TabData('Teams', Icons.group, ViewNames.teamsTabView));

  @override
  _TeamsTabViewState createState() => _TeamsTabViewState();
}

class _TeamsTabViewState extends ModelBoundTabState<TeamsTabView, TeamsTabViewModel> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScopedModel<TeamsTabViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<TeamsTabViewModel>(
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
                    hintText: 'Search teams',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                  ),
                ),
              ),
              FutureBuilder<List<TeamEntity>>(
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

                  throw UnimplementedError('Unhandled $snapshot state');
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildTeamsListView(List<TeamEntity> teams) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refetchTeams(),
      child: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) => _buildTeamCard(teams[index]),
      ),
    );
  }

  Widget _buildTeamCard(TeamEntity team) {
    return Card(
      margin: const EdgeInsets.only(bottom: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        title: Text(team.teamName),
        leading: Image.network(team.teamImageUrl, width: 32),
        trailing: IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildTeamLoadingCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: const ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        title: LoadingContainer(),
        leading: LoadingContainer(child: CircleAvatar()),
      ),
    );
  }
}
