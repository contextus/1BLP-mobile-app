import 'package:arch/arch.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:one_bataan_league_pass_business/entities.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends ViewStateBase<UserProfileView, UserProfileViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: viewModel.userProfile != null ? [IconButton(icon: Icon(Icons.edit), onPressed: () {})] : [],
      ),
      body: FutureBuilder<UserProfileEntity>(
        future: viewModel.getUserProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildUserProfileLoadingWidget();
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
            return Expanded(
              child: Center(
                child: Text('Could not retrieve use profile'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
            return _buildUserProfileWidget();
          }

          return ErrorWidget('Unhandled $snapshot state');
        },
      ),
    );
  }

  Widget _buildUserProfileLoadingWidget() {
    return SingleChildScrollView(
      child: ExtendedColumn(
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
          ExtendedColumn(
            spacing: 1,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(7, (_) {
              return Card(
                child: const ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  title: LoadingContainer(height: 16),
                  subtitle: LoadingContainer(height: 16),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileWidget() {
    return RefreshIndicator(
      onRefresh: () async => viewModel.refetchUserProfile(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 2),
        physics: const AlwaysScrollableScrollPhysics(),
        child: ExtendedColumn(
          spacing: 8,
          children: <Widget>[
            Card(
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
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
            ),
            SingleDetailList(items: viewModel.userProfileDetails)
          ],
        ),
      ),
    );
  }
}
