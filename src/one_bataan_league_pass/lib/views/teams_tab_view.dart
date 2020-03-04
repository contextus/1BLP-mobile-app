import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';

class TeamsTabView extends ModelBoundTabWidget<TeamsTabViewModel> {
  TeamsTabView(TeamsTabViewModel viewModel) : super(viewModel, 'Teams', Icons.group);

  @override
  _TeamsTabViewState createState() => _TeamsTabViewState();
}

class _TeamsTabViewState extends ModelBoundState<TeamsTabView, TeamsTabViewModel> {
  @override
  Widget build(BuildContext context) {
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
                    fillColor: Colors.white,
                    hintText: 'Search teams',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final team = viewModel.teams[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        title: Text(team.teamName, style: TextStyle(fontSize: 14.0)),
                        leading: Image.network(team.teamImageUrl, width: 32),
                        trailing: IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                  itemCount: viewModel.teams.length,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
