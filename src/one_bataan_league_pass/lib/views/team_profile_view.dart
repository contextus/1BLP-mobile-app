import 'dart:math';

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
                      Expanded(child: Center(child: Image.network(viewModel.team.logoUrl, width: 92))),
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
    final random = Random();
    final wins = random.nextInt(23);
    final loses = random.nextInt(23);

    return ExtendedRow(
      spacing: 8,
      children: <Widget>[
        Expanded(
          child: ExtendedRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    viewModel.team.name,
                    style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$wins-$loses | 1st in current series',
                    style: Theme.of(context).textTheme.body2,
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
