import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/charge_location.dart';

void main() {
  group('Location', () {
    final evsesList = [
      const Evses(
          evseId: '123',
          status: 'available',
          connectorType: 'Type2',
          powerType: 'AC'),
    ];

    final location1 = Location(
      address: '123 Main St',
      city: 'Springfield',
      country: 'USA',
      latitude: 37.7749,
      longitude: -122.4194,
      evses: evsesList,
    );

    final location2 = Location(
      address: '123 Main St',
      city: 'Springfield',
      country: 'USA',
      latitude: 37.7749,
      longitude: -122.4194,
      evses: evsesList,
    );

    const location3 = Location(
      address: '456 Elm St',
      city: 'Shelbyville',
      country: 'USA',
      latitude: 34.0522,
      longitude: -118.2437,
    );

    test('should have correct props', () {
      expect(location1.props, [
        location1.address,
        location1.city,
        location1.country,
        location1.latitude,
        location1.longitude,
        location1.evses,
      ]);
    });

    test('should compare correctly', () {
      expect(location1 == location2, true);
      expect(location1 == location3, false);
    });

    test('should convert to string correctly', () {
      expect(location1.toString(),
          'Location({address:123 Main St, city:Springfield, country:USA, latitude:37.7749, longitude:-122.4194, evses:$evsesList})');
    });

    test('should parse from json correctly', () {
      final json = {
        'address': '123 Main St',
        'city': 'Springfield',
        'country': 'USA',
        'latitude': 37.7749,
        'longitude': -122.4194,
        'evses': [
          {
            'evseId': '123',
            'status': 'available',
            'connectorType': 'Type2',
            'powerType': 'AC'
          }
        ],
      };

      expect(Location.fromJson(json), location1);
    });
  });
}
