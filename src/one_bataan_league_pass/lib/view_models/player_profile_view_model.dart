import 'package:intl/intl.dart';
import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class PlayerProfileViewModel extends ViewModelBase {
  PlayerEntity player;

  List<ProfileDetailListModel> playerProfileDetails = [];

  List<PlayerSeasonModel> playerSeasons = [];

  PlayerSeasonModel selectedPlayerSeason;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    assert(parameters.containsKey(NavigationParameterConstants.selectedPlayerProfileToView));
    assert(parameters[NavigationParameterConstants.selectedPlayerProfileToView] != null);

    player = parameters[NavigationParameterConstants.selectedPlayerProfileToView];
    playerProfileDetails
      ..add(ProfileDetailListModel('NAME', '${player.firstName} ${player.lastName}'))
      ..add(ProfileDetailListModel('BIRTHDATE', DateFormat('MMMM dd, y').format(player.birthdate)))
      ..add(ProfileDetailListModel('NATIONALITY', player.nationality))
      ..add(ProfileDetailListModel('PROVINCE', player.province))
      ..add(ProfileDetailListModel('CITY/MUNICIPALITY/TOWN', player.municipalityTown))
      ..add(ProfileDetailListModel('POSITION', player.playerTeam.formattedPositions))
      ..add(ProfileDetailListModel('NUMBER', player.playerTeam.playerNum));

    playerSeasons
      ..add(PlayerSeasonModel(
        'Season 1',
        PlayerSeasonStatsModel(
          year: 2020,
          gp: 5.0,
          min: 31.8,
          pts: 11.8,
          fgm: 5.6,
          fga: 8.4,
          fgPercentage: 59.1,
        ),
      ))
      ..add(PlayerSeasonModel(
        'Season 2',
        PlayerSeasonStatsModel(
          year: 2019,
          gp: 10.1,
          min: 26.4,
          pts: 8.5,
          fgm: 10.9,
          fga: 7.8,
          fgPercentage: 59.1,
        ),
      ))
      ..add(PlayerSeasonModel(
        'Season 3',
        PlayerSeasonStatsModel(
          year: 2018,
          gp: 3.0,
          min: 32.1,
          pts: 3.5,
          fgm: 9.6,
          fga: 7.5,
          fgPercentage: 43.3,
        ),
      ));

    onSelectedSeasonChanged(playerSeasons.first);
  }

  void onSelectedSeasonChanged(PlayerSeasonModel season) {
    selectedPlayerSeason = season;
    notifyListeners();
  }
}
