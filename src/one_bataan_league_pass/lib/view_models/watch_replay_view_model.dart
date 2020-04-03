import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class WatchReplayViewModel extends ViewModel {
  GameEntity game;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    assert(parameters[NavigationParameterConstants.selectedGameToWatchReplay] != null);

    game = parameters[NavigationParameterConstants.selectedGameToWatchReplay];
  }
}
