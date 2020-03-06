import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/services/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';

class HomeTabViewModel extends TabViewModelBase {
  HomeTabViewModel(
    NavigationService navigationService,
    DialogService dialogService,
    this._sharingService,
  ) : super(navigationService, dialogService);

  final SharingService _sharingService;

  final game = GameModel(
    gameSeries: 'Playoffs Quarter Finals',
    gameDate: DateTime.now(),
    gameLocation: 'Mariveles, Bataan',
    gameVideoUrl: 'https://sample.com',
    isLive: true,
    team1: TeamModel(
      teamName: '1Bataan Risers',
      teamImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7JLYnYGcJ_BrfyF4KE8jq84p8M_LEbqbnx4zE82gXpyPK_gBE',
    ),
    team1Score: 35,
    team2: TeamModel(
      teamName: 'A Team',
      teamImageUrl:
          'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/make-a-basketball-logo-v2/sports-logo-template-for-a-basketball-tournament-2703e-1024x1024.png',
    ),
    team2Score: 22,
  );

  Future<void> onShareLiveGame() => _sharingService.share('Watch this game ${game.gameVideoUrl}');
}
