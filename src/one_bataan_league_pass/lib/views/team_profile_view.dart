import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class TeamProfileView extends ModelBoundWidget<TeamProfileViewModel> {
  TeamProfileView(TeamProfileViewModel viewModel) : super(viewModel);

  @override
  _TeamProfileViewState createState() => _TeamProfileViewState();
}

class _TeamProfileViewState extends ModelBoundState<TeamProfileView, TeamProfileViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TeamProfileViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<TeamProfileViewModel>(
        builder: (context, child, viewModel) {
          return Hero(
            tag: viewModel.team.id,
            child: Scaffold(
              backgroundColor: Theme.of(context).canvasColor,
              appBar: AppBar(
                elevation: 0,
                leading: BackButton(),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Center(child: Image.network(viewModel.team.teamImageUrl, width: 92))),
                      Expanded(child: _buildTeamInfo()),
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

  Widget _buildTeamInfo() {
    return ExtendedRow(
      spacing: 8,
      children: <Widget>[
        Expanded(
          child: ExtendedRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ExtendedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: <Widget>[
                  Text(viewModel.team.teamName,
                      style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    '${viewModel.team.totalWins}-${viewModel.team.totalLose} | ${viewModel.team.place} in current series',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
