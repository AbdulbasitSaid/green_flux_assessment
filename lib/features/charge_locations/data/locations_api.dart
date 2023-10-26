import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/charge_location.dart';
import 'package:http/http.dart' as http;

class LocationsApi {
  static const _baseLocationUrl =
      'app-flutter-locations-test.azurewebsites.net';
  final http.Client _httpClient;

  LocationsApi({required http.Client httpClient}) : _httpClient = httpClient;

  Future<List<Location>> searchChargeLocation(String query) async {
    final locationRequest =
        Uri.https(_baseLocationUrl, '/locations', {'q': query});

    final response = await _httpClient.get(locationRequest, headers: {
      HttpHeaders.authorizationHeader: dotenv.get("GREEN_FLUX_API_KEY"),
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<Location>((json) => Location.fromJson(json)).toList();
    } else if (response.statusCode == 400) {
      throw HttpBadRequest();
    } else if (response.statusCode == 401) {
      throw HttpUnauthorized();
    } else if (response.statusCode == 500) {
      throw HttpServerError();
    } 
    else {
      throw Exception();
    }
  }
}

class HttpBadRequest implements Exception {}

class HttpUnauthorized implements Exception {}

class HttpServerError implements Exception {}
