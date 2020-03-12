import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class WatchReplayViewModel extends ViewModelBase {
  GameEntity gameToWatch;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    assert(parameters[NavigationParameterConstants.selectedGameToWatch] != null);

    gameToWatch = parameters[NavigationParameterConstants.selectedGameToWatch];
  }
}
