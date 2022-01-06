class GameTournament {
  int code;
  Data data;
  bool success;

  GameTournament({this.code, this.data, this.success});

  GameTournament.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String cursor;
  List<Tournaments> tournaments;
  bool isLastBatch;

  Data({this.cursor, this.tournaments, this.isLastBatch});

  Data.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    if (json['tournaments'] != null) {
      tournaments = <Tournaments>[];
      json['tournaments'].forEach((v) {
        tournaments.add(new Tournaments.fromJson(v));
      });
    }
    isLastBatch = json['is_last_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cursor'] = this.cursor;
    if (this.tournaments != null) {
      data['tournaments'] = this.tournaments.map((v) => v.toJson()).toList();
    }
    data['is_last_batch'] = this.isLastBatch;
    return data;
  }
}

class Tournaments {
  int teamSize;
  String status;
  bool isLevelsEnabled;
  bool indexPage;
  String dynamicAppUrl;
  String minLevelId;
  String gameFormat;
  String details;
  String gameIconUrl;
  String regStartDate;
  String coverUrl;
  Null bracketsUrl;
  String tournamentSlug;
  String discordUrl;
  String gameId;
  bool resultSubmissionByAdmin;
  String country;
  String adminUsername;
  String gameName;
  String streamUrl;

  Tournaments(
      {this.teamSize,
        this.status,
        this.isLevelsEnabled,
        this.indexPage,
        this.dynamicAppUrl,
        this.minLevelId,
        this.gameFormat,
        this.details,
        this.gameIconUrl,
        this.regStartDate,
        this.coverUrl,
        this.bracketsUrl,
        this.tournamentSlug,
        this.discordUrl,
        this.gameId,
        this.resultSubmissionByAdmin,
        this.country,
        this.adminUsername,
        this.gameName,
        this.streamUrl});

  Tournaments.fromJson(Map<String, dynamic> json) {
    teamSize = json['team_size'];
    status = json['status'];
    isLevelsEnabled = json['is_levels_enabled'];
    indexPage = json['index_page'];
    dynamicAppUrl = json['dynamic_app_url'];
    minLevelId = json['min_level_id'];
    gameFormat = json['game_format'];
    details = json['details'];
    gameIconUrl = json['game_icon_url'];
    regStartDate = json['reg_start_date'];
    coverUrl = json['cover_url'];
    bracketsUrl = json['brackets_url'];
    tournamentSlug = json['tournament_slug'];
    discordUrl = json['discord_url'];
    gameId = json['game_id'];
    resultSubmissionByAdmin = json['result_submission_by_admin'];
    country = json['country'];
    adminUsername = json['admin_username'];
    gameName = json['game_name'];
    streamUrl = json['stream_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_size'] = this.teamSize;
    data['status'] = this.status;
    data['is_levels_enabled'] = this.isLevelsEnabled;
    data['index_page'] = this.indexPage;
    data['dynamic_app_url'] = this.dynamicAppUrl;
    data['min_level_id'] = this.minLevelId;
    data['game_format'] = this.gameFormat;
    data['details'] = this.details;
    data['game_icon_url'] = this.gameIconUrl;
    data['reg_start_date'] = this.regStartDate;
    data['cover_url'] = this.coverUrl;
    data['brackets_url'] = this.bracketsUrl;
    data['tournament_slug'] = this.tournamentSlug;
    data['discord_url'] = this.discordUrl;
    data['game_id'] = this.gameId;
    data['result_submission_by_admin'] = this.resultSubmissionByAdmin;
    data['country'] = this.country;
    data['admin_username'] = this.adminUsername;
    data['game_name'] = this.gameName;
    data['stream_url'] = this.streamUrl;
    return data;
  }
}
