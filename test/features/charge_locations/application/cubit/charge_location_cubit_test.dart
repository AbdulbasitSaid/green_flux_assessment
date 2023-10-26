import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/application/cubit/charge_location_cubit.dart';
import 'package:green_flux_assessment/features/charge_locations/data/locations_api.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/location.dart';
import 'package:green_flux_assessment/features/charge_locations/domain/locations_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationsRepository extends Mock implements LocationsRepository {}

void main() {
  group('ChargeLocationCubit', () {
    late MockLocationsRepository mockLocationsRepository;

    setUp(() {
      mockLocationsRepository = MockLocationsRepository();
      when(() => mockLocationsRepository.getChargeLocations(query: 'amsterdam'))
          .thenAnswer((_) async => [
                const Location(
                    address: '',
                    city: '',
                    country: '',
                    latitude: null,
                    longitude: null)
              ]);
    });

    blocTest<ChargeLocationCubit, ChargeLocationState>(
      'emits [loading, loaded] when searchLocation is successful',
      build: () => ChargeLocationCubit(mockLocationsRepository),
      act: (cubit) => cubit.searchLocation(query: 'amsterdam'),
      expect: () => <ChargeLocationState>[
        const ChargeLocationState.loading(),
        const ChargeLocationState.loaded(locations: [
          Location(
              address: '',
              city: '',
              country: '',
              latitude: null,
              longitude: null)
        ]),
      ],
    );

    blocTest<ChargeLocationCubit, ChargeLocationState>(
      "emits [loading, failed] when HttpBadRequest occurs ",
      build: () => ChargeLocationCubit(mockLocationsRepository),
      act: (cubit) => cubit.searchLocation(query: 'amsterdam'),
      setUp: () => when(() =>
              mockLocationsRepository.getChargeLocations(query: 'amsterdam'))
          .thenThrow(HttpBadRequest()),
      expect: () => <ChargeLocationState>[
        const ChargeLocationState.loading(),
        const ChargeLocationState.failed(errorMessage: 'Bad Request')
      ],
    );
    blocTest<ChargeLocationCubit, ChargeLocationState>(
      "emits [loading, failed] when HttpServerError occurs ",
      build: () => ChargeLocationCubit(mockLocationsRepository),
      act: (cubit) => cubit.searchLocation(query: 'amsterdam'),
      setUp: () => when(() =>
              mockLocationsRepository.getChargeLocations(query: 'amsterdam'))
          .thenThrow(HttpServerError()),
      expect: () => <ChargeLocationState>[
        const ChargeLocationState.loading(),
        const ChargeLocationState.failed(
            errorMessage: 'Error '
                'from the Server')
      ],
    );
    blocTest<ChargeLocationCubit, ChargeLocationState>(
      "emits [loading, failed] when and uncaught Exception occurs ",
      build: () => ChargeLocationCubit(mockLocationsRepository),
      act: (cubit) => cubit.searchLocation(query: 'amsterdam'),
      setUp: () => when(() =>
              mockLocationsRepository.getChargeLocations(query: 'amsterdam'))
          .thenThrow(Exception()),
      expect: () => <ChargeLocationState>[
        const ChargeLocationState.loading(),
        const ChargeLocationState.failed(
            errorMessage: 'An '
                'unexpected error occurred')
      ],
    );
  });
}
