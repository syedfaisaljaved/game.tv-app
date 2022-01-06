import 'dart:convert';

import 'package:game_tv/model/game_tournament.dart';
import 'package:game_tv/network/api_provider.dart';

class TournamentRepo {
  static final TournamentRepo _authRepo = TournamentRepo._();

  TournamentRepo._();

  factory TournamentRepo() {
    return _authRepo;
  }

  static final apiProvider = ApiProvider();

  
  Future<GameTournament> getTournaments(int limit, String cursor) async {

    Uri uri = Uri(queryParameters: {
      "limit": limit.toString(),
      "status": "all",
      if(cursor != null) "cursor": cursor,
    });

    return GameTournament.fromJson(await apiProvider
        .get("${apiProvider.baseUrl}?${uri.query}"));
  }
}
