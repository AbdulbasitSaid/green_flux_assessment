import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/data/locations_api.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/location.dart';
import 'package:green_flux_assessment/features/charge_locations/domain/locations_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationsApi extends Mock implements LocationsApi {}

class MockLocationsRepository extends Mock implements LocationsRepository {}

void main() {
  late LocationsRepository locationsRepository;
  late MockLocationsApi mockLocationsApi;
  late List<Location> mockLocations;
  const query = 'query';

  setUp(() {
    mockLocationsApi = MockLocationsApi();
    locationsRepository = LocationsRepository(locationsApi: mockLocationsApi);
    mockLocations = <Location>[];

    when(() => mockLocationsApi.searchChargeLocation(query))
        .thenAnswer((invocation) async => mockLocations);
  });

  test('getChargeLocations returns a list of locations', () async {
    final result = await locationsRepository.getChargeLocations(query: query);

    expect(result, equals(mockLocations));
    verify(() => mockLocationsApi.searchChargeLocation(query)).called(1);
  });
}
