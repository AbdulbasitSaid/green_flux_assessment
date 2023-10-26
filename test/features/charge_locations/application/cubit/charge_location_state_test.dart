import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/application/cubit/charge_location_cubit.dart';

void main() {
  group('ChargeLocationState', () {
    test('supports value comparisons', () {
      expect(const ChargeLocationState.initial(),
          const ChargeLocationState.initial());
      expect(const ChargeLocationState.loading(),
          const ChargeLocationState.loading());
      expect(const ChargeLocationState.failed(errorMessage: 'Error'),
          const ChargeLocationState.failed(errorMessage: 'Error'));
      expect(const ChargeLocationState.loaded(locations: []),
          const ChargeLocationState.loaded(locations: []));
    });
  });
}
