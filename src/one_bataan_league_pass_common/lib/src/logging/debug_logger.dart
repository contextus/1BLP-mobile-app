import 'dart:convert';
import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:one_bataan_league_pass_common/src/json_serializable.dart';

final _jsonEncoder = JsonEncoder.withIndent(' ');
final _name = '1BATAAN-LEAGUE-PASS';

void debugInfo(String message) => log('(INFO) $message', name: _name, level: Level.INFO.value);

void debugError(String message, [Object error]) => log('(ERROR) $message',
    name: _name, level: Level.SEVERE.value, error: error is JsonSerializable ? _jsonEncoder.convert(error) : error);

void debugWarn(String message, [Object error]) => log('(WARN) $message',
    name: _name, level: Level.WARNING.value, error: error is JsonSerializable ? _jsonEncoder.convert(error) : error);

void debugWrite(String message, String category, [int level = 800]) =>
    log('(${category?.toUpperCase()}) $message', name: _name, level: level);
