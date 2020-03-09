import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';

class UserProfileView extends ModelBoundWidget<UserProfileViewModel> {
  UserProfileView(UserProfileViewModel viewModel) : super(viewModel);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends ModelBoundState<UserProfileView, UserProfileViewModel> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserProfileViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<UserProfileViewModel>(
        builder: (context, child, viewModel) {
          return Scaffold(
            appBar: AppBar(
              title: Text('User Profile'),
              actions: viewModel.userProfile != null
                  ? [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () =>
                            AppViewModel.instance.isDarkModeEnabled = !AppViewModel.instance.isDarkModeEnabled,
                      )
                    ]
                  : [],
            ),
            body: FutureBuilder(
              future: viewModel.getUserProfileTask,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return _buildUserProfileLoadingWidget();
                else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError)
                  return _buildUserProfileWidget();

                throw UnimplementedError('Snapshot condition not handled.');
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserProfileLoadingWidget() {
    return ExtendedColumn(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          color: Theme.of(context).canvasColor,
          child: Center(
            child: ExtendedColumn(
              spacing: 12.0,
              children: <Widget>[
                LoadingContainer(child: CircleAvatar(radius: 56)),
                LoadingContainer(width: 128, height: 16),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                title: LoadingContainer(height: 16),
                subtitle: LoadingContainer(height: 16),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                title: LoadingContainer(height: 16),
                subtitle: LoadingContainer(height: 16),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                title: LoadingContainer(height: 16),
                subtitle: LoadingContainer(height: 16),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                title: LoadingContainer(height: 16),
                subtitle: LoadingContainer(height: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserProfileWidget() {
    return RefreshIndicator(
      onRefresh: () async => viewModel.getUserProfile(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 2),
        physics: const AlwaysScrollableScrollPhysics(),
        child: ExtendedColumn(
          spacing: 8,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              color: Theme.of(context).canvasColor,
              child: Center(
                child: ExtendedColumn(
                  spacing: 12.0,
                  children: <Widget>[
                    CircleAvatar(radius: 56, backgroundImage: NetworkImage(viewModel.userProfile.imageUrl)),
                    Text(
                      viewModel.userProfile.name,
                      style: Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.only(bottom: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    title: Text('BIRTHDATE', style: Theme.of(context).textTheme.caption),
                    subtitle: Text(
                      DateFormat('MMMM dd, y').format(viewModel.userProfile.birthDate),
                      style: TextStyle(color: Theme.of(context).customTheme().primaryTextColor),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    title: Text('NATIONALITY', style: Theme.of(context).textTheme.caption),
                    subtitle: Text(
                      viewModel.userProfile.nationality,
                      style: TextStyle(color: Theme.of(context).customTheme().primaryTextColor),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    title: Text('PROVINCE', style: Theme.of(context).textTheme.caption),
                    subtitle: Text(
                      viewModel.userProfile.province,
                      style: TextStyle(color: Theme.of(context).customTheme().primaryTextColor),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    title: Text('NATIONALITY', style: Theme.of(context).textTheme.caption),
                    subtitle: Text(
                      viewModel.userProfile.cityOrMunicipality,
                      style: TextStyle(color: Theme.of(context).customTheme().primaryTextColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
