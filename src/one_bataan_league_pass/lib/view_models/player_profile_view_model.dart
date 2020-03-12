import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class PlayerProfileViewModel extends ViewModelBase {
  PlayerEntity player;

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    assert(parameters.containsKey(NavigationParameterConstants.selectedPlayerProfileToView));
    assert(parameters[NavigationParameterConstants.selectedPlayerProfileToView] != null);

    player = parameters[NavigationParameterConstants.selectedPlayerProfileToView];
  }
}
