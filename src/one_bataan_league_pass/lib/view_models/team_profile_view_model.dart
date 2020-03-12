import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class TeamProfileViewModel extends ViewModelBase {
  TeamEntity team;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    assert(parameters.containsKey(NavigationParameterConstants.selectedTeamProfileToView));
    assert(parameters[NavigationParameterConstants.selectedTeamProfileToView] != null);

    team = parameters[NavigationParameterConstants.selectedTeamProfileToView];
  }
}
