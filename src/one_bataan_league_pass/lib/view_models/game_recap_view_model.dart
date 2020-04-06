import 'package:one_bataan_league_pass/models/models.dart';
import 'package:one_bataan_league_pass/view_models/view_model_base.dart';
import 'package:one_bataan_league_pass_business/entities.dart';
import 'package:one_bataan_league_pass_common/constants.dart';

class GameRecapViewModel extends ViewModel {
  GameEntity game;

  List<SingleDetailListItemModel> gameDetails = [];

  List<GameResultModel> gameResults = [];

  GameResultModel team1GameResult;

  GameResultModel team2GameResult;

  List<PlayerGameStatsModel> team1GameLeaders = [];

  List<PlayerGameStatsModel> team2GameLeaders = [];

  @override
  Future<void> init([Map<String, Object> parameters]) async {
    assert(parameters[NavigationParameterConstants.selectedGameToViewRecap] != null);

    game = parameters[NavigationParameterConstants.selectedGameToViewRecap];

    gameDetails
      ..add(SingleDetailListItemModel('LOCATION', game.gameLocation))
      ..add(SingleDetailListItemModel('ATTENDANCE', '5,235'))
      ..add(SingleDetailListItemModel('OFFICIALS', 'John Doe, Tony Brown, Nate Green'));

    gameResults
      ..add(team1GameResult = GameResultModel(
        team: game.team1,
        q1: 21,
        q2: 25,
        q3: 33,
        q4: 27,
        fieldGoals: 41,
        threePointers: 12,
        freeThrows: 14,
        totalFieldGoals: 91,
        totalThreePointers: 35,
        totalFreeThrows: 14,
      ))
      ..add(team2GameResult = GameResultModel(
        team: game.team2,
        q1: 22,
        q2: 35,
        q3: 26,
        q4: 28,
        fieldGoals: 41,
        threePointers: 9,
        freeThrows: 21,
        totalFieldGoals: 84,
        totalThreePointers: 26,
        totalFreeThrows: 29,
      ));

    team1GameLeaders
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.points,
        score: 30,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '01',
            team: game.team1,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.rebounds,
        score: 10,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '02',
            team: game.team1,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.assists,
        score: 12,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '03',
            team: game.team1,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.steals,
        score: 1,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '04',
            team: game.team1,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.blocks,
        score: 3,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '05',
            team: game.team1,
          ),
        ),
      ));

    team2GameLeaders
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.points,
        score: 34,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '01',
            team: game.team2,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.rebounds,
        score: 7,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '02',
            team: game.team2,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.assists,
        score: 9,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '03',
            team: game.team2,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.steals,
        score: 1,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '04',
            team: game.team2,
          ),
        ),
      ))
      ..add(PlayerGameStatsModel(
        category: GameLeaderCategory.blocks,
        score: 2,
        player: PlayerEntity(
          firstName: 'Player',
          lastName: 'Name',
          imageUrl:
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          playerTeam: PlayerTeamEntity(
            positions: ['PG', 'G', 'C'],
            playerNum: '05',
            team: game.team2,
          ),
        ),
      ));
  }
}
