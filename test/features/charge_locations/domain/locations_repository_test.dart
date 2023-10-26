import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/data/locations_api.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/location.dart';
import 'package:green_flux_assessment/features/charge_locations/domain/locations_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationsApi extends Mock implements LocationsApi {}

class MockLocationsRepository extends Mock implements LocationsRepository {}

void main() {
  late LocationsRepository
      locationsRepository; // Changed to LocationsRepository from MockLocationsRepository
  late MockLocationsApi mockLocationsApi;
  late List<Location> mockLocations;
  const query = 'query';

  setUp(() {
    mockLocationsApi = MockLocationsApi();
    locationsRepository = LocationsRepository(
        locationsApi: mockLocationsApi); // Pass the mockLocationsApi
    mockLocations = <Location>[/* some mock locations */];

    // Necessary to define a stub for the mock method that returns a generic type.
    when(() => mockLocationsApi.searchChargeLocation(query))
        .thenAnswer((invocation) async => mockLocations);
  });

  test('getChargeLocations returns a list of locations', () async {
    // Arrange
    // You might want to have some arrangement here if needed.

    // Act
    final result = await locationsRepository.getChargeLocations(query: query);

    // Assert
    expect(result, equals(mockLocations));
    verify(() => mockLocationsApi.searchChargeLocation(query)).called(1);
  });
}
