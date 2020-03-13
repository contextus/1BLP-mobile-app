import 'dart:math';

import 'package:one_bataan_league_pass_web_service/src/data_contracts/player_data_contract.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/http_handler.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/web_service_base.dart';

abstract class PlayerWebService {
  Future<List<PlayerDataContract>> getPlayers();
}

class PlayerWebServiceImpl extends WebServiceBase implements PlayerWebService {
  PlayerWebServiceImpl(HttpHandler httpHandler) : super(httpHandler);

  Future<List<PlayerDataContract>> getPlayers() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      PlayerDataContract.fromJson(
        {
          'id': Random().nextInt(1000).hashCode.toString(),
          'first_name': 'Jose',
          'last_name': 'Makabayan',
          'birthdate': DateTime.now(),
          'nationality': 'Filipino',
          'province': 'Bataan',
          'municipality_town': 'Mariveles',
          'image_url':
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          'profile': <String, Object>{},
          'team': {
            'team': {
              'id': Random().nextInt(1000).hashCode.toString(),
              'name': '1Bataan Risers',
              'owner': 'Camaya Coast',
              'manager': 'Camaya Coast',
              'coach': 'Jonas Villanueva',
              'logo_url':
                  'https://d1k5w7mbrh6vq5.cloudfront.net/images/cache/d6/29/6d/d6296dc34ee7874a4b4eaf741442cb76.png',
            },
            'player_num': '01',
            'positions': ['C', 'F', 'G'],
          },
        },
      ),
      PlayerDataContract.fromJson(
        {
          'id': Random().nextInt(1000).hashCode.toString(),
          'first_name': 'Juan',
          'last_name': 'Dela Cruz',
          'birthdate': DateTime.now(),
          'nationality': 'Filipino',
          'province': 'Metro Manila',
          'municipality_town': 'Quezon City',
          'image_url':
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          'profile': <String, Object>{},
          'team': {
            'team': {
              'id': Random().nextInt(1000).hashCode.toString(),
              'name': 'Quezon City Capitals',
              'owner': 'WEMSAP',
              'manager': 'WEMSAP',
              'coach': 'Vis Valencia',
              'logo_url': 'https://i.redd.it/atvnpigchb811.jpg',
            },
            'player_num': '12',
            'positions': ['C'],
          },
        },
      ),
      PlayerDataContract.fromJson(
        {
          'id': Random().nextInt(1000).hashCode.toString(),
          'first_name': 'Pedro',
          'last_name': 'Penduko',
          'birthdate': DateTime.now(),
          'nationality': 'Filipino',
          'province': 'Metro Manila',
          'municipality_town': 'Caloocan City',
          'image_url':
              'https://www.interperformances.com/timthumb/timthumb.php?src=files/players/1557310079_adam_presutti.png&h=400&w=370&q=100&a=t&zc=1',
          'profile': <String, Object>{},
          'team': {
            'team': {
              'id': Random().nextInt(1000).hashCode.toString(),
              'name': 'Caloocan Supremos',
              'owner': 'Victory Liner, Inc.',
              'manager': 'Victory Liner, Inc.',
              'coach': 'John Kallos',
              'logo_url':
                  'https://scontent.fmnl15-1.fna.fbcdn.net/v/t1.0-9/29572450_155909611772140_4374353873624635998_n.jpg?_nc_cat=103&_nc_sid=7aed08&_nc_ohc=4Zm3_u4Wjz0AX-ezd6I&_nc_ht=scontent.fmnl15-1.fna&oh=fe75c463b645eb128018bd40385bf76e&oe=5E9045FC',
            },
            'player_num': '24',
            'positions': ['G', 'F'],
          },
        },
      ),
    ];
  }
}
