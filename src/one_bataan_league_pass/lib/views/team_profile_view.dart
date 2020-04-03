import 'package:arch/arch.dart';
import 'package:intl/intl.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';

class TeamProfileView extends StatefulWidget {
  @override
  _TeamProfileViewState createState() => _TeamProfileViewState();
}

class _TeamProfileViewState extends ViewStateBase<TeamProfileView, TeamProfileViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return Hero(
      tag: viewModel.team.id,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Team Profile'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: ExtendedColumn(
            spacing: 8,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ExtendedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: <Widget>[
                      Image.network(viewModel.team.logoUrl, width: 92),
                      Text(
                        viewModel.team.name,
                        style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(color: Theme.of(context).textTheme.caption.color),
                      ),
                      Text(
                        'Founding Date: ${DateFormat('MMMM dd, yyyy').format(viewModel.team.foundingDate)}',
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(color: Theme.of(context).textTheme.caption.color),
                      ),
                    ],
                  ),
                ),
              ),
              SingleDetailList(items: viewModel.teamProfileDetails),
              FutureBuilder<List<PlayerEntity>>(
                future: viewModel.getPlayers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingPlayerCard();
                  } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
                    return Expanded(child: Center(child: Text('Could not retrieve players')));
                  } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                    return _buildPlayersListView(snapshot.data);
                  }

                  return ErrorWidget('Unhandled $snapshot state');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayersListView(List<PlayerEntity> players) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: Theme.of(context).canvasColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text('TEAM ROSTER', style: Theme.of(context).textTheme.caption),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: players.length,
          itemBuilder: (context, index) => _buildPlayerCard(players[index]),
        ),
      ],
    );
  }

  Widget _buildPlayerCard(PlayerEntity player) {
    return Card(
      margin: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        title: Text('${player.firstName} ${player.lastName}'),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '#${player.playerTeam.playerNum}'),
              TextSpan(text: ' | '),
              TextSpan(text: player.playerTeam.positions.join(' ')),
            ],
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        leading: CircleAvatar(backgroundImage: NetworkImage(player.imageUrl), backgroundColor: Colors.transparent),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => viewModel.onViewPlayerProfile(player),
      ),
    );
  }

  Widget _buildLoadingPlayerCard() {
    return Card(
      child: const ListTile(
        title: LoadingContainer(height: 12),
        subtitle: LoadingContainer(height: 12),
        leading: LoadingContainer(child: CircleAvatar()),
      ),
    );
  }
}
