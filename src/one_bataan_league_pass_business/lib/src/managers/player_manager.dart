import 'package:one_bataan_league_pass_business/src/entities/player_entity.dart';
import 'package:one_bataan_league_pass_business/src/mappers/player_mapper.dart';
import 'package:one_bataan_league_pass_web_service/web_services.dart';

class PlayerManager {
  PlayerManager(this._playerWebService, this._playerMapper);

  final PlayerWebService _playerWebService;
  final PlayerMapper _playerMapper;

  Future<List<PlayerEntity>> getPlayers() async {
    final playerContracts = await _playerWebService.getPlayers();

    return playerContracts.map(_playerMapper.toEntity).toList();
  }
}
