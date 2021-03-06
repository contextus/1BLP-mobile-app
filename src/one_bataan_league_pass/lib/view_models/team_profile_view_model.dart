import 'package:arch/arch.dart';
import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_business/managers.dart';
import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/logging.dart';

class TeamProfileViewModel extends ViewModel {
  TeamProfileViewModel(NavigationService navigationService, this._playerManager)
      : super(navigationService: navigationService);

  final PlayerManager _playerManager;

  Future<List<PlayerEntity>> getPlayers;

  TeamEntity team;

  List<SingleDetailListItemModel> teamProfileDetails = [];

  @override
  void init([Map<String, Object> parameters]) {
    assert(parameters.containsKey(NavigationParameterConstants.selectedTeamProfileToView));
    assert(parameters[NavigationParameterConstants.selectedTeamProfileToView] != null);

    team = parameters[NavigationParameterConstants.selectedTeamProfileToView];

    getPlayers = _onGetPlayers();

    teamProfileDetails
      ..add(SingleDetailListItemModel('COACH', team.coach))
      ..add(SingleDetailListItemModel('TEAM MANAGER', team.manager))
      ..add(SingleDetailListItemModel('OWNER', team.owner));
  }

  void onViewPlayerProfile(PlayerEntity player) {
    navigationService.push(ViewNames.playerProfileView, {
      NavigationParameterConstants.selectedPlayerProfileToView: player,
    });
  }

  Future<List<PlayerEntity>> _onGetPlayers() {
    debugInfo('Getting players for team ${team.name}');

    try {
      return _playerManager.getPlayers();
    } on Exception catch (e) {
      debugError('Failed to retrieve players', e);
      rethrow;
    }
  }
}
