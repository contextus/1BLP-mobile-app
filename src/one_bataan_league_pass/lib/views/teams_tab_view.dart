import 'dart:math';

import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class TeamsTabView extends TabView {
  TeamsTabView() : super(const TabData('Teams', Icons.group, ViewNames.teamsTabView));

  @override
  _TeamsTabViewState createState() => _TeamsTabViewState();
}

class _TeamsTabViewState extends TabViewStateBase<TeamsTabView, TeamsTabViewModel> {
  @override
  Widget buildView(BuildContext context) {
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
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
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

            return ErrorWidget('Unhandled $snapshot state');
          },
        )
      ],
    );
  }

  Widget _buildTeamsListView(List<TeamEntity> teams) {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refetchTeams(),
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
}
