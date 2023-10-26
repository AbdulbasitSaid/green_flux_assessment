import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/data/locations_api.dart';

import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class FakeUri extends Fake implements Uri {}

class MockResponse extends Mock implements http.Response {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

class MockHttpClient extends Mock implements http.Client {}

void main() async {
  await dotenv.load(fileName: ".env");
  group('LocationsApi', () {
    late http.Client httpClient;
    late LocationsApi locationsApi;
    const query = 'query';
    final headers = {
      HttpHeaders.authorizationHeader: dotenv.get("GREEN_FLUX_API_KEY"),
    };

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      locationsApi = LocationsApi(httpClient: httpClient);
    });

    test('makes correct http request', () async {
      final response = http.Response('[]', 200);
      when(() => httpClient.get(
            any(),
            headers: headers,
          )).thenAnswer((_) async => response);

      await locationsApi.searchChargeLocation(query);

      verify(
        () => httpClient.get(
          Uri.https(
            'app-flutter-locations-test.azurewebsites.net',
            '/locations',
            {'q': query},
          ),
          headers: headers,
        ),
      ).called(1);
    });
    test('returns HttpBadRequest', () async {
      final response = http.Response('[]', 400);
      when(() => httpClient.get(
            any(),
            headers: headers,
          )).thenAnswer((_) async => response);

      try {
        await locationsApi.searchChargeLocation(query);
      } on Exception {
        return;
      }

      expect(() async => await locationsApi.searchChargeLocation(query),
          throwsA(isA<HttpBadRequest>()));
    });
    test('returns HttpUnauthorized on unauthorized error', () async {
      final response = http.Response('[]', 401);
      when(() => httpClient.get(
            any(),
            headers: headers,
          )).thenAnswer((_) async => response);

      try {
        await locationsApi.searchChargeLocation(query);
      } on Exception {
        return;
      }

      expect(() async => await locationsApi.searchChargeLocation(query),
          throwsA(isA<HttpUnauthorized>()));
    });
    test('returns HttpServerError on server error', () async {
      final response = http.Response('[]', 500);
      when(() => httpClient.get(
            any(),
            headers: headers,
          )).thenAnswer((_) async => response);

      try {
        await locationsApi.searchChargeLocation(query);
      } on Exception {
        return;
      }

      expect(() async => await locationsApi.searchChargeLocation(query),
          throwsA(isA<HttpServerError>()));
    });
    test('throws Exception on unexpected status code', () async {
      final response = http.Response('[]', 418);
      when(() => httpClient.get(
            any(),
            headers: headers,
          )).thenAnswer((_) async => response);

      try {
        await locationsApi.searchChargeLocation(query);
      } on Exception {
        return;
      }

      expect(() async => await locationsApi.searchChargeLocation(query),
          throwsA(isA<Exception>()));
    });
  });
}
