import 'package:flutter_test/flutter_test.dart';
import 'package:green_flux_assessment/features/charge_locations/data/models/charge_location.dart';

void main() {
  group('Evses', () {
    const evses1 = Evses(
      evseId: '123',
      status: 'available',
      connectorType: 'Type2',
      powerType: 'AC',
    );

    const evses2 = Evses(
      evseId: '123',
      status: 'available',
      connectorType: 'Type2',
      powerType: 'AC',
    );

    const evses3 = Evses(
      evseId: '456',
      status: 'occupied',
      connectorType: 'CCS',
      powerType: 'DC',
    );

    test('should have correct props', () {
      expect(evses1.props, [
        evses1.evseId,
        evses1.status,
        evses1.connectorType,
        evses1.powerType
      ]);
    });

    test('should compare correctly', () {
      expect(evses1 == evses2, true);
      expect(evses1 == evses3, false);
    });

    test('should convert to string correctly', () {
      expect(evses1.toString(),
          'Evses({evseId:123, status:available, connectorType:Type2, powerType: AC })');
    });

    test('should parse from json correctly', () {
      final json = {
        'evseId': '123',
        'status': 'available',
        'connectorType': 'Type2',
        'powerType': 'AC',
      };

      expect(Evses.fromJson(json), evses1);
    });
  });
}
