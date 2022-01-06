
import 'package:flutter/foundation.dart';
import 'package:game_tv/utils/common.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'custom_exception.dart';

class ApiProvider {
  final String baseUrl = "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2";


  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      print("REQUEST ==> ${url} \n");
      final response = await http.get(url);
      responseJson = my_response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic data) async {
    print("REQUEST ==> ${url} \n" + data.toString());
    var responseJson;
    try {
      final response =
          await http.post(url, body: data, headers: {"Content-Type": "application/x-www-form-urlencoded"});
      debugPrint("RESPONSE <== ${url} \n" + response.toString());

      responseJson = my_response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postJson(String url, dynamic data) async {
    print("REQUEST ==> ${url} \n" + data.toString());
    var responseJson;
    try {
      final response =
      await http.post(url, body: data, headers: {"Content-Type": "application/json"},);
      print("RESPONSE <== ${url} \n" + response.toString());

      responseJson = my_response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  static dynamic my_response(http.Response response) {
    print(response);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // CommonUtils.printWrapped(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }



}
